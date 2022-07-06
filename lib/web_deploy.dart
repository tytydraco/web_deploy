import 'dart:io';

import 'package:yaml/yaml.dart';

/// Deploy a flutter app for a web release. Configuration is done in the
/// `pubspec.yaml` file.
class WebDeploy {
  /// Return a [YamlMap] of the `pubspec.yaml` file after doing initial
  /// sanity checks.
  Future<YamlMap> _getPubspecYaml() async {
    final pubspec = File('pubspec.yaml');

    final pubspecExists = await pubspec.exists();
    if (!pubspecExists) {
      stderr.writeln('Error: pubspec.yaml does not exist');
      exit(1);
    }

    final pubspecContents = await pubspec.readAsString();
    final pubspecMap = loadYaml(pubspecContents);

    return pubspecMap;
  }

  /// Make sure the `pubspec.yaml` file is properly formatted.
  void _assertYamlSanity(YamlMap pubspecMap) {
    if (pubspecMap['name'] == null) {
      stderr.writeln('Error: no name in pubspec.yaml');
      exit(1);
    }
  }

  /// Build the web release variant using the configuration from
  /// `pubspec.yaml`.
  Future<void> buildForWeb() async {
    stdout.writeln(' * Parsing pubspec.yaml');
    final pubspecMap = await _getPubspecYaml();
    _assertYamlSanity(pubspecMap);

    final name = pubspecMap['name']!;

    // Default values
    var release = true;
    var webRenderer = 'html';
    var indexRedirect = true;

    // Overrides via pubspec.yaml config
    if (pubspecMap['web_deploy'] != null) {
      release = pubspecMap['web_deploy']['release'] ?? true;
      webRenderer = pubspecMap['web_deploy']['web_renderer'] ?? 'html';
      indexRedirect = pubspecMap['web_deploy']['index_redirect'] ?? true;
    }

    // Arguments to pass to the `flutter` command
    final arguments = [
      'build',
      'web',
      '--web-renderer',
      webRenderer,
      '--base-href',
      '/$name/build/web/'
    ];

    if (release) {
      arguments.add('--release');
    }

    stdout.writeln(' * Building for web');
    await Process.run('flutter', arguments);

    if (indexRedirect) {
      stdout.writeln(' * Creating index.html redirect');
      final indexFile = File('index.html');
      await indexFile.writeAsString('<meta http-equiv="refresh" content="0; '
          'url=./build/web/index.html">');
    }

    stdout.writeln(' * Finished!');
  }
}
