import 'dart:io';

import 'package:collection/collection.dart';
import 'package:yaml/yaml.dart';

class WebDeploy {
  Future<YamlMap> _loadFromPubspec() async {
    final pubspec = File('pubspec.yaml');

    final pubspecExists = await pubspec.exists();
    if (!pubspecExists) {
      stderr.writeln('Error: pubspec.yaml does not exist');
      exit(1);
    }

    final pubspecContents = await pubspec.readAsString();
    final pubspecMap = loadYaml(pubspecContents);

    if (pubspecMap['name'] == null) {
      stderr.writeln('Error: no name in pubspec.yaml');
      exit(1);
    }

    if (pubspecMap['dev_dependencies'] == null) {
      stderr.writeln('Error: dev_dependencies does not exist in pubspec.yaml');
      exit(1);
    }

    if (pubspecMap['dev_dependencies']['web_deploy'] == null) {
      stderr.writeln('Error: web_deploy does not exist in dev_dependencies');
      exit(1);
    }

    return pubspecMap;
  }

  Future<void> buildForWeb() async {
    stdout.writeln(' * Parsing pubspec.yaml');
    final pubspecMap = await _loadFromPubspec();

    final String name = pubspecMap['name']!;
    final bool release = pubspecMap['dev_dependencies']['web_deploy']['release'] ?? true;
    final String webRenderer = pubspecMap['dev_dependencies']['web_deploy']['web_renderer'] ?? 'html';
    final bool indexRedirect = pubspecMap['dev_dependencies']['web_deploy']['index_redirect'] ?? true;

    stdout.writeln(' * Building for web');
    await Process.run(
      'flutter',
      [
        'build',
        'web',
        '--web-renderer', webRenderer,
        release ? '--release' : null,
        '--base-href', '/$name/build/web/'
      ].whereNotNull().toList(),
    );

    if (indexRedirect) {
      stdout.writeln(' * Creating index.html redirect');
      final indexFile = File('index.html');
      await indexFile.writeAsString('<meta http-equiv="refresh" content="0; url=./build/web/index.html">');
    }

    stdout.writeln(' * Finished!');
  }
}
