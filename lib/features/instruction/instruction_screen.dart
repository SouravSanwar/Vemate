import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/splash_screen/splashscreen.dart';




class InstructionsScreen extends StatefulWidget {
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();


  @override
  Widget build(BuildContext context) {


    const pageDecoration =PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700,color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 19.0,fontWeight: FontWeight.w500,color: Colors.white),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xff272E49),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(

      //onPressed: () => _onIntroEnd(context),
      key: introKey,
      globalBackgroundColor: AppColors.backgroundColor,
      globalHeader:Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
        child: FlatButton(

          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            Get.to(() => const SplashScreen());
          },
          child: const Align(

            alignment: Alignment.topRight,
            child: Text(
                "Skip",
                style: TextStyle(fontSize: 20.0),
            ),
          )
        ),
      ),

      pages: [
        PageViewModel(
          title: "Fasted Floor Price Update",
          body:
          "Unlock the fastest Floor Price update on the market.",
          image: Image.asset('assets/media/logo/instruction1.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Unique Tools",
          body:
          "Have functions that speed up your trade reaction times and"
              " allow you to get those right trades in first at your disposal.",
          image: Image.asset('assets/media/logo/instruction2.png', width: 350),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Organized Information",
          body:
          "Sort your collectibles based on their categories in order to provide you with a clear overview.",
          image: Image.asset('assets/media/logo/instruction3.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Decision Making",
          body: "Utilise the full spectrum of data available in your decision making process.",
          image: Image.asset('assets/media/logo/instruction4.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Chart Perspective",
          body: "Use the capacity to visualise your collectible's evolution over time.",
          image: Image.asset('assets/media/logo/instruction5.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "My Wishlist",
          body: "Keep an eye on the collectibles you desire for the right time to acquire",
          image: Image.asset('assets/media/logo/instruction6.png', width: 350),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => Get.to(() => const SplashScreen()),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Container(),
      skip: Container(),
      next: const Icon(Icons.arrow_forward,color: Colors.white,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 18)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(15.0, 15.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

