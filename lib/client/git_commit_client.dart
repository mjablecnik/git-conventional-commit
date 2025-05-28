import 'dart:io';

import 'package:git_conventional_commit/builder/commit_type.dart';
import 'package:git_conventional_commit/builder/git_commit_message_builder.dart';
import 'package:git_conventional_commit/client/ai_client.dart';
import 'package:git_conventional_commit/client/git_commit.dart';
import 'package:git_conventional_commit/utils.dart';

class GitCommitClient {
  List<String> gitArgs = [];
  String commitMessage = "";

  void generate(GitCommit commit) {
    if (commit.amend) {
      gitArgs = ['commit', '--amend'];
    } else {
      commitMessage = GitCommitMessageBuilder().build(
        type: commit.type,
        message: commit.message,
        scope: commit.scope,
        isBreaking: commit.isBreaking,
      );
      gitArgs = ['commit', '-m', commitMessage];
    }
  }

  Future<bool> generateWithAi(AiClient aiClient) async {
    final diff = await getDiff();

    final rules = CommitType.values.map((e) => '${e.name} (${e.description})').join(", ");

    commitMessage = await aiClient.query(
      system: 'Jsi zkušený vývojář co umí pracovat s gitem',
      prompt:
          'Vytvoř commit message v angličtině pro následující změny v gitu. '
          'Řiď se pravidly Conventional Commits. '
          'Používej následující typy commitů: $rules.',
      context: diff,
    );

    return _confirmCommitMessage();
  }

  Future<void> makeCommit() async {
    final p = await Process.start('git', gitArgs);
    await stdout.addStream(p.stdout);

    print("\nNew commit was written: \n\n\"$commitMessage\"");
  }

  bool _confirmCommitMessage() {
    print('\n$commitMessage');
    final result = showQuestion('Do you want to use this commit message?');
    if (result) {
      gitArgs = ['commit', '-m', commitMessage];
    }
    return result;
  }
}
