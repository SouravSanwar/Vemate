import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_snack_bar.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/auth/data/RemoteDataRepo/auithenticiation_remote_repository.dart';
import 'package:ketemaa/features/auth/data/Repository/authentication_repository.dart';
import 'package:ketemaa/features/auth/data/models/user_login_model.dart';

class SigninController extends GetxController {
  static SigninController to = Get.find();

  //testFiledControllers

  TextEditingController userNameTextFiledController = TextEditingController();
  TextEditingController emailTextFiledController = TextEditingController();
  TextEditingController passwordTextFiledController = TextEditingController();

  //repo
  AuthRepository _authRepository = AuthenticationRemoteRepository();

  RxString responseValue = "".obs;
  RxBool loading = false.obs;

  Rx<UserLoginModel> userLogin = UserLoginModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  signIn({@required String? email, @required String? password}) async {
    loading.value = true;
    Either<QueryResult, Failure> _response = await _authRepository.signIn(
        email: userNameTextFiledController.text.toString(),
        password: passwordTextFiledController.text.toString());

    _response.fold((l) {
      loading.value = false;
      printInfo(info: " Success Data :: " + l.data.toString());
      try {
        print("The exception ............  ${l.exception}");
        userLogin.value = UserLoginModel.fromJson(l.data!);
        l.data == null
            ? ''
            : userLogin.value = UserLoginModel.fromJson(l.data!);
        if (userLogin.value.errorModel == null) {
          userLogin.value.loginUser!.success == true
              ? Get.toNamed(AppRoutes.CONTROLLER_PAGE)
              : printInfo(
              info:
              'False :${SigninController.to.userLogin.value.loginUser!
                  .success}');

          SharedPreferenceController.to
              .storeToken(userLogin.value.loginUser!.access);
          SharedPreferenceController.to.getToken();
        } else {
          print(
              "Error Model: ${userLogin.value.errorModel!.errors![0].message}");
        }
      } on Exception catch (e) {
        Right(DataNotFound());

        loading.value = false;
      }
      //printInfo(info: " Error Data :: " + l.data.toString());
    }, (r) {
/*      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: userLogin.value.errorModel!.errors![0].message);*/
      if (r is GQException) {
        printInfo(info: "Right error : ${r.errorMessage}");
        AppSnackBar.showErrorMessage(
            title: AppLanguageString.VALIDATION_FAILED.tr,
            body: r.operationException!.graphqlErrors[0].message);
      }
      loading.value = false;
    });
  }


  _signInValidation() {
    bool isValidated = false;

    if (userNameTextFiledController.text.isEmpty) {
      isValidated = false;
      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: AppLanguageString.EMAIL_IS_REQUIRED.tr);
      return false;
    } else if (passwordTextFiledController.text.isEmpty) {
      isValidated = false;
      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: AppLanguageString.PASSWORD_IS_REQUIRED.tr);
      return false;
    } else {
      isValidated = true;
    }

    return isValidated;
  }
}
