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
    'MCP',
    'Market',
    'Vault',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.list_alt_outlined,
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
        body: BottomBarPageTransition(
          builder: (_, index) => getBody(index),
          currentIndex: ControllerPageController.to.currentPage.value,
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
      return MCP();
    }else if (index == 2) {
      return Market();
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
      currentIndex: ControllerPageController.to.currentPage.value,
      onTap: (index) {
        ControllerPageController.to.currentPage.value = index;
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
