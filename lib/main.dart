import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_routes/app_routes.dart';
import 'core/Provider/getData.dart';
import 'core/Provider/postFile.dart';
import 'core/language/language.dart';
import 'core/utilities/app_colors/app_colors.dart';
import 'core/utilities/app_theme/app_theme.dart';
import 'package:flutter/services.dart';

SharedPreferences? prefs;
SharedPreferences? prefs1;

bool filterOn = false;
bool? darkMode = false;

int? mode;

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetData()),
        ChangeNotifierProvider(create: (_) => PostData()),
        ChangeNotifierProvider(create: (_) => PostFile()),
        ChangeNotifierProvider(create: (_) => AppUpdate()),
        ChangeNotifierProvider(create: (_) => AppColors()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<AppColors>(context);

    SharedPreferences.getInstance().then((pr) {
      prefs = pr;

      mode = prefs?.getInt('mode');
      appStyleMode.switchMode();
    });

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData(),
          getPages: AppRoutes.appRoutesList(),
          //home: InstructionsScreen(),
          initialRoute: AppRoutes.INITAL_SCREEN,
          translations: Language(),
          locale: const Locale('en', 'US'),
        );
      },
    );
  }
}
