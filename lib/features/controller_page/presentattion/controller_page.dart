import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';

import 'package:ketemaa/features/home/presentation/home.dart';
import 'package:ketemaa/features/place_a_add/_controller/place_a_add_controller.dart';
import 'package:ketemaa/features/place_a_add/presentation/place_a_add.dart';
import 'package:ketemaa/features/profile/presentation/profile.dart';

class ControllerPage extends StatelessWidget {
  List<String> names = [
    'Home',
    'Favourite',
    'Place a Add',
    'Chats',
    'Profile',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.favorite_border,
    Icons.add,
    Icons.message,
    Icons.person,
  ];

  Duration duration = const Duration(milliseconds: 300);
  Curve curve = Curves.ease;
  TransitionType transitionType = TransitionType.slide;

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    Get.put(PlaceAddController());
    return Obx((){
      return Scaffold(
        body: BottomBarPageTransition(
          builder: (_, index) => getBody(index),
          currentIndex: PlaceAddController.to.currentPage.value,
          totalLength: ControllerPageController.to.bottomBarData!.length,
          transitionType: transitionType,
          transitionDuration: duration,
          transitionCurve: curve,
        ),
        bottomNavigationBar: getBottomBar(),
      );
    });
  }

  getBody(int index) {
    if (index == 0) {
      return Home();
    } else if (index == 1) {
      return Container(
        child: Center(
          child: Text(names[index]),
        ),
      );
    } else if (index == 2) {
      return PlaceAAdd();
    } else if (index == 3) {
      return Container(
        child: Center(
          child: Text(names[index]),
        ),
      );
    } else {
      return Container(
        child: Profile(),
      );
    }
  }

  getBottomBar() {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: PlaceAddController.to.currentPage.value,
      onTap: (index) {
        //print(PlaceAddController.to.currentPage.value);
        PlaceAddController.to.currentPage.value = index;
      },
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        ControllerPageController.to.bottomBarData!.length,
            (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: names[index],
        ),
      ),
    );
  }
}