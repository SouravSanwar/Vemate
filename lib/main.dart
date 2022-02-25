import 'dart:async';
/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:provider/provider.dart';
import 'app_routes/app_routes.dart';
import 'core/Provider/getData.dart';
import 'core/graphQLConfig/graphql_config.dart';
import 'core/language/language.dart';
import 'core/utilities/app_theme/app_theme.dart';

//this is main class

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetData()),
      ],
      child: MyApp(),
    ),
  );
}

/*Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCQneEWwRwpA1srjWETD8VatowLTg9uYMY',
      appId: '1:262038982259:android:762524d18b11e2af626406',
      messagingSenderId: '262038982259',
      authDomain: 'react-native-firebase-testing.firebaseapp.com',
      projectId: 'ketemaa-6a075',
    ));
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(
      GraphQLProvider(
        client: AppGraphQLConfiguration.client,
        child: const CacheProvider(child: MyApp()),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SharedPreferenceController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      getPages: AppRoutes.AppRoutesList(),
      initialRoute: AppRoutes.MAIN_AUTH,
      //initialRoute: AppRoutes.PROPERTY_DETAILS_PAGE,
      translations: Language(),
      locale: const Locale('en', 'US'),
    );
  }
}
