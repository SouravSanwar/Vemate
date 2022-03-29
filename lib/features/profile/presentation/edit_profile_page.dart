import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/language/language_string.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/password_input_field.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';
import '../../auth/presentation/sign_in/_controller/sign_in_controller.dart';
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Imagepicker
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Color(0xff272E49),

            body: ListView(

              padding: EdgeInsets.symmetric(horizontal: 20),
              physics: BouncingScrollPhysics(),
              children: [

                const SizedBox(
                  height: 100,
                ),
                InkWell(

                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * .25,
                            backgroundColor: Color(0xff2F3758),
                            backgroundImage: imageXFile == null
                                ? null
                                : FileImage(File(imageXFile!.path)),
                            child: imageXFile == null
                                ? Shader(
                              icon: Icon(Icons.person_add_alt_1_rounded,size: 100,),
                            )
                                : null,
                          ),

                        ),
                        Positioned(
                            bottom: 10,
                            right: 55,
                            child: RawMaterialButton(
                              onPressed: () {
                                _getImage();
                              },
                              elevation: 2.0,
                              fillColor: Color(0xFFF5F6F9),
                              child: Shader(
                                icon: Icon(Icons.camera_alt,size: 20,),
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextInputField(
                  labelText: AppLanguageString.USERNAME.tr,
                  height: .09,
                  textType: TextInputType.emailAddress,
                  controller: SigninController.to.emailTextFiledController,
                ),
                AppSpaces.spaces_height_5,
                TextInputField(
                  labelText: AppLanguageString.EMAIL.tr,
                  height: .09,
                  textType: TextInputType.emailAddress,
                  controller: SigninController.to.emailTextFiledController,
                ),
                AppSpaces.spaces_height_5,
               PasswordInputField(
                labelText: AppLanguageString.PASSWORD.tr,
                height: .09,
                textType: TextInputType.text,
                controller: SigninController.to.passwordTextFiledController),

                const SizedBox(
                  height: 50,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: AppColors.purpleGradient, // set border width
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20.0)), // set rounded corner radius
                  ),
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      AppLanguageString.UPDATE_INFO.toUpperCase(),
                      style:
                      Get.textTheme.button!.copyWith(color: Colors.white),
                    ),
                  ),
                ),


              ],
            ),
    );
  }

      }

