import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/Provider/postFile.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/profile/_controller/profile_controller.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../core/language/language_string.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_dimension/app_dimension.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            AppSpaces.spaces_height_30,
            Padding(
              padding: EdgeInsets.only(
                left: AppDimension.padding_8,
                right: AppDimension.padding_8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Shader(
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
            ),
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
                          backgroundColor: const Color(0xff2F3758),
                          backgroundImage: profileModel!.profileImage == null
                              ? null
                              : NetworkImage(
                                  Urls.mainUrl +
                                      data.profileModel!.profileImage!.mobile!
                                          .src
                                          .toString(),
                                ),
                          child: profileModel!.profileImage == null
                              ? Shader(
                                  icon: const Icon(
                                    Icons.person_add_alt_1_rounded,
                                    size: 100,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: Get.height * .01,
                          right: Get.height * .055,
                          child: RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                _pickFiles();
                              });
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .08,
                  ),
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
                  TextInputField(
                    labelText: AppLanguageString.EMAIL.tr,
                    height: Get.height * .04,
                    textType: TextInputType.emailAddress,
                    controller: ProfileController.to.emailTextFiledController,
                  ),
                  SizedBox(
                    height: Get.height * .07,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleGradient, // set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(25.0)), // set rounded corner radius
                    ),
                    child: TextButton(
                      onPressed: () {
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
                      child: Text(
                        AppLanguageString.UPDATE_INFO.toUpperCase(),
                        style:
                            Get.textTheme.button!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
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
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

      files!.add(File(_paths![0].path!));
      fileList!.addAll(files!);

      List<String> fileKey = [];

      for (int i = 0; i < fileList!.length; i++) {
        fileKey.add('image');
      }
      Map<String, String>? body = {};

      postFile!.requestWithFile(context,
          url: Urls.updateProfilePic,
          method: Method.POST,
          body: body,
          fileKey: fileKey,
          files: fileList);

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
