import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_snack_bar.dart';
import 'package:ketemaa/features/auth/data/RemoteDataRepo/auithenticiation_remote_repository.dart';
import 'package:ketemaa/features/auth/data/Repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController to = SignUpController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  AuthRepository _authRepository = AuthenticationRemoteRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  signUp() async {
    if (_signInValidation()) {
      Either<QueryResult, Failure> _response = await _authRepository.signUp(
          nameController.value.text,
          emailController.value.text,
          passwordController.value.text);

      _response.fold((l) {
       // print("Left response : ${l.}");


        //do logion

      }, (r) {
       // print("Left response : ${r}");
        if (r is GQException) {
          printInfo(info: "Right error : ${r.errorMessage}");
          AppSnackBar.showErrorMessage(
              title: AppLanguageString.VALIDATION_FAILED.tr,
              body: r.operationException!.graphqlErrors[0].message);
        }
      });
    }
  }

  _signInValidation() {
    bool isValidated = false;

    if (nameController.text.isEmpty) {
      isValidated = false;
      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: AppLanguageString.NAME_IS_REQUIRED.tr);
      return false;
    } else if (emailController.text.isEmpty) {
      isValidated = false;
      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: AppLanguageString.EMAIL_IS_REQUIRED.tr);
      return false;
    } else if (passwordController.text.isEmpty) {
      isValidated = false;

      AppSnackBar.showErrorMessage(
          title: AppLanguageString.VALIDATION_FAILED.tr,
          body: AppLanguageString.PASSWORD_IS_REQUIRED.tr);
    } else {
      isValidated = true;
    }

    print("IS validated ${isValidated}");
    return isValidated;
  }
}
