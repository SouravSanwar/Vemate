import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/features/profile/_controller/profile_controller.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:provider/provider.dart';

import '../../../core/language/language_string.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_dimension/app_dimension.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/password_input_field.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';
import '../../auth/presentation/sign_in/_controller/sign_in_controller.dart';
import '../widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //Imagepicker
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String sellerImageUrl = "";

  PostData? postData;

  ProfileModel? profileModel = Get.arguments;

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  void initState() {
    Get.put(ProfileController());

    ProfileController.to.userNameTextFiledController.text =
        profileModel!.nickname!;
    ProfileController.to.emailTextFiledController.text = profileModel!.email!;

    postData = Provider.of<PostData>(context, listen: false);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff272E49),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          AppSpaces.spaces_height_100,
          InkWell(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * .25,
                  backgroundColor: const Color(0xff2F3758),
                  backgroundImage: imageXFile == null
                      ? null
                      : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ? Shader(
                          icon: const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 100,
                          ),
                        )
                      : null,
                ),
                Positioned(
                    bottom: 10,
                    right: 55,
                    child: RawMaterialButton(
                      onPressed: () {
                        _getImage();
                      },
                      elevation: 2.0,
                      fillColor: const Color(0xFFF5F6F9),
                      child: Shader(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          TextInputField(
            labelText: AppLanguageString.USERNAME.tr,
            height: .09,
            textType: TextInputType.emailAddress,
            controller: ProfileController.to.userNameTextFiledController,
          ),
          AppSpaces.spaces_height_10,
          TextInputField(
            labelText: AppLanguageString.EMAIL.tr,
            height: .09,
            textType: TextInputType.emailAddress,
            controller: ProfileController.to.emailTextFiledController,
          ),
          /*AppSpaces.spaces_height_10,
          PasswordInputField(
              labelText: AppLanguageString.PASSWORD.tr,
              height: .09,
              textType: TextInputType.text,
              controller: ProfileController.to.passwordTextFiledController),*/
          AppSpaces.spaces_height_50,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            width: Get.width,
            decoration: BoxDecoration(
              gradient: AppColors.purpleGradient, // set border width
              borderRadius: const BorderRadius.all(
                  Radius.circular(20.0)), // set rounded corner radius
            ),
            child: TextButton(
              onPressed: () {
                var body = {
                  "nickname": ProfileController.to.userNameTextFiledController.text,
                  "email": ProfileController.to.emailTextFiledController.text
                };
                postData!.updateProfile(context, body);
              },
              child: Text(
                AppLanguageString.UPDATE_INFO.toUpperCase(),
                style: Get.textTheme.button!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
