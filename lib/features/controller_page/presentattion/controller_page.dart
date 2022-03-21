import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/home/presentation/home.dart';
import 'package:ketemaa/features/mcp/presentation/mcp.dart';

import 'package:ketemaa/features/profile/presentation/profile.dart';

import '../../market/presentation/market.dart';

class ControllerPage extends StatelessWidget {
  List<String> names = [
    'Home',
    'Market',
    'Vault',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.shop,
    Icons.card_travel,
  ];

  Duration duration = const Duration(milliseconds: 300);
  Curve curve = Curves.ease;
  TransitionType transitionType = TransitionType.fade;

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    Get.put(ControllerPageController());
    return Obx(() {
      return Scaffold(

        backgroundColor: Color(0xff272E49),
        body: BottomBarPageTransition(
          builder: (_, index) => getBody(index),
          currentIndex: ControllerPageController.to.currentPage.value,
          totalLength: ControllerPageController.to.bottomBarData!.length,
          transitionType: transitionType,
          transitionDuration: duration,
          transitionCurve: curve,
        ),
        bottomNavigationBar: Container(
          height: 65,
          child: getBottomBar(),
        )
      );
    });
  }

  getBody(int index) {
    if (index == 0) {
      return Home();
    }else if (index == 1) {
      return Market();
    } else {
      return Container(
        child: Profile(),
      );
    }
  }

/*  getBottomBar() {

    return Container(

      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),

      child:BottomNavigationBar(

      backgroundColor: Colors.black54,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: ControllerPageController.to.currentPage.value,
      onTap: (index) {
        ControllerPageController.to.currentPage.value = index;
      },
      selectedItemColor: Colors.purpleAccent,
      unselectedItemColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        ControllerPageController.to.bottomBarData!.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: names[index],
        ),
      ),
    ),

    );
  }*/

  getBottomBar() {
    return ClipRRect(

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),


          child: BottomNavigationBar(

            backgroundColor: Color(0xff384362),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            currentIndex: ControllerPageController.to.currentPage.value,
            onTap: (index) {ControllerPageController.to.currentPage.value = index;},
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Color(0xffB390E3),
           // Color c=[Colors.black, Colors.redAccent] as Color;
            unselectedItemColor: AppColors.white,
            showUnselectedLabels: true,
            items: List.generate(
              ControllerPageController.to.bottomBarData!.length,
                  (index) => BottomNavigationBarItem(
                    icon: Icon(icons[index]),
                    label: names[index],
              ),
            ),
          ),
        );

    /*return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child:BottomNavigationBar(


      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: ControllerPageController.to.currentPage.value,
      onTap: (index) {
        ControllerPageController.to.currentPage.value = index;
      },
      selectedItemColor: Colors.purpleAccent,
      unselectedItemColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        ControllerPageController.to.bottomBarData!.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: names[index],
        ),
      ),
    ),

    );*/
  }
}
