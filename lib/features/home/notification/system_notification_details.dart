import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class SystemNotificationDetails extends StatefulWidget {
  String? title;
  String? description;
  String? link;

  SystemNotificationDetails({Key? key,this.title,this.description,this.link}) : super(key: key);

  @override
  State<SystemNotificationDetails> createState() => _SystemNotificationDetailsState();




}

class _SystemNotificationDetailsState extends State<SystemNotificationDetails> {
  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState
    //getConnection();

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getNotification();
    getData!.getAlert();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
            color: AppColors.greyWhite
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          widget.title!,
          style: Get.textTheme.bodyLarge!.copyWith(color: AppColors.textColor,fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.width *0.05167),
        child: ListView(
          children: [
            Image.asset(
              'assets/media/image/splash_logo.png' ,
              fit:  BoxFit.contain ,
              width: Get.width*0.5,
              height: Get.width*0.5,
            ),
            AppSpaces.spaces_height_20,
            Text(
              widget.description.toString().replaceAll(r'\n', '\n'),
              textAlign: TextAlign.justify,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Inter',
                color: AppColors.textColor,
              ),
            ),
            AppSpaces.spaces_height_20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*.2),
              child: CustomButtons(
                height: Get.height*.05,
                width: Get.width*.14,
                text: "Click Here",
                onTap: (){
                  _launchInApp(widget.link!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
