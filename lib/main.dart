import 'dart:io';

import 'package:git_conventional_commit/cli/arguments.dart';
import 'package:git_conventional_commit/builder/git_commit_message_builder.dart';
import 'package:vader_console/vader_console.dart';


void main(List<String> args) {
  runCliApp(
    arguments: args,
    commands: commands,
    parser: CliArguments.parse,
    app: (args) async {
      final List<String> gitArgs;
      String commitMessage = "";

      // Generate git command
      if (args.amend) {
        gitArgs = ['commit', '--amend'];
      } else {
        commitMessage = GitCommitMessageBuilder().build(
          type: args.commitType,
          message: args.userMessage,
          scope: args.commitScope,
          isBreaking: args.isBreakingChange,
        );
        gitArgs = ['commit', '-m', commitMessage];
      }

      print('');

      // Run generated git command
      final p = await Process.start('git', gitArgs);
      await stdout.addStream(p.stdout);

      print("\nNew commit was written: \"$commitMessage\"");
    },
  );
}
