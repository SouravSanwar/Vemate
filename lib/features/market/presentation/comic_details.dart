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
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/features/market/Components/reports_step_card.dart';
import 'package:ketemaa/graph/one_day_graph_page.dart';
import 'package:ketemaa/graph/one_year_graph_page.dart';
import 'package:ketemaa/graph/product_details_comics.dart';
import 'package:ketemaa/graph/seven_day_graph_page.dart';
import 'package:ketemaa/graph/single_product_graph.dart';
import 'package:ketemaa/graph/sixty_day_graph_page.dart';
import 'package:ketemaa/graph/thirty_day_graph_page.dart';
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

  int alertCheck = 0;
  int? stepSelected = 0;

  List<String> graphType = [
    '24H',
    '7D',
    '30D',
    '60D',
    '1Y',
  ];
  bool isAddedVault = false;
  bool isAddedWishlist = false;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData!.getSingleProduct(widget.productId);
    getData!.getSingleProductGraphs(widget.productId);

    getData!.checkWishlist(widget.productId!);
    getData!.checkSetList(widget.productId!);
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
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
              data.singleProductModel != null ? data.singleProductModel!.name.toString() : "",
              style: TextStyle(color: AppColors.textColor, fontSize: 18.sp, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: data.singleProductModel != null && data.checkSetCheck != null && data.checkWishlistModel != null
            ? SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ///Image
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0,
                                  right: Get.width * 0.05336,
                                  left: Get.width * 0.05336,
                                  bottom: Get.height * 0.01667),
                              child: Container(
                                height: data.singleProductModel!.image != null
                                    ? data.singleProductModel!.image!.original!.height!.toDouble() * (Get.width * .0011)
                                    : Get.height * .3,
                                width: data.singleProductModel!.image != null
                                    ? data.singleProductModel!.image!.original!.width!.toDouble() * (Get.width * .0011)
                                    : Get.height * .5,
                                //height: Get.height * .5,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    gradient: AppColors.vaultCardGradient,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.primaryColor)),
                                alignment: Alignment.center,
                                child: data.singleProductModel!.image == null
                                    ? Text(
                                        data.singleProductModel!.name.toString()[0].toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.deepPurpleAccent,
                                            //fontFamily: 'Inter',
                                            fontSize: 65,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: data.singleProductModel!.image!.high_res_url.toString(),
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),

                            ///Add Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var body = {"product": data.singleProductModel!.id, "type": 1};
                                    Map<String, String> requestHeadersWithToken = {
                                      'Content-type': 'application/json',
                                      'Accept': 'application/json',
                                      'Authorization': 'token ${prefs!.getString('token')}',
                                    };

                                    if (data.checkWishlistModel!.isFound == false) {
                                      postData!.addToWishlist(
                                        context,
                                        body,
                                        data.singleProductModel!.id,
                                        requestHeadersWithToken,
                                      );
                                    } else {
                                      data.checkWishlistModel!.isFound = false;

                                      if (data.wishListModel!.results!
                                              .firstWhere(
                                                  (element) => element.productDetail!.id == data.singleProductModel!.id)
                                              .alertData !=
                                          null) {
                                        postData!.deleteAlert(
                                            context,
                                            data.wishListModel!.results!
                                                .firstWhere((element) =>
                                                    element.productDetail!.id == data.singleProductModel!.id)
                                                .alertData!
                                                .id,
                                            requestHeadersWithToken);
                                        alertCheck = 1;
                                      }
                                      postData!.deleteWishlist(
                                        context,
                                        alertCheck,
                                        data.wishListModel!.results!
                                            .firstWhere(
                                                (element) => element.productDetail!.id == data.singleProductModel!.id)
                                            .id,
                                        requestHeadersWithToken,
                                      );
                                    }

                                    await Future.delayed(Duration(seconds: 1));
                                    Navigator.of(context).pop();
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
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                                            child: data.checkWishlistModel!.isFound == false
                                                ? AutoSizeText(
                                                    'Add to Wishlist',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                : AutoSizeText(
                                                    'Delete from Wishlist',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                          )
                                        : Container(),
                                  ),
                                ),
                                AppSpaces.spaces_width_20,
                                InkWell(
                                  onTap: () async {
                                    var body = {"product": data.singleProductModel!.id, "type": 0};
                                    Map<String, String> requestHeadersWithToken = {
                                      'Content-type': 'application/json',
                                      'Accept': 'application/json',
                                      'Authorization': 'token ${prefs!.getString('token')}',
                                    };

                                    if (data.checkSetCheck!.isFound == false) {
                                      postData!
                                          .addToSet(
                                            context,
                                            body,
                                            data.singleProductModel!.id,
                                            requestHeadersWithToken,
                                          )
                                          .whenComplete(
                                              () => Provider.of<GetData>(context, listen: false).getHomeVault());
                                      await Future.delayed(Duration(seconds: 1));
                                      Navigator.of(context).pop();
                                    } else {
                                      data.checkSetCheck!.isFound = false;
                                      postData!
                                          .deleteSetList(
                                            context,
                                            data.setListModel!.setResults!
                                                .firstWhere((element) =>
                                                    element.setProductDetail!.id == data.singleProductModel!.id)
                                                .id,
                                            requestHeadersWithToken,
                                            'product__type=1',
                                          )
                                          .whenComplete(
                                              () => Provider.of<GetData>(context, listen: false).getHomeVault());
                                      await Future.delayed(Duration(seconds: 1));
                                      Navigator.of(context).pop();
                                    }
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
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                                            child: data.checkSetCheck!.isFound == false
                                                ? AutoSizeText(
                                                    'Add to Vault',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                : AutoSizeText(
                                                    'Delete from Vault',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.only(
                                  top: Get.height * 0.05,
                                  right: Get.width * 0.05336,
                                  left: Get.width * 0.05336,
                                  bottom: Get.height * 0.0334),
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

                            ///Graph Types
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(graphType.length, (index) {
                                return Expanded(
                                  child: ReportStepCard(
                                    onTap: () {
                                      setState(() {
                                        stepSelected = index;
                                      });
                                    },
                                    stepName: graphType[index].toString(),
                                    selected: stepSelected == index ? true : false,
                                  ),
                                );
                              }),
                            ),

                            ///Graph
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: Get.height * 0.0223, right: 10, left: 7, bottom: 0),
                              width: Get.width,
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 100),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: stepSelected == 0
                                      ? const OneDayProductGraphPage()
                                      : stepSelected == 1
                                          ? const SevenDayProductGraphPage()
                                          : stepSelected == 2
                                              ? const ThirtyDayProductGraphPage()
                                              : stepSelected == 3
                                                  ? const SixtyDayProductGraphPage()
                                                  : stepSelected == 4
                                                      ? const OneYearProductGraphPage()
                                                      : Container(),
                                ),
                              ),
                            ),

                            ///Details
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                  top: Get.height * 0.05,
                                  right: Get.width * 0.05336,
                                  left: Get.width * 0.05336,
                                  bottom: Get.height * 0.0334),
                              child: Text(
                                data.singleProductModel != null
                                    ? data.singleProductModel!.name.toString() + "'s Details"
                                    : "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    //fontFamily: 'Inter',
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
