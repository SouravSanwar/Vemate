import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/presentation/widgets/popular_in_row.dart';

class ResidentialForRentCard extends StatelessWidget {
  List? subCategory;
  var categorykeyword;
  String? categoryName;

  ResidentialForRentCard(
      {this.subCategory, this.categorykeyword, this.categoryName});

  @override
  Widget build(BuildContext context) {
    //printInfo(info: subCategory![0].node!.city!.city.toString());
    return SizedBox(
      width: Get.width,
      height: Get.height * .35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subCategory!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return subCategory![index].node!.category!.keyword.toString() ==
                    categorykeyword
                ? Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 200,
                      width: AppSizes.width4,
                      color: Colors.white24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: AppSizes.width4,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: AssetImage(
                                  AppAsset.apartment_1.toString(),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          AppSpaces.spaces_height_10,
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppDimension.padding_8,
                              right: AppDimension.padding_8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpaces.spaces_height_5,
                                Text(
                                  subCategory![index]
                                          .node!
                                          .currency
                                          .toString() +
                                      ' ' +
                                      subCategory![index]
                                          .node!
                                          .price
                                          .toString(),
                                  style: Get.textTheme.bodyText2!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.h2,
                                  ),
                                ),
                                AppSpaces.spaces_height_5,
                                Text(
                                  subCategory![index]
                                      .node!
                                      .description
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyText2!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpaces.spaces_height_5,
                                Text(
                                  subCategory![index]
                                      .node!
                                      .location
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container();
          }),
    );
  }
}
