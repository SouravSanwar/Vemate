import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:provider/provider.dart';

import '../../../core/Provider/getData.dart';
import '../../../core/models/CollectiblesModel.dart';

class CollectiblesItemCard extends StatefulWidget {
  List<Results>? list;

  String? image;
  String? name;

  CollectiblesItemCard({
    this.list,
    this.image,
    this.name,
  });

  @override
  State<CollectiblesItemCard> createState() => _CollectiblesItemCardState();
}

class _CollectiblesItemCardState extends State<CollectiblesItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_8,
        right: AppDimension.padding_8,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: Get.width * .5,
              decoration: BoxDecoration(
                color: Colors.white,
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
                  fetchData.getSingleCollectible(widget.list![index].id);

                  Flushbar(
                    title: "Hey buddy",
                    message: "You selected ${widget.list![index].name}",
                    duration: const Duration(seconds: 1),
                  ).show(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //AppSpaces.spaces_height_10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.list![index].name.toString(),
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodyText2!.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            widget.list![index].editionType.toString(),
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodyText1!.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      AppSpaces.spaces_height_10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.list![index].brand.toString(),
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodyText1!
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            widget.list![index].rarity.toString(),
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
                              children: [
                                Image.asset(
                                  'assets/media/image/price-tag.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                AppSpaces.spaces_width_5,
                                Text(
                                  widget.list![index].floorPrice.toString(),
                                  textAlign: TextAlign.start,
                                  style: Get.textTheme.bodyText1!
                                      .copyWith(color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/media/image/transfer.png',
                                height: 15.0,
                                width: 15.0,
                              ),
                              AppSpaces.spaces_width_5,
                              Text(
                                '-3.30 %',
                                textAlign: TextAlign.end,
                                style: Get.textTheme.bodyText1!
                                    .copyWith(color: Colors.red),
                              ),
                            ],
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
