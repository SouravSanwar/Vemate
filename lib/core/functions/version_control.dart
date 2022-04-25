import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/instruction/instruction_screen.dart';
import 'package:ketemaa/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionControl {
  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    packageInfo = info;
    print(packageInfo.buildNumber);
  }

  static void fetchConfig() async {
    await remoteConfig.fetchAndActivate();
  }

  static Future<void> initConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
              10), // fetch parameters will be cached for a maximum of 1 hour
    ));
    if (remoteConfig.getInt("version_code").toString().isNotEmpty) {
      prefs!.getString('token') != null
          ? Get.to(() => ControllerPage())
          : Get.to(() => const InstructionsScreen());
    }
    /*if (remoteConfig.getInt("version_code").toString().isNotEmpty) {
      prefs!.getString('token') != null
          ? Get.to(() => ControllerPage())
          : Get.to(() => const AuthInitialPage());
    }*/

    fetchConfig();
  }
}
