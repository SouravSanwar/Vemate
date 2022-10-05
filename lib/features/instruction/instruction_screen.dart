import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/main.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  TextStyle? titleTextStyle = GoogleFonts.inter(
    fontSize: 26.sp,
    fontWeight: FontWeight.bold,
  );
  TextStyle? bodyTextStyle = GoogleFonts.inter(
    fontSize: 17.sp,
  );

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontFamily: 'Inter',fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: TextStyle(
          fontFamily: 'Inter',fontSize: 19.0, fontWeight: FontWeight.w500, color: Colors.white),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
     // pageColor: Color(0xff02072D),
      imagePadding: EdgeInsets.zero,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.onBoardGradient
      ),
      child: IntroductionScreen(
        //onPressed: () => _onIntroEnd(context),
        key: introKey,
        globalBackgroundColor: Colors.transparent.withOpacity(0),
        globalHeader: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: InkWell(
            onTap: () {
              prefs!.getString('token') != null
                  ? Get.to(() => ControllerPage())
                  : Get.to(() => const AuthInitialPage());
            },
            child: Text(
              "Skip",
              style: TextStyle(

                  fontFamily: 'Inter',
                  color: AppColors.textColor, fontSize: 12.0.sp),
            ),
          ),
        ),

        pages: [
          PageViewModel(
            titleWidget: Text(
              'Unique Tools',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Have access to functions that speed up your trade reaction times and allow you to get those right trades in first, at your disposal.',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            image:
                Image.asset('assets/media/logo/instruction2.png', width: 350.w),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Text(
              'Organized Information',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Sort your collectibles based on their categories in order to provide you with a clear overview.',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            image:
                Image.asset('assets/media/logo/instruction3.png', width: 350.w),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Text(
              'Decision Making',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Utilise the full spectrum of data available in your decision making process.',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            image:
                Image.asset('assets/media/logo/instruction4.png', width: 350.w),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Text(
              'Chart Perspective',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Use the capacity to visualise your collectible\'s evolution over time.',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            image:
                Image.asset('assets/media/logo/instruction5.png', width: 350.w),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Text(
              'My Wishlist',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Keep an eye on the collectibles you desire for the right time to acquire',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            image:
                Image.asset('assets/media/logo/instruction6.png', width: 350.w),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => Get.to(() => const AuthInitialPage()),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: Container(),
        skip: Container(),
        next: Container(),
        done: Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
                fontSize: 18.sp)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPosition: Position(left: Get.width * .17, right: 0, bottom: 10),
        controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(5.0, 5.0),
          color: Colors.grey,
          activeColor: Color(0xFF1DDFEA),
          activeSize: Size(10.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
