import 'dart:io';

import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/home/presentation/home.dart';
import 'package:ketemaa/features/vault/vault.dart';

import 'package:ketemaa/main.dart';

import '../../market/presentation/market.dart';

class ControllerPage extends StatelessWidget {
  ControllerPage({Key? key}) : super(key: key);
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

  Future<bool> _willPopCallback() async {
    Get.dialog(
      Dialog(
        child: Container(
          width: Get.height * .25,
          color: AppColors.lightBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom:
                        BorderSide(width: 2.0, color: AppColors.primaryColor),
                  )),
                  child: Text('Alart'),
                ),
                AppSpaces.spaces_height_10,
                Text('Are you sure to exit?'),
                AppSpaces.spaces_height_10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('No'),
                        ),
                      ),
                    ),
                    AppSpaces.spaces_width_15,
                    InkWell(
                      onTap: () {
                        exit(0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Yes'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    return Obx(() {
      printInfo(info: prefs!.getString('token').toString());

      return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            backgroundColor: const Color(0xff272E49),
            body: BottomBarPageTransition(
              builder: (_, index) => getBody(index),
              currentIndex: ControllerPageController.to.currentPage.value,
              totalLength: ControllerPageController.to.bottomBarData!.length,
              transitionType: transitionType,
              transitionDuration: duration,
              transitionCurve: curve,
            ),
            bottomNavigationBar: SizedBox(
              //height: 65,
              child: getBottomBar(),
            )),
      );
    });
  }

  getBody(int index) {
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const Market();
    } else {
      return Vault();
    }
  }

  getBottomBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50.0),
        topRight: Radius.circular(50.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.lightBackgroundColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: ControllerPageController.to.currentPage.value,
        onTap: (index) {
          ControllerPageController.to.currentPage.value = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: const Color(0xffB390E3),
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
  }
}
