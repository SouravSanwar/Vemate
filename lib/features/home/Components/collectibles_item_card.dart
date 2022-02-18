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
    return Container(
      height: Get.width * .5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: Get.width * .35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    widget.image.toString(),
                  ),
                ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppSpaces.spaces_height_10,
                    Container(
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimension.padding_8),
                          bottomRight: Radius.circular(AppDimension.padding_8),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppDimension.padding_8,
                              right: AppDimension.padding_8,
                              top: AppDimension.padding_4,
                              bottom: AppDimension.padding_4,
                            ),
                            child: Text(
                              widget.list![index].name.toString(),
                              textAlign: TextAlign.left,
                              style: Get.textTheme.bodyText1!
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(AppDimension.padding_8),
                                bottomRight:
                                    Radius.circular(AppDimension.padding_8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AppDimension.padding_8,
                                right: AppDimension.padding_8,
                                top: AppDimension.padding_4,
                                bottom: AppDimension.padding_4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.list![index].floorPrice.toString(),
                                    textAlign: TextAlign.center,
                                    style: Get.textTheme.bodyText1!
                                        .copyWith(color: AppColors.black),
                                  ),
                                  Text(
                                    widget.list![index].rarity.toString(),
                                    textAlign: TextAlign.center,
                                    style: Get.textTheme.bodyText1!
                                        .copyWith(color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
