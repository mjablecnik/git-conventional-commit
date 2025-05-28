import 'dart:io';

import 'package:git_conventional_commit/builder/git_commit_message_builder.dart';
import 'package:git_conventional_commit/client/git_commit.dart';

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

  Future<void> run() async {
    final p = await Process.start('git', gitArgs);
    await stdout.addStream(p.stdout);

    print("\nNew commit was written: \"$commitMessage\"");
  }
}
