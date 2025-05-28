# git-conventional-commit

Simple command-line tool to create your conventional commits.

## Requirements

- Dart SDK >= 3.8.0
- Unix-like OS (Linux, macOS)
- [Taskfile](https://taskfile.dev/) (optional, for easier build/install)

## Features

- Generate [Conventional Commits](https://www.conventionalcommits.org/) easily from the command line
- Supports commit types, messages, scopes, breaking changes, and amend
- Can be run directly with Dart or as a compiled executable
- Simple CLI interface with helpful flags

## Install

### Using Taskfile (recommended)

```sh
task install
```
This will build the executable and copy it to `~/.local/bin/` (make sure this directory is in your `$PATH`).

### Manual

```sh
dart compile exe lib/main.dart -o bin/git-conventional-commit
cp bin/git-conventional-commit ~/.local/bin/
```

## Usage

After installation, you can run:

```sh
git-conventional-commit [options]
```

Or, without installing globally:

```sh
dart lib/main.dart [options]
```

### CLI Options

```
-t, --type        Commit type.
-m, --message     Commit message.
-s, --scope       Commit scope.
-b, --breaking    Set commit as breaking change.
    --amend       Change last commit.
-h, --help        Print this usage information.
-V, --verbose     Show additional command output.
-v, --version     Print the tool version.
```

### Examples

Create a feature commit with a scope and breaking change:
```sh
git-conventional-commit -t feat -m "Add new feature" -b -s '#1234'
```

Create a simple commit:
```sh
git-conventional-commit -m "Add new feature"
```

Amend the last commit:
```sh
git-conventional-commit --amend -m "Fix typo"
```

## Special thanks

- [Dart](https://dart.dev/): Client-optimized language for fast apps on any platform.
- [vader_console](https://pub.dev/packages/vader_console): Console utilities for Dart CLI applications.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author

👤 **Martin Jablečník**

* Website: [martin-jablecnik.cz](https://www.martin-jablecnik.cz)
* Github: [@mjablecnik](https://github.com/mjablecnik)
* Blog: [dev.to/mjablecnik](https://dev.to/mjablecnik)

## Show your support

Give a ⭐️ if this project helped you!

<a href="https://www.patreon.com/mjablecnik">
  <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

## 📝 License

Copyright © 2024 [Martin Jablečník](https://github.com/mjablecnik).  
This project is [GNU GPLv3 License](https://choosealicense.com/licenses/gpl-3.0/) licensed.
