import 'dart:io';
import 'package:ai_clients/ai_clients.dart';

import 'package:git_conventional_commit/builder/git_commit_message_builder.dart';
import 'package:git_conventional_commit/git_commit/git_commit_model.dart';
import 'package:git_conventional_commit/git_commit/git_commit_agent.dart';
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
    final agent = GitCommitAgent(client: aiClient);
    commitMessage = await agent.getCommit(await getDiff());

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
