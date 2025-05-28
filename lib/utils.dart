import 'dart:convert';
import 'dart:io';

bool showQuestion(String question) {
  stdout.write("\n$question (y/N) ");
  final response = stdin.readLineSync();
  return response?.toLowerCase() == 'yes' || response == 'Y' || response == 'y';
}

Future<String> getDiff() async {
  final p = await Process.start('git', ['diff', '--staged']);
  final output = await p.stdout.transform(utf8.decoder).join();
  return output;
}

Future<void> checkStagingArea() async {
  final diff = await getDiff();
  if (diff.isEmpty) {
    print("No changes to commit detected.");
    print("Please add some changes to the staging area and try again.");
    exit(1);
  }
}
