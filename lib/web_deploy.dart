import 'dart:io';

import 'package:yaml/yaml.dart';

/// Get pubspec [YamlMap].
Future<YamlMap> _getPubspecYamlMap() async {
  final pubspecYamlFile = File('pubspec.yaml');

  if (!pubspecYamlFile.existsSync()) {
    throw ArgumentError('Pubspec file not found', 'pubspec.yaml');
  }

  final pubspecYamlString = await pubspecYamlFile.readAsString();
  return loadYaml(pubspecYamlString) as YamlMap;
}

/// Get project name from pubspec file.
Future<String> _getProjectName() async {
  final pubspecYamlMap = await _getPubspecYamlMap();
  final projectName = pubspecYamlMap['name'] as String?;

  if (projectName == null) {
    throw ArgumentError('Project name missing from pubspec.yaml', 'name');
  }

  return projectName;
}

/// Build the web release variant.
Future<void> buildForWeb() async {
  final name = await _getProjectName();

  await Process.run('flutter', [
    'build',
    'web',
    '--release',
    '--web-renderer',
    'html',
    '--base-href',
    '/$name/build/web/',
  ]);

  final indexFile = File('index.html');
  await indexFile.writeAsString(
    '<meta http-equiv="refresh" content="0; '
        'url=./build/web/index.html">',
  );
}
