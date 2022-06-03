import 'package:get/get.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_keys.dart';
import 'package:ketemaa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceController extends GetxController {
  static SharedPreferenceController to = Get.find();

  late SharedPreferences sharedPreferences;

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();

    super.onInit();
  }

  storeToken(var value) {
    sharedPreferences.setString(SharedPreferenceKey.token, value);
  }

  getToken() {
    var _token = sharedPreferences.getString(SharedPreferenceKey.token);
    var _isEmailVerified = sharedPreferences.getString(SharedPreferenceKey.token);
    printInfo(info: '$_token');
    return _token;
  }
}
