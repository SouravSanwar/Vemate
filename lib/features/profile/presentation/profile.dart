
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';
import 'package:ketemaa/features/profile/widgets/profile_divider.dart';

import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:image_picker/image_picker.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../auth/reset_pass/enter_new_pass.dart';
import '../../vault/vault.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    final _dialog = RatingDialog(
      title: Text('Rate Us On App Store or Play Store'),
      message: Text(''),
      image: Image.asset('slider/12.png'),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
        } else {
          StoreRedirect.redirect(
              androidAppId: 'com.xinxian.shop', iOSAppId: 'com.xinxian.shop');
        }
      },
    );

    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Color(0xff272E49),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimension.padding_8,
              right: AppDimension.padding_8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: Get.height*.05,),


                    Column(
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * .15,
                          backgroundColor: Color(0xff272E49),
                          backgroundImage: null,
                          child: Shader(
                            icon: Icon(Icons.person,size: 100,),
                          ),

                          // Icon(Icons.person,size: 100,)
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.greyWhite,
                            width: 2.0,
                          ),
                        ),
                      ),

                    SizedBox(height: Get.height*.01,),

                    const Text(
                        'User Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ]
                    ),

                   SizedBox(height: Get.height*.07,),
                    CustomProfileElements(
                        Icons.person,
                        "Profile Edit",
                            (){ Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => EditProfilePage()));
                        }
                    ),

                    CustomProfileElements(
                        Icons.help_outline,
                        "Help and Support",
                            (){    }
                    ),
                    CustomProfileElements(
                        Icons.privacy_tip_outlined,
                        "Privacy Policy",
                            (){Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => Vault()));
                        }
                    ),
                    CustomProfileElements(
                        Icons.rate_review_outlined,
                        "Rate",
                            (){
                          showDialog(context: context, builder: (context) => _dialog,);
                        }
                    ),
                    CustomProfileElements(
                        Icons.share,
                        "Share Vemate",
                            (){
                              Share.share(
                                  'Visit Vemate Website:\n https://www.vemate.com/');
                        }
                    ),
                    CustomProfileElements(
                        Icons.info_outline_rounded,
                        "About Vemate'",
                            () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => EnterNewPassword()));
                        }
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
