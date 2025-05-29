import 'package:git_conventional_commit/client/baseten_client.dart';
import 'package:git_conventional_commit/console/arguments.dart';
import 'package:git_conventional_commit/client/git_commit_client.dart';
import 'package:git_conventional_commit/client/git_commit.dart';
import 'package:git_conventional_commit/utils.dart';
import 'package:vader_console/vader_console.dart';

void main(List<String> args) {
  runCliApp(
    arguments: args,
    commands: commands,
    parser: CliArguments.parse,
    app: (args) async {
      await checkStagingArea();

      final commit = GitCommit(
        amend: args.amend,
        isBreaking: args.isBreakingChange,
        type: args.commitType,
        scope: args.commitScope,
        message: args.userMessage,
      );

      // Setup clients
      final gitClient = GitCommitClient();
      final aiClient = BasetenClient();
      bool isGenerated = false;

      // Generate git message with AI
      if (commit.message == null) {
        isGenerated = await gitClient.generateWithAi(aiClient);
        if (!isGenerated) {
          if (showQuestion('Do you want to generate commit message with AI again?')) {
            isGenerated = await gitClient.generateWithAi(aiClient);
          }
        }
      }

      // Make git commit
      if (!isGenerated) gitClient.generate(commit);
      await gitClient.makeCommit();
    },
  );
}