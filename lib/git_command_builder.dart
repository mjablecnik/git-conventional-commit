import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:git_conventional_commit/app_info.dart';
import 'package:git_conventional_commit/commit_type.dart';

class GitCommandBuilder {
  String buildCommitMessage({String? type, String? message, String? scope, required bool isBreaking}) {
    final sb = StringBuffer();

    if (!_isConventionalCommit) return message ?? _getMessage();

    scope = scope ?? _getScope();

    CommitType commitType;

    if (type == null) {
      commitType = _getType();
    } else {
      try {
        commitType = CommitType.values.byName(type);
      } catch (e) {
        print('You wrote a wrong commit type');
        commitType = _getType();
      }
    }

    sb.write(commitType.name);

    if (scope != null && scope.isNotEmpty) sb.write("($scope)");
    if (isBreaking || _getBreakingChange()) sb.write("!");

    sb.write(": ");
    message = message ?? _getMessage();

    if (message.split(" ").first.toLowerCase() == commitType.name.toLowerCase()) {
      message = message.split(" ").skip(1).join(" ");
    }

    sb.write(message.replaceRange(0, 1, message[0].toLowerCase()));

    return sb.toString();
  }

  String _getMessage() {
    print("\nWrite commit message:");
    final String? result = stdin.readLineSync();
    return result == null || result.isEmpty ? _getMessage() : result;
  }

  String? _getScope() {
    print("\nAdd scope:");
    final scopes = AppInfo().gitScope;
    final result = Menu([
      'none',
      'custom',
      ...scopes.map((e) => e.toLowerCase()),
    ]).choose().toString();

    if (result == 'none') {
      return null;
    } else if (result == 'custom') {
      print("\nWrite custom scope:");
      return stdin.readLineSync();
    } else {
      return result;
    }
  }

  bool _getBreakingChange() {
    stdout.write("\nHas this commit some breaking change? (y/N) ");
    final response = stdin.readLineSync();
    return response?.toLowerCase() == 'yes' || response == 'Y' || response == 'y';
  }

  bool get _isConventionalCommit {
    return AppInfo().gitScopeFileExists ? true : _getConventionalQuestion();
  }

  bool _getConventionalQuestion() {
    stdout.write("\nDo you really want to create conventional commit? (y/N) ");
    final response = stdin.readLineSync();
    return response?.toLowerCase() == 'yes' || response == 'Y' || response == 'y';
  }

  CommitType _getType() {
    print('\nSelect collection of type:');
    var result = Menu(CommitTypeCollection.values.map(
      (e) => '${e.name} -- ${e.types.map((t) => t.name).join(', ')}',
    )).choose();

    print('\nSelect type:');

    final selectedCollection = CommitTypeCollection.values.byName(result.value.split(' -- ').first);
    result = Menu([
      ...selectedCollection.types.map((t) => '${t.name} -- ${t.description}'),
      '',
      'back -- Go back to previous step',
    ]).choose();

    CommitType selectedType;
    try {
      selectedType = CommitType.values.byName(result.value.split(' -- ').first);
    } catch (e) {
      selectedType = _getType();
    }

    return selectedType;
  }
}
