import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/Provider/postFile.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/shimmer/progress_bar.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/features/profile/_controller/profile_controller.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../core/language/language_string.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? imageFile;
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  final FileType _pickingType = FileType.image;
  List<File>? files = <File>[];
  List<File>? fileList = <File>[];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  PostData? postData;

  PostFile? postFile;

  GetData? getData;

  ProfileModel? profileModel = Get.arguments;

  @override
  void initState() {
    Get.put(ProfileController());

    ProfileController.to.userNameTextFiledController.text =
        profileModel!.nickname!;
    ProfileController.to.emailTextFiledController.text = profileModel!.email!;

    postFile = Provider.of<PostFile>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);

    super.initState();
  }

  takeImage() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            elevation: 5,
            backgroundColor: AppColors.graphCard,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture with Camera",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Inter',
                  ),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select From Gallery",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Inter',
                  ),
                ),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    _cropImage(pickedFile!.path);
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    _cropImage(pickedFile!.path);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxWidth: 1080, maxHeight: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
    print("&&&&&&&*******&&&&&" + imageFile.toString());

    _pickFiles();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            AppSpaces.spaces_height_40,
            const BackPreviousScreen(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AppSpaces.spaces_height_50,
                  InkWell(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * .25,
                          backgroundColor: AppColors.textColor,
                          backgroundImage: profileModel!.profileImage == null
                              ? imageFile == null
                                  ? null
                                  : Image.file(imageFile!).image
                              : imageFile != null
                                  ? Image.file(imageFile!).image
                                  : NetworkImage(
                                      Urls.mainUrl +
                                          data.profileModel!.profileImage!
                                              .mobile!.src
                                              .toString(),
                                    ),
                          child: profileModel!.profileImage == null
                              ? imageFile != null
                                  ? Container()
                                  : Shader(
                                      icon: const Icon(
                                        Icons.person_add_alt_1_rounded,
                                        size: 100,
                                      ),
                                    )
                              : null,
                        ),
                        Positioned(
                          bottom: Get.height * .01,
                          right: Get.height * .0001,
                          child: RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                imageFile == null;
                                takeImage();

                              });

                            },
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            child: Shader(
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 30,
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            shape: const CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Get.height * .08,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Username",
                      style: TextStyle(fontSize: 18.sp,fontFamily: 'Inter'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  AppSpaces.spaces_height_5,
                  TextInputField(
                    labelText: AppLanguageString.USERNAME.tr,
                    height: Get.height * .04,
                    textType: TextInputType.emailAddress,
                    controller:
                        ProfileController.to.userNameTextFiledController,
                  ),

                  SizedBox(
                    height: Get.height * .022,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                        "Email",
                      style: TextStyle(fontSize: 18.sp,fontFamily: 'Inter'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  AppSpaces.spaces_height_5,
                  TextInputField(
                    labelText: AppLanguageString.EMAIL.tr,
                    height: Get.height * .04,
                    textType: TextInputType.emailAddress,
                    controller: ProfileController.to.emailTextFiledController,
                  ),
                  SizedBox(
                    height: Get.height * .07,
                  ),
                  CustomButtons(
                    width: Get.width * .8,
                    height: Get.height * .065,
                    onTap: () {
                      var body = {
                        "nickname": ProfileController
                            .to.userNameTextFiledController.text,
                        "email":
                            ProfileController.to.emailTextFiledController.text
                      };

                      Map<String, String> requestHeadersWithToken = {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                        'Authorization': 'token ${prefs!.getString('token')}',
                      };
                      postData!.updateProfile(
                          context, body, requestHeadersWithToken);
                    },
                    text: AppLanguageString.UPDATE_INFO.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Future _pickFiles() async {
    _resetState();
    try {
      files!.add(imageFile!);
      fileList!.addAll(files!);

      List<String> fileKey = [];

      for (int i = 0; i < fileList!.length; i++) {
        fileKey.add('image');
      }
      Map<String, String>? body = {};

      postFile!.requestWithFile(
        context,
        url: Urls.updateProfilePic,
        method: Method.POST,
        body: body,
        fileKey: fileKey,
        files: fileList,
      );

      printInfo(info: 'Files' + fileList.toString());
      printInfo(info: 'Files' + _paths.toString());
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }
}
