import 'package:web_deploy/web_deploy.dart';

Future<void> main() async {
  await WebDeploy().buildForWeb();
}
