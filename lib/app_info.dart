import 'dart:io';

class AppInfo {
  List<String> get gitScope {
    String? rootPath = _projectRoot(file: gitScopeFileName);
    if (rootPath == null) return [];

    final file = File('$rootPath/$gitScopeFileName');
    return file.readAsLinesSync();
  }

  String? _projectRoot({required String file}) {
    Directory root = Directory.current;

    while (root.path.isNotEmpty && !File('${root.path}/$file').existsSync()) {
      if (root.path == '/') return null;
      root = root.parent;
    }

    return root.path;
  }

  String gitScopeFileName = '.gitscope';

  bool get gitScopeFileExists => _projectRoot(file: gitScopeFileName) != null;

  String get version => "1.0.1";

  String get name => "git_conventional_commit";
}
