import 'package:web_deploy/web_deploy.dart';

Future<void> main() async {
  final webDeploy = WebDeploy();
  await webDeploy.buildForWeb();
}