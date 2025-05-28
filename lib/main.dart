import 'package:git_conventional_commit/console/arguments.dart';
import 'package:git_conventional_commit/client/git_commit_client.dart';
import 'package:git_conventional_commit/client/git_commit.dart';
import 'package:vader_console/vader_console.dart';

void main(List<String> args) {
  runCliApp(
    arguments: args,
    commands: commands,
    parser: CliArguments.parse,
    app: (args) async {
      final commit = GitCommit(
        amend: args.amend,
        isBreaking: args.isBreakingChange,
        type: args.commitType,
        scope: args.commitScope,
        message: args.userMessage,
      );

      final client = GitCommitClient();
      client.generate(commit);
      await client.run();
    },
  );
}