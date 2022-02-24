import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:provider/provider.dart';

import '../../../core/Provider/getData.dart';
import '../../../core/models/CommicsModel.dart';

class ComicsMcpCard extends StatelessWidget {
  List<Results>? list;

  ComicsMcpCard({
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_8,
        right: AppDimension.padding_8,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: Get.width * .5,
              decoration: BoxDecoration(
                color: list![index].rarityColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  var fetchData =
                      Provider.of<GetData>(Get.overlayContext!, listen: false);
                  fetchData.getSingleComic(list![index].id);

                  Flushbar(
                    title: "Hey buddy",
                    message: "You selected ${list![index].name}",
                    duration: const Duration(seconds: 1),
                  ).show(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list![index].name.toString(),
                        textAlign: TextAlign.start,
                        style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      AppSpaces.spaces_height_10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              list![index].publisher.toString(),
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodyText1!
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            list![index].rarity.toString(),
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                      AppSpaces.spaces_height_10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/media/image/low-price.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                AppSpaces.spaces_width_5,
                                Text(
                                  list![index].cpp.toString(),
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/media/image/token.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                AppSpaces.spaces_width_5,
                                Text(
                                  list![index].rarePoint.toString(),
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/media/image/price-tag.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                AppSpaces.spaces_width_5,
                                Text(
                                  list![index].floorPrice.toString(),
                                  textAlign: TextAlign.start,
                                  style: Get.textTheme.bodyText1!
                                      .copyWith(color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
