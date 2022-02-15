import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/agency_profile.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/amenities_details.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/description.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/details_divider.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/location.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/property_info.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/schedule_viewing.dart';
import 'package:ketemaa/features/home/presentation/widgets/property_details/top_description.dart';

class PropertyDetailsPage extends StatelessWidget {
  const PropertyDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: AppDimension.productpageiconsize,
            width: AppDimension.productpageiconsize,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.keyboard_backspace_outlined,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        leadingWidth: AppDimension.productpageiconsize,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              height: AppDimension.productpageiconsize,
              width: AppDimension.productpageiconsize,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: AppDimension.productpageiconsize,
                width: AppDimension.productpageiconsize,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.share,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
        elevation: 2,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          PropertyTopDescription(),
          PropertyDetailsDivider(),
          PropertyLocationDetails(),
          PropertyDetailsDivider(),
          PropertyInfo(),
          PropertyDetailsDivider(),
          AmenitiesInfo(),
          PropertyDetailsDivider(),
          PropertyDescription(),
          PropertyDetailsDivider(),
          ScheduleViewing(),
          PropertyDetailsDivider(),
          AgencyProfile(),
          PropertyDetailsDivider(),
        ],
      ),
    );
  }
}
