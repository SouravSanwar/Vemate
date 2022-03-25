import 'package:get/get.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/sign_in_email.dart';
import 'package:ketemaa/features/auth/presentation/sign_up/sign_up.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/splash_screen/splashscreen.dart';

import '../features/auth/reset_pass/reset_pass.dart';
import '../features/market/presentation/market.dart';

class AppRoutes {
  static String INITAL_SCREEN = "/";
  static String RESET_PASS = "/reset_pass";
  static String MAIN_AUTH = "/auth_initial_page";
  static String SIGN_UP = "/sign_up";
  static String SIGN_IN_EMAIL = "/sign_in_email";
  static String MARKET = "/market";
  static String CONTROLLER_PAGE = "/controller_page";
  static String PLACE_A_ADD = "/place_a_add";
  static String CATEGORYFORADD = "/place_a_add_category";
  static String PROPERTY_INITAIL_PAGE = "/property_Initial_Page";
  static String PROPERTY_AGENT_PAGE = "/property_Agent_Page";
  static String PROPERTY_LISTING_PAGE = "/property_Listing_Page";
  static String PROPERTY_DETAILS_PAGE = "/property_Details_Page";

  static List<GetPage> appRoutesList() {
    return [
      GetPage(
        name: INITAL_SCREEN,
        page: () => const SplashScreen(),
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
        name: SIGN_IN_EMAIL,
        page: () => const SignInWithEmail(),
      ),
      GetPage(
        name: MARKET,
        page: () => Market(),
      ),
      GetPage(
        name: CONTROLLER_PAGE,
        page: () => ControllerPage(),
      ),
    ];
  }
}
