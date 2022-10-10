import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/market/Components/reports_step_card.dart';
import 'package:ketemaa/features/market/presentation/widgets/details_appbar.dart';
import 'package:ketemaa/graph/one_year_graph_page.dart';
import 'package:ketemaa/graph/one_day_graph_page.dart';
import 'package:ketemaa/graph/product_details_collectibles.dart';
import 'package:ketemaa/graph/seven_day_graph_page.dart';
import 'package:ketemaa/graph/sixty_day_graph_page.dart';
import 'package:ketemaa/graph/thirty_day_graph_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:marquee/marquee.dart';

class CollectibleDetails extends StatefulWidget {
  final int? productId;
  final int? fromNotification;


  const CollectibleDetails({Key? key, this.productId,this.fromNotification=0}) : super(key: key);

  @override
  _CollectibleDetailsState createState() => _CollectibleDetailsState();
}

class _CollectibleDetailsState extends State<CollectibleDetails> {
  GetData? getData;

  int alertCheck = 0;
  PostData? postData;
  int? stepSelected = 0;

  List<String> graphType = [
    '24H',
    '7D',
    '30D',
    '60D',
    '1Y',
  ];

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData!.getSingleProduct(widget.productId);
    getData!.getSingleProductGraphs(widget.productId);

    getData!.checkWishlist(widget.productId!);
    getData!.checkSetList(widget.productId!);
    getData!.getWishList();

    widget.fromNotification==1?
    getData!.getNotification(): print("no pass from notification");
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
          title:data.singleProductModel != null
              ?  DetailsAppbar(
            name: data.singleProductModel!.name!,
            results: data.singleProductModel,
          ): Container()/*Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
            child: Text(
              data.singleProductModel != null
                  ? data.singleProductModel!.name.toString()
                  : "",
              style: TextStyle(
                  color: AppColors.textColor,
                  //fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),*/
        ),
        backgroundColor: AppColors.backgroundColor,
        body: data.singleProductModel != null &&
                data.checkSetCheck != null &&
                data.checkWishlistModel != null
            ? SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                          child: Column(
                        children: [
                          ///Image
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0,
                                right: 10,
                                left: 10,
                                bottom: Get.height * 0.01667),
                            child: Container(
                              height: data.singleProductModel!.image != null
                                  ? data.singleProductModel!.image!.direction ==
                                          "PORTRAIT"
                                      ? Get.width * 1.173
                                      : Get.width * .66
                                  : Get.height * .3,
                              width: data.singleProductModel!.image != null
                                  ? Get.width * .88
                                  : Get.height * .5,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  gradient: AppColors.vaultCardGradient,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              alignment: Alignment.center,
                              child: data.singleProductModel!.image == null
                                  ? Text(
                                      data.singleProductModel!.name
                                          .toString()[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          //fontFamily: 'Inter',
                                          fontSize: 65,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: data.singleProductModel!.image!
                                                  .high_res_url !=
                                              null
                                          ? data.singleProductModel!.image!
                                              .high_res_url
                                              .toString()
                                          : data.singleProductModel!.image!
                                              .original
                                              .toString(),
                                      imageBuilder: (context, imageProvider) =>
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

                          ///Add Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
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

                                  if (data.checkWishlistModel!.isFound ==
                                      false) {
                                    postData!.addToWishlist(
                                      context,
                                      body,
                                      data.singleProductModel!.id,
                                      requestHeadersWithToken,
                                    );
                                  } else {
                                    postData!.deleteWishlist(
                                      context,
                                      alertCheck,
                                      data.wishListModel!.results!
                                          .firstWhere((element) =>
                                              element.productDetail!.id ==
                                              data.singleProductModel!.id)
                                          .id,
                                      requestHeadersWithToken,
                                    );

                                    data.checkWishlistModel!.isFound = false;
                                  }

                                  await Future.delayed(
                                      const Duration(seconds: 1));
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: data.checkWishlistModel!.isFound ==
                                            false
                                        ? AutoSizeText(
                                            'Add to Wishlist',
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontFamily: 'Inter',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : AutoSizeText(
                                            'Delete from Wishlist',
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontFamily: 'Inter',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                ),
                              ),
                              AppSpaces.spaces_width_20,
                              InkWell(
                                onTap: () async {
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

                                  if (data.checkSetCheck!.isFound == false) {
                                    postData!
                                        .addToSet(
                                          context,
                                          body,
                                          data.singleProductModel!.id,
                                          requestHeadersWithToken,
                                        ).whenComplete(() => getData!.getSetList(''))
                                        .whenComplete(
                                            () => getData!.getHomeVault());
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.of(context).pop();
                                  } else {
                                    data.checkSetCheck!.isFound = false;
                                    postData!
                                        .deleteSetList(
                                          context,
                                          data.setListModel!.setResults!
                                              .firstWhere((element) =>
                                                  element
                                                      .setProductDetail!.id ==
                                                  data.singleProductModel!.id)
                                              .id,
                                          requestHeadersWithToken,
                                          'product__type=0',
                                        )
                                        .whenComplete(() =>
                                            Provider.of<GetData>(context,
                                                    listen: false)
                                                .getHomeVault());


                                  }
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: data.checkSetCheck!.isFound == false
                                        ? AutoSizeText(
                                            'Add to Vault',
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontFamily: 'Inter',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : AutoSizeText(
                                            'Delete from Vault',
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontFamily: 'Inter',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
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
                              "Floor Price Chart",
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
                                  selected:
                                      stepSelected == index ? true : false,
                                ),
                              );
                            }),
                          ),

                          ///Graph
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: Get.height * 0.0223,
                                right: 10,
                                left: 7,
                                bottom: 0),
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
                                  ? data.singleProductModel!.name.toString() +
                                      "'s Details"
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
                      ))
                    ];
                  },
                  body: const ProductDetailsCollectibles(),
                ),
              )
            : const ColorLoader(),
      );
    });
  }
}
