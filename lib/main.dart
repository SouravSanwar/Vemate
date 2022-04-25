import 'dart:async';
/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/instruction/instruction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_routes/app_routes.dart';
import 'core/Provider/getData.dart';
import 'core/Provider/postFile.dart';
import 'core/language/language.dart';
import 'core/utilities/app_theme/app_theme.dart';

SharedPreferences? prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetData()),
        ChangeNotifierProvider(create: (_) => PostData()),
        ChangeNotifierProvider(create: (_) => PostFile()),
        ChangeNotifierProvider(create: (_) => AppUpdate()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SharedPreferenceController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      getPages: AppRoutes.appRoutesList(),
      home: InstructionsScreen(),
      translations: Language(),
      locale: const Locale('en', 'US'),
    );
  }
}
