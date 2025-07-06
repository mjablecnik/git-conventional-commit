import 'package:ai_clients/ai_clients.dart';

class GitCommitAgent {
  const GitCommitAgent({required this.client});

  final AiClient client;

  final gitCommitPrompt = """
Based on the following `git diff` output, generate a single commit message following the Conventional Commits specification.

Rules:
- The commit message must include only the commit type and a short description (e.g., `feat: add login button to header`).
- Do not include any introductory or explanatory text. The output must be the commit message only—nothing else.
- Use the imperative mood or present tense, without a period at the end.
- Choose the commit type based on the content of the diff from the following list:
  - ux, feat, docs, i18n, perf, style, refactor, test, mock, fix, hotfix, security, ci, env, dep, config, lint, legal, build, chore, wip, temp, merge, revert
- If the change fits multiple categories, choose the most significant one.
- If the diff includes unrelated changes (e.g., documentation and code), select the most relevant type or split it into multiple commits (if supported).
- The commit message should be in English.
  """;


  Future<String> getCommit(String gitDiff) async {
    final result = await client.simpleQuery(
      prompt: gitCommitPrompt,
      contexts: [Context(name: 'git diff', value: gitDiff)],
    );

    return result;
  }
}
