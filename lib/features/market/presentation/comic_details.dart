import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/graph/graph_helper_comics.dart';
import 'package:ketemaa/graph/product_graph.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

class ComicDetails extends StatefulWidget {
  final int? productId;

  const ComicDetails({Key? key, this.productId}) : super(key: key);

  @override
  _ComicDetailsState createState() => _ComicDetailsState();
}

class _ComicDetailsState extends State<ComicDetails> {
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
        appBar: AppBar(
          elevation: 1.0,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.grey),
          backgroundColor: AppColors.backgroundColor,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
            child: Text(
              data.singleProductModel != null
                  ? data.singleProductModel!.name.toString()
                  : "",
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: data.singleProductModel != null
            ? SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                            padding:  EdgeInsets.only(top: 0,right:Get.width*0.05336,left:Get.width*0.05336,bottom: Get.height*0.01667 ),
                              child: Container(
                                height: Get.height * .5,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    gradient: AppColors.vaultCardGradient,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                alignment: Alignment.center,
                                child:
                                    data.singleProductModel!.image ==
                                            null
                                        ? Text(
                                      data.singleProductModel!.name.toString()[0]
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.deepPurpleAccent,
                                                fontFamily: 'Inter',
                                                fontSize: 65,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: data.singleProductModel!
                                                .image!.original!.src
                                                .toString(),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
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
                                    Map<String, String>
                                        requestHeadersWithToken = {
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
                                            duration:
                                                const Duration(seconds: 3),
                                            messageText: Text(
                                              "Product already in your wishlist",
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16.0.sp,
                                                  color: Colors.green),
                                            )).show(context);
                                  },
                                  child: Container(
                                    width: Get.width * .42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: data.checkWishlistModel != null
                                        ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
                                            child: data.checkWishlistModel!
                                                        .isFound ==
                                                    false
                                                ? AutoSizeText(
                                                    'Add to Wishlist',
                                                    style: Get
                                                        .textTheme.bodyMedium!.copyWith(fontFamily: 'Inter',),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                                  )
                                                : AutoSizeText(
                                                    'Added to Wishlist',
                                                    style: Get
                                                        .textTheme.bodyMedium!.copyWith(fontFamily: 'Inter',),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                                  ),
                                          )
                                        : Container(),
                                  ),
                                ),
                                AppSpaces.spaces_width_20,
                                InkWell(
                                  onTap: () {
                                    var body = {
                                      "product": data.singleProductModel!.id,
                                      "type": 0
                                    };
                                    Map<String, String>
                                        requestHeadersWithToken = {
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
                                            duration:
                                                const Duration(seconds: 3),
                                            messageText: const Text(
                                              "Product already in your Vault",
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16.0,
                                                  color: Colors.green),
                                            )).show(context);
                                  },
                                  child: Container(
                                    width: Get.width * .42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      //color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: data.checkSetCheck != null
                                        ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
                                            child:
                                                data.checkSetCheck!.isFound ==
                                                        false
                                                    ? AutoSizeText('Add to Vault',
                                                        style: Get.textTheme
                                                            .bodyMedium!.copyWith(fontFamily: 'Inter',),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,)
                                                    : AutoSizeText('Added to Vault',
                                                        style: Get.textTheme
                                                            .bodyMedium!.copyWith(fontFamily: 'Inter',),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: Get.height*0.05,right:Get.width*0.05336,left:Get.width*0.05336,bottom: Get.height*0.0334 ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Total Distributions",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: 'Inter',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 1;
                                      hour = true;
                                      week = false;
                                      month = false;
                                      two_month = false;
                                      year = false;
                                      getData!.getSingleProduct(
                                          widget.productId,
                                          graphType: 0);
                                    },
                                    child: CategoryCard(
                                      name: '24H',
                                      gradient: hour == true
                                          ? AppColors.buttonTrue
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),

                                ///7 Days
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
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
                                          ? AppColors.buttonTrue
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),

                                ///30 Days
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
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
                                          ? AppColors.buttonTrue
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),

                                ///60 Days
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
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
                                          ? AppColors.buttonTrue
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),

                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
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
                                          ? AppColors.buttonTrue
                                          : const LinearGradient(
                                              colors: [
                                                Color(0xff272E49),
                                                Color(0xff272E49),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: Get.height*0.0223,right:10,left:7,bottom: 0 ),
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
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(top: Get.height*0.05,right:Get.width*0.05336,left:Get.width*0.05336,bottom: Get.height*0.0334 ),
                              child: Text(
                                data.singleProductModel != null
                                    ? data.singleProductModel!.name.toString() +
                                        "'s Details"
                                    : "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ],
                        ),
                      )
                    ];
                  },
                  body: const GraphHelperComics(),
                ),
              )
            : ColorLoader(),
      );
    });
  }
}
