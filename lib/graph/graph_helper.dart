import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';
import 'designhelper.dart';

class gh {
  static bool c = true;
  static var aa = '0AM',
      bb = '2AM',
      cc = '4AM',
      dd = '6AM',
      ee = '8AM',
      ff = '10AM',
      gg = '12PM',
      hh = '2PM',
      ii = '4PM',
      jj = '6PM',
      kk = '8PM',
      ll = '10PM',
      mm = '2AM',
      nn = '4AM',
      oo = '6AM',
      pp = '8AM',
      qq = '10AM',
      rr = '12PM',
      ss = '2PM',
      tt = '4PM',
      uu = '6PM',
      vv = '8PM',
      ww = '10PM';
}

class GraphHelper extends StatefulWidget {
  final int? id;

  const GraphHelper({Key? key, this.id}) : super(key: key);

  @override
  State<GraphHelper> createState() => _GraphHelperState();
}

class _GraphHelperState extends State<GraphHelper> {
  GetData? getData;

  PostData? postData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);

    postData = Provider.of<PostData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(
      builder: (context, data, child) {
        return Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "1H",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                    //FOR 7 DAYS
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "24H",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DesignHelper(
                      onPressed: () {
                        getData!.getSingleProduct(widget.id, graphType: 1);
                      },
                      child: const Text(
                        "7D",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AppSpaces.spaces_height_5,
                    //FOR 30 DAYS
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "30D",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpaces.spaces_height_5,
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //FOR 60 DAYS
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "60D",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    //FOR 1 YEAR
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "1Y",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    //FOR 60 DAYS
                    DesignHelper(
                      onPressed: () {},
                      child: const Text(
                        "All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpaces.spaces_height_40,
              // recent transactions
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  data.singleProductModel != null
                      ? data.singleProductModel!.name.toString() + "'s Details"
                      : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              AppSpaces.spaces_height_20,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: ListView(children: <Widget>[
                    ItemDetailsHelper(
                      text: "Floor Price",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.floorPrice.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Owner",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.owner.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Edition",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.edition.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Name",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.name.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Drop Date",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.dropDate.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "List Price",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.listPrice.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Editions",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.editions.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Edition Type",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.editionType.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Season",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.season.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Rarity",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.rarity.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Brand",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.brand.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Series",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.series.toString()
                          : "",
                    ),
                  ]),
                ),
              ),
              AppSpaces.spaces_height_20,
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    data.checkWishlistModel!.isFound == false
                        ? InkWell(
                            onTap: () {
                              var body = {
                                "product": data.singleProductModel!.id,
                                "type": 1
                              };

                              postData!.addToWishlist(
                                context,
                                body,
                                data.singleProductModel!.id,
                              );
                            },
                            child: Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: Get.width * .5,
                                decoration: BoxDecoration(
                                  gradient: AppColors.purpleGradient,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 15,
                                      bottom: 15),
                                  child: Text(
                                    'Add to Wishlist',
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width * .5,
                              decoration: BoxDecoration(
                                gradient: AppColors.purpleGradient,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 15, bottom: 15),
                                child: Text(
                                  'Already in Wishlist',
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                    AppSpaces.spaces_width_2,
                    data.checkSetCheck!.isFound == false
                        ? InkWell(
                            onTap: () {
                              var body = {
                                "product": data.singleProductModel!.id,
                                "type": 0
                              };

                              postData!.addToSet(
                                context,
                                body,
                                data.singleProductModel!.id,
                              );
                            },
                            child: Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: Get.width * .4,
                                decoration: BoxDecoration(
                                  gradient: AppColors.purpleGradient,
                                  //color: AppColors.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 15,
                                      bottom: 15),
                                  child: Text('Add to Set',
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width * .4,
                              decoration: BoxDecoration(
                                gradient: AppColors.purpleGradient,
                                //color: AppColors.primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 15, bottom: 15),
                                child: Text('Already in Set',
                                    style: Get.textTheme.bodyMedium),
                              ),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
