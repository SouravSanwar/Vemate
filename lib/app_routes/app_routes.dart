import 'package:get/get.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_up/sign_up.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/splash_screen/splashscreen.dart';

import '../features/auth/reset_pass/reset_pass.dart';
import '../features/market/presentation/market.dart';

class AppRoutes {

  static String INITAL_SCREEN = "/";
  static String RESET_PASS = "/reset_pass";
  static String MAIN_AUTH = "/auth_initial_page";
  static String SIGN_UP = "/sign_up";
  static String MARKET = "/market";
  static String CONTROLLER_PAGE = "/controller_page";
  static String EDIT_PROFILE = "/edit_profile";

  static List<GetPage> appRoutesList() {
    return [
      GetPage(
        name: INITAL_SCREEN,
        page: () =>  SplashScreen(),
      ),
      GetPage(
        name: RESET_PASS,
        page: () => const ResetPass(),
      ),
      GetPage(
        name: MAIN_AUTH,
        page: () => const AuthInitialPage(),
      ),
      GetPage(
        name: SIGN_UP,
        page: () => const SignUp(),
      ),
      GetPage(
        name: MARKET,
        page: () => Market(),
      ),
      GetPage(
        name: CONTROLLER_PAGE,
        page: () => ControllerPage(),
      ),
      GetPage(
        name: EDIT_PROFILE,
        page: () => EditProfilePage(),
      ),
    ];
  }
}
