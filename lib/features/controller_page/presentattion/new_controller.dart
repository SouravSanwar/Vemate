import 'package:flutter/material.dart';
import 'package:ketemaa/features/home/presentation/home.dart';
import 'package:ketemaa/features/market/presentation/market.dart';
import 'package:ketemaa/features/vault/vault.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class NewController extends StatefulWidget {
  const NewController({Key? key}) : super(key: key);

  @override
  State<NewController> createState() => _NewControllerState();
}

class _NewControllerState extends State<NewController> {
  int _seletedItem = 0;
  var _pages = [Home(), Market(), Vault()];
  var _pageController = PageController();
  List<String> names = [
    'Home',
    'Market',
    'My Vault',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.shop,
    Icons.card_travel,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _seletedItem = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.iconColor,
        unselectedItemColor: AppColors.textColor,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shop), label: 'Market'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel), label: 'My Vault')
        ],
        currentIndex: _seletedItem,
        onTap: (index) {
          setState(() {
            _seletedItem = index;
            _pageController.animateToPage(_seletedItem,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
      ),
    );
  }
}
