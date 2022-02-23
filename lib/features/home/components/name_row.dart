import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';

class NameRow extends StatelessWidget {
  String? name;
  TextStyle? style;

  NameRow({Key? key, this.name, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name.toString(),
          textAlign: TextAlign.center,
          style: style,
        ),
        AppSpaces.spaces_width_5,
        Expanded(
          child: Column(
            children: const [
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
