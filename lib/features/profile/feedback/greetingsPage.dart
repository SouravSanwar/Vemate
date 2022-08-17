import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/profile/feedback/rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';


class GreetingsPage extends StatefulWidget {
  const GreetingsPage({Key? key}) : super(key: key);

  @override
  State<GreetingsPage> createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {
  PostData? postData;
  TextEditingController feedbackController = TextEditingController();

  final OutlineInputBorder _border=OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color(0xFF18C5F2), // set border color
          width: 1.5),
      borderRadius: BorderRadius.circular(5.0));

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              height: Get.height*.06,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  gradient: AppColors.onBoardBtnGradient
              ),
              child: Text("Feedback",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),),

            ),


            SizedBox(height: Get.height*.04,),

            SizedBox(
              height: Get.height * .18,
              child: Image.asset(
                 'assets/media/image/feedback.png',
                fit:BoxFit.cover,
              ),
            ),
            SizedBox(height: Get.height*.03,),
            Text("Thanks for your valuable Feedback",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(height: Get.height*.03,),
            Text("FOLLOW US",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.sp,
                fontFamily: 'inter',
                fontWeight: FontWeight.bold
              ),),

            SizedBox(height: Get.height*.03,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaIcon('assets/media/icon/twitter.png', 'https://twitter.com/Vemate_Official'),
                SocialMediaIcon('assets/media/icon/instagram.png', 'https://www.instagram.com/vemateofficial/?utm_medium=copy_link'),
                SocialMediaIcon('assets/media/icon/discord.png', 'https://discord.com/invite/aYBZuNJa9w'),
                SocialMediaIcon('assets/media/icon/telegram.png', 'https://t.me/vemateofficial'),
              ],
            )


          ],
        ),
        Positioned(
          top: 25,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child:Image.asset(
              'assets/media/image/splash_logo.png',
              fit: BoxFit.fill,
            ),
            width: Get.width * .125,
            height: Get.width * .125,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff615FF0),
                  Color(0xff5A58DE),
                ],
                begin: Alignment.topCenter,
                // end at the bottom
                end: Alignment.bottomCenter,
              ),
            ),
          ), ),
      ],
    );

  }
}

class SocialMediaIcon extends StatelessWidget {


  final String? image;
  final String? link;

  SocialMediaIcon(this.image, this.link);

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
           _launchInApp(link!);

               },
        splashColor: AppColors.backgroundColor,
        child: Container(
          height: Get.height*.06,
            width: Get.height*.06,
            margin: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              gradient: AppColors.onBoardBtnGradient,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(10.h),
            child:Image.asset(
              image!,
              fit: BoxFit.fill,
              color: AppColors.white,
            ),));
  }
}
