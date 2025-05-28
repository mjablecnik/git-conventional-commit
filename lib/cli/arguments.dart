import 'package:vader_console/vader_console.dart';

List<Command> commands = [
  Command(
    flag: 'm',
    name: 'message',
    commandType: CommandType.option,
    commandHelp: 'Print message.',
  ),
  Command(
    flag: 't',
    name: 'type',
    commandType: CommandType.option,
    commandHelp: 'Commit type.',
  ),
  Command(
    flag: 's',
    name: 'scope',
    commandType: CommandType.option,
    commandHelp: 'Commit scope.',
  ),
  Command(
    flag: 'b',
    name: 'breaking',
    commandType: CommandType.flag,
    commandHelp: 'Set commit as breaking change.',
  ),
  Command(
    name: 'amend',
    commandType: CommandType.flag,
    commandHelp: 'Change last commit.',
  ),
  ...CoreCommands.list,
];

class CliArguments extends Arguments {
  CliArguments({
    required super.showVersion,
    required super.showHelp,
    required super.isVerbose,
    required this.amend,
    required this.isBreakingChange,
    this.commitType,
    this.commitScope,
    this.commitMessage,
  });

  final bool amend;
  final bool isBreakingChange;
  final String? commitType;
  final String? commitScope;
  final String? commitMessage;

  static CliArguments parse(List<String> arguments, List<Command> commands) {
    final results = ArgumentParser(commands).parse(arguments);
    return CliArguments(
      showHelp: results.wasParsed(CoreCommands.help.name),
      isVerbose: results.wasParsed(CoreCommands.verbose.name),
      showVersion: results.wasParsed(CoreCommands.version.name),
      amend: results.wasParsed("amend"),
      isBreakingChange: results.wasParsed("breaking"),
      commitType: Arguments.getOptionOrNull(results, option: "type"),
      commitScope: Arguments.getOptionOrNull(results, option: "scope"),
      commitMessage: Arguments.getOptionOrNull(results, option: "message"),
    );
  }
}
