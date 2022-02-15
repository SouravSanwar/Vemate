import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class PropertyLocationDetails extends StatefulWidget {
  const PropertyLocationDetails({Key? key}) : super(key: key);

  @override
  _PropertyLocationDetailsState createState() =>
      _PropertyLocationDetailsState();
}

class _PropertyLocationDetailsState extends State<PropertyLocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_16,
        right: AppDimension.padding_16,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            AppLanguageString.LOCATION.tr,
            style: Get.textTheme.headline2!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.spaces_height_15,
          Row(
            children: [
              Icon(Icons.location_pin),
              Text('Location in text'),
            ],
          ),
          AppSpaces.spaces_height_10,
          Center(
            child: Text('Need A map view here'),
          ),
        ],
      ),
    );
  }
}
