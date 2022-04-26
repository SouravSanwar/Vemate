import 'dart:ui';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:ketemaa/graph/product_details.dart';
import 'package:ketemaa/graph/product_graph.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

class CollectibleDetails extends StatefulWidget {
  final int? productId;

  const CollectibleDetails({Key? key, this.productId}) : super(key: key);

  @override
  _CollectibleDetailsState createState() => _CollectibleDetailsState();
}

class _CollectibleDetailsState extends State<CollectibleDetails> {
  GetData? getData;

  PostData? postData;

  int? currentIndex = 1;
  bool? hour = true;
  bool? week = false;
  bool? month = false;
  bool? two_month = false;
  bool? year = false;
  bool isAddedVault = false;
  bool isAddedWishlist = false;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData!.getSingleProduct(widget.productId);

    getData!.checkWishlist(widget.productId!);
    getData!.checkSetList(widget.productId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          elevation: 1.0,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.grey),
          backgroundColor: AppColors.lightBackgroundColor,
          title: Text(
            data.singleProductModel != null
                ? data.singleProductModel!.name.toString()
                : "",
            style: Get.textTheme.headline2!.copyWith(color: Colors.white),
          ),
        ),
        body: data.singleProductModel != null
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            child: Container(
                              padding: EdgeInsets.all(50),
                              decoration: BoxDecoration(
                                  gradient: AppColors.vaultCardGradient,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              alignment: Alignment.center,
                              child: Text(
                                data.singleProductModel!.name
                                    .toString()[0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 65,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  var body = {
                                    "product": data.singleProductModel!.id,
                                    "type": 1
                                  };
                                  Map<String, String> requestHeadersWithToken =
                                      {
                                    'Content-type': 'application/json',
                                    'Accept': 'application/json',
                                    'Authorization':
                                        'token ${prefs!.getString('token')}',
                                  };

                                  data.checkWishlistModel!.isFound == false
                                      ? postData!.addToWishlist(
                                          context,
                                          body,
                                          data.singleProductModel!.id,
                                          requestHeadersWithToken,
                                        )
                                      : Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          isDismissible: false,
                                          duration: const Duration(seconds: 3),
                                          messageText: const Text(
                                            "Product already in your wishlist",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.green),
                                          )).show(context);
                                },
                                child: Container(
                                  width: Get.width * .4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.purpleGradient,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: data.checkWishlistModel!.isFound ==
                                            false
                                        ? Text(
                                            'Add to Wishlist',
                                            style: Get.textTheme.bodyMedium,
                                          )
                                        : Text(
                                            'Already in Wishlist',
                                            style: Get.textTheme.bodyMedium,
                                          ),
                                  ),
                                ),
                              ),
                              AppSpaces.spaces_width_20,
                              InkWell(
                                onTap: () {
                                  var body = {
                                    "product": data.singleProductModel!.id,
                                    "type": 0
                                  };
                                  Map<String, String> requestHeadersWithToken =
                                      {
                                    'Content-type': 'application/json',
                                    'Accept': 'application/json',
                                    'Authorization':
                                        'token ${prefs!.getString('token')}',
                                  };

                                  data.checkSetCheck!.isFound == false
                                      ? postData!.addToSet(
                                          context,
                                          body,
                                          data.singleProductModel!.id,
                                          requestHeadersWithToken,
                                        )
                                      : Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          isDismissible: false,
                                          duration: const Duration(seconds: 3),
                                          messageText: const Text(
                                            "Product already in your Vault",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.green),
                                          )).show(context);
                                },
                                child: Container(
                                  width: Get.width * .4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.purpleGradient,
                                    //color: AppColors.primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: data.checkSetCheck!.isFound == false
                                        ? Text('Add to Vault',
                                            style: Get.textTheme.bodyMedium)
                                        : Text('Already in Vault',
                                            style: Get.textTheme.bodyMedium),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Total Distributions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blueGrey.shade300,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    currentIndex = 1;
                                    hour = true;
                                    week = false;
                                    month = false;
                                    two_month = false;
                                    year = false;
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 0);
                                  },
                                  child: CategoryCard(
                                    name: '24H',
                                    gradient: hour == true
                                        ? AppColors.purpleGradient
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xff272E49),
                                              Color(0xff272E49),
                                            ],
                                          ),
                                  ),
                                ),
                              )),

                              ///7 Days
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 2;
                                      hour = false;
                                      week = true;
                                      month = false;
                                      two_month = false;
                                      year = false;
                                      getData!.getSingleProduct(
                                          widget.productId,
                                          graphType: 1);
                                    },
                                    child: CategoryCard(
                                      name: '7D',
                                      gradient: week == true
                                          ? AppColors.purpleGradient
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),

                              ///30 Days
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 1;
                                      hour = false;
                                      week = false;
                                      month = true;
                                      two_month = false;
                                      year = false;
                                      getData!.getSingleProduct(
                                          widget.productId,
                                          graphType: 2);
                                    },
                                    child: CategoryCard(
                                      name: '30D',
                                      gradient: month == true
                                          ? AppColors.purpleGradient
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),

                              ///60 Days
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 1;
                                      hour = false;
                                      week = false;
                                      month = false;
                                      two_month = true;
                                      year = false;
                                      getData!.getSingleProduct(
                                          widget.productId,
                                          graphType: 3);
                                    },
                                    child: CategoryCard(
                                      name: '60D',
                                      gradient: two_month == true
                                          ? AppColors.purpleGradient
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 1;
                                      hour = false;
                                      week = false;
                                      month = false;
                                      two_month = false;
                                      year = true;
                                      getData!.getSingleProduct(
                                          widget.productId,
                                          graphType: 4);
                                    },
                                    child: CategoryCard(
                                      name: '1Y',
                                      gradient: year == true
                                          ? AppColors.purpleGradient
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 100),
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: data.singleProductModel!.graph != null
                                    ? ProductGraph(
                                        graphList:
                                            data.singleProductModel!.graph,
                                        graphType:
                                            data.singleProductModel!.graphType,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          AppSpaces.spaces_height_25,
                        ],
                      ),
                    )
                  ];
                },
                body: const ProductDetails(),
              )
            : const LoadingExample(),
      );
    });
  }
}
