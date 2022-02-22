/*
import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
List<String> names = [
  'Home',
  'Favourite',
  'Place a Add',
  'Chats',
  'Profile',
];

List<IconData> icons = [
  Icons.market,
  Icons.favorite_border,
  Icons.add,
  Icons.message,
  Icons.person,
];



getBottomBar(var _current, var _total, var names, var icons) {
  return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: _current,
      onTap: (index) {

        print(_current);
        _current = index;
        setState(() {
        });
      },
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
          _total,
              (index) => BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: names[index],
          )));
}

void setState(Null Function() param0) {

}
*/
