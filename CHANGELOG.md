## 1.4.1

- Refactor: Simplify AI client implementation by using the `ai_clients` package

## 1.4.0

- Feature: Add TogetherClient implementation for AI-powered commit message generation

## 1.3.0

- Feature: Implement BasetenClient for AI-powered commit message generation
- Feature: Allow passing apiKey to AiClient and ChatGptClient constructors
- Refactor: Rename ChatGptClient to OpenAiClient and update references
- Refactor: Replace OpenAI client with Baseten client in main function
- Refactor: Set Dio baseUrl and update endpoint usage in ChatGptClient
- Performance: Update commit message prompt

## 1.2.1

- Refactor: Remove unnecessary return values from generate method in GitCommitClient
- Dependency: Remove dotenv dependency and use only environment variables

## 1.2.0

- Feature: Add AI-powered commit message generation and interactive confirmation
- Feature: Add ChatGptClient
- Feature: Extract interactive console question logic to utility function
- Documentation: Document optional AI commit message generation in README
- Dependency: Add dotenv and dio dependencies
- Build: Release version 1.2.0 and update binary artifact

## 1.1.0

- Feature: Add GitCommitClient
- Refactor: Improve git command builder
- Refactor: Reorganize project structure
- Configuration: Add taskfile.yaml
- Configuration: Update .gitscope
- Dependency: Add vader_console
- Dependency: Upgrade dependencies
- Documentation: Update README.md

## 1.0.1

- Fix: Remove first word from git message if is same as commit type

## 1.0.0

- Initial version.
