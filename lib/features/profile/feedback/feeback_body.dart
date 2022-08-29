import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/features/profile/feedback/rating_stars.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';


class FeedbackBody extends StatefulWidget {
  static int checkFeedback=0;
  const FeedbackBody({Key? key}) : super(key: key);

  @override
  State<FeedbackBody> createState() => _FeedbackBodyState();
}

class _FeedbackBodyState extends State<FeedbackBody> {
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

            Text("Rate Your Experience",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
              ),),
            SizedBox(height: Get.height*.03,),
            const RatingStars(),
            SizedBox(height: Get.height*.03,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                cursorColor: AppColors.white,
                controller: feedbackController,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                  fontSize: 15.0.sp,
                ),
                decoration: InputDecoration(
                    border: _border,
                    focusedBorder: _border,
                    enabledBorder: _border,
                    hintText: "Add a Comment",
                    hintStyle: TextStyle(
                      color: AppColors.white.withOpacity(.7),
                      fontFamily: 'inter',
                      fontSize: 15.sp,
                    ),


                ),
                maxLines: 5,

              ),
            ),

            SizedBox(height: Get.height*.03,),

            InkWell(
              onTap: () async {
                Map<String, String>
                requestHeadersWithToken = {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization':
                  'token ${prefs!.getString('token')}',
                };

                var body = {
                  "rating": RatingStars.ratingValue,
                  "comment": feedbackController.text.isEmpty
                                  ?'No Comment' :feedbackController.text.toString(),

                };
                print("Body"+body.toString());

                if(RatingStars.ratingValue !=0 || feedbackController.text.isNotEmpty){
                  postData!.PostFeedback(context, body,requestHeadersWithToken);
                  FeedbackBody.checkFeedback=1;
                }
                else{
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => ResponseMessage(
                        icon: Icons.check_circle,
                        color: AppColors.primaryColor,
                        message: "Please insert rating or add a comment",
                      ));
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.of(context).pop();
                }

              },
              child: Container(
                alignment: Alignment.center,
                height: Get.height*.06,
                width: Get.width*0.4,
                decoration: BoxDecoration(
                  gradient: AppColors.onBoardBtnGradient,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Text(
                  "Send Feedback",
                  style: TextStyle(color: AppColors.white,fontSize: 18.sp),
                ),
              ),
            ),



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
