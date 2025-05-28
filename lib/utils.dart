import 'dart:io';

bool showQuestion(String question) {
  stdout.write("\n$question (y/N) ");
  final response = stdin.readLineSync();
  return response?.toLowerCase() == 'yes' || response == 'Y' || response == 'y';
}
