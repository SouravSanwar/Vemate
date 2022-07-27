import 'package:flutter/material.dart';

class DockerItem {
  final String? title;
  final IconData? icon;
  final Widget? customWidget;

  DockerItem({
    this.icon,
    this.title,
    this.customWidget,
  }) : assert(icon != null || customWidget != null);
}
