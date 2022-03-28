import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/profile/widgets/profile_divider.dart';

import 'package:ketemaa/graph/designhelper.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:image_picker/image_picker.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../market/presentation/vault/vault.dart';
import '../../market/presentation/vault/vaule_collectibles_card.dart';
import 'custom_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getUserInfo();
    super.initState();
  }

  final _dialog = RatingDialog(
    initialRating: 5.0,
    title: Text(
      'Vemate',
      style: Get.textTheme.headline2,
      textAlign: TextAlign.center,
    ),
    message: Text(
      'Rate Us On App Store or Play Store',
      style: Get.textTheme.bodyLarge,
      textAlign: TextAlign.center,
    ),
    image: Image.asset('assets/media/slider/12.png'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //maintainBottomViewPadding: true,
      minimum: EdgeInsets.zero,
      child: Consumer<GetData>(builder: (context, data, child) {
        return data.profileModel != null
            ? Scaffold(
                backgroundColor: const Color(0xff272E49),
                body: Padding(
                  padding: EdgeInsets.only(
                    left: AppDimension.padding_8,
                    right: AppDimension.padding_8,
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width * .15,
                                backgroundColor: const Color(0xff272E49),
                                backgroundImage: null,
                                child: Image.network(
                                  Urls.mainUrl +
                                      data.profileModel!.profileImage!.mobile!
                                          .src
                                          .toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.greyWhite,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            AppSpaces.spaces_width_10,
                            Text(
                              data.profileModel!.nickname.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomProfileElements(Icons.person, "Profile Edit", () {
                        Get.toNamed(
                          AppRoutes.EDIT_PROFILE,
                          arguments: data.profileModel,
                        );
                      }),
                      CustomProfileElements(
                          Icons.help_outline, "Help and Support", () {}),
                      CustomProfileElements(
                          Icons.privacy_tip_outlined, "Privacy Policy", () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => Vault()));
                      }),
                      CustomProfileElements(Icons.rate_review_outlined, "Rate",
                          () {
                        showDialog(
                          context: context,
                          builder: (context) => _dialog,
                        );
                      }),
                      CustomProfileElements(Icons.share, "Share Vemate", () {
                        Share.share(
                            'Visit Vemate Website:\n https://www.vemate.com/');
                      }),
                      CustomProfileElements(
                          Icons.info_outline_rounded, "About Vemate", () {}),
                    ],
                  ),
                ),
              )
            : LoadingExample();
      }),
    );
  }
}
