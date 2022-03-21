import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utilities/app_dimension/app_dimension.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../widgets/custom_text_field.dart';

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
                            backgroundColor: Colors.white,
                            backgroundImage: imageXFile == null
                                ? null
                                : FileImage(File(imageXFile!.path)),
                            child: imageXFile == null
                                ? Icon(
                              Icons.person_add_alt_1_rounded,
                              size: MediaQuery.of(context).size.width * .25,
                              color: Colors.green,
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
                              child: Icon(Icons.camera_alt_outlined, color: Colors.blue,size: 20,),
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
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Enter Your Name",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Enter Your Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "   Update Info   ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),

                  ),

                   AppSpaces.spaces_width_10,
                   Image.asset(
                        'assets/media/image/logout.png',
                        height: 20,
                        width: 20,
                     color: Colors.white,
                      ),

                  ],
                ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 10.0),
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
    );
  }

      }

