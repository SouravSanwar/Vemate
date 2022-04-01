import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    return Obx(() {
      printInfo(info: prefs!.getString('token').toString());
      return Scaffold(
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
          ));
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
