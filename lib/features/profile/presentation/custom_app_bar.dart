import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget child;
  double height;
  Color? color;

  CustomAppBar({
    required this.child,
    this.height = kToolbarHeight,
    this.color
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: color,
      child: child,
    );
  }
}
