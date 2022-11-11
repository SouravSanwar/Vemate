import 'package:animate_do/animate_do.dart';
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
import 'package:ketemaa/features/market/Components/reports_step_card.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/date_picker.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/i18n/date_picker_i18n.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/multi_row.dart';
import 'package:ketemaa/features/market/presentation/widgets/details_appbar.dart';
import 'package:ketemaa/graph/one_day_graph_page.dart';
import 'package:ketemaa/graph/one_year_graph_page.dart';
import 'package:ketemaa/graph/product_details_comics.dart';
import 'package:ketemaa/graph/seven_day_graph_page.dart';
import 'package:ketemaa/graph/sixty_day_graph_page.dart';
import 'package:ketemaa/graph/thirty_day_graph_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ComicDetails extends StatefulWidget {
  final int? productId;
  final int? fromNotification;
  final int? productType;
  final bool? fromVault;
  final int? mintId;
  final String? edition;
  final String? ap;
  final String? ad;

  const ComicDetails(
      {Key? key,
      this.productId,
      this.fromNotification = 0,
      this.productType,
      this.fromVault,
      this.mintId,
      this.edition,
      this.ap,
      this.ad})
      : super(key: key);

  @override
  _ComicDetailsState createState() => _ComicDetailsState();
}

class _ComicDetailsState extends State<ComicDetails> {
  GetData? getData;

  PostData? postData;
  TextEditingController mintController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final form = GlobalKey<FormState>();

  DateTime? textDate = DateTime.now();

  List<TextEditingController> storedMintController = [];
  List<TextEditingController> storedPriceController = [];
  List<TextEditingController> storedDateController = [];

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

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

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

    widget.fromNotification == 1 ? getData!.getNotification() : print("no pass from notification");
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
            title: data.singleProductModel != null
                ? DetailsAppbar(
                    name: data.singleProductModel!.name!,
                    results: data.singleProductModel,
                  )
                : Container()),
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
                              padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: Get.height * 0.01667),
                              child: Container(
                                height: data.singleProductModel!.image != null
                                    ? data.singleProductModel!.image!.direction == "PORTRAIT"
                                        ? Get.width * 1.173
                                        : Get.width * .66
                                    : Get.height * .3,
                                width: data.singleProductModel!.image != null ? Get.width * .88 : Get.height * .5,
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
                                        imageUrl: data.singleProductModel!.image!.high_res_url != null
                                            ? data.singleProductModel!.image!.high_res_url.toString()
                                            : data.singleProductModel!.image!.original.toString(),
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
                                    /*  var body = {"product": data.singleProductModel!.id, "type": 0};
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
                                          ).whenComplete(() => getData!.getSetList(''))
                                          .whenComplete(
                                              () => Provider.of<GetData>(context, listen: false).getHomeVault());
                                      await Future.delayed(Duration(seconds: 1));
                                      Navigator.of(context).pop();
                                    }
                                    else {
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
                                    }*/
                                    getData!.maoModel = null;
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => Dialog(
                                              backgroundColor: Colors.transparent,
                                              insetPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                              child: Multiform(id: data.singleProductModel!.id, type: 1),
                                            ));
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
                                            child: /*data.checkSetCheck!.isFound == false
                                                ? */
                                                AutoSizeText(
                                              'Add to Vault',
                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                fontFamily: 'Inter',
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                            /*: AutoSizeText(
                                                    'Delete from Vault',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),*/
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
                            widget.fromVault == true
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            storedMintController.add(
                                              TextEditingController(
                                                text: widget.edition.toString(),
                                              ),
                                            );
                                            storedPriceController.add(
                                              TextEditingController(
                                                text: widget.ap,
                                              ),
                                            );
                                            storedDateController.add(TextEditingController(
                                              text: DateFormat('MMMM dd, yyyy')
                                                  .format(DateTime.parse(widget.ad.toString())),
                                            ));

                                            return Dialog(
                                              backgroundColor: AppColors.backgroundColor,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                              elevation: 16,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Container(
                                                  height: Get.height * .32,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppSpaces.spaces_height_5,

                                                      TextFormField(
                                                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                                                        decoration: InputDecoration(isDense: true),
                                                        controller: storedMintController[0],
                                                      ),
                                                      AppSpaces.spaces_height_2,
                                                      Text(
                                                        'Mint Number or Edition',
                                                        style: TextStyle(color: Colors.grey.withOpacity(.3)),
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                                                        decoration: InputDecoration(isDense: true),
                                                        controller: storedPriceController[0],
                                                      ),
                                                      AppSpaces.spaces_height_2,
                                                      Text(
                                                        'Aquisition Price',
                                                        style: TextStyle(color: Colors.grey.withOpacity(.3)),
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                                                        decoration: InputDecoration(
                                                          isDense: true,
                                                          suffixIcon: InkWell(
                                                            onTap: () async {
                                                              var datePicked = await DatePicker.showSimpleDatePicker(
                                                                context,
                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(2015),
                                                                lastDate: DateTime.now(),
                                                                dateFormat: "dd-MM-yyyy",
                                                                locale: DateTimePickerLocale.en_us,
                                                                looping: true,
                                                                backgroundColor: const Color(0xff02072D),
                                                                textColor: AppColors.white.withOpacity(.7),
                                                              );
                                                              setState(() {
                                                                storedDateController[0].text =
                                                                    datePicked!.toIso8601String();
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.calendar_month,
                                                              color: AppColors.white.withOpacity(.7),
                                                              // size: 17,
                                                            ),
                                                          ),
                                                        ),
                                                        controller: storedDateController[0],
                                                      ),
                                                      AppSpaces.spaces_height_2,
                                                      Text(
                                                        'Aquisition Date',
                                                        style: TextStyle(color: Colors.grey.withOpacity(.3)),
                                                      ),

                                                      AppSpaces.spaces_height_5,

                                                      ///datetime_new_row
                                                      // Container(
                                                      //   height: Get.height * .035,
                                                      //   padding: EdgeInsets.zero,
                                                      //   decoration: BoxDecoration(
                                                      //     border: Border.all(
                                                      //       color: AppColors.white.withOpacity(.7),
                                                      //       width: 1.5,
                                                      //     ),
                                                      //     borderRadius: BorderRadius.circular(10.0),
                                                      //   ),
                                                      //   child: Padding(
                                                      //     padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                                                      //     child: Row(
                                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                                      //       children: [
                                                      //         Text(
                                                      //           DateFormat('yyyy-MM-dd')
                                                      //               .format(DateTime.parse(
                                                      //                   storedDateController[0].text))
                                                      //               .toString(),
                                                      //           style: TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight: FontWeight.bold,
                                                      //             color: AppColors.white.withOpacity(.7),
                                                      //           ),
                                                      //         ),
                                                      //         InkWell(
                                                      //           onTap: () async {
                                                      //             var datePicked =
                                                      //                 await DatePicker.showSimpleDatePicker(
                                                      //               context,
                                                      //               initialDate: DateTime.now(),
                                                      //               firstDate: DateTime(2015),
                                                      //               lastDate: DateTime.now(),
                                                      //               dateFormat: "dd-MM-yyyy",
                                                      //               locale: DateTimePickerLocale.en_us,
                                                      //               looping: true,
                                                      //               backgroundColor: const Color(0xff02072D),
                                                      //               textColor: AppColors.white.withOpacity(.7),
                                                      //             );
                                                      //             setState(() {
                                                      //               storedDateController[0].text =
                                                      //                   datePicked!.toIso8601String();
                                                      //             });
                                                      //           },
                                                      //           child: Icon(
                                                      //             Icons.calendar_month,
                                                      //             color: AppColors.white.withOpacity(.7),
                                                      //             size: 17,
                                                      //           ),
                                                      //         )
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      AppSpaces.spaces_height_25,
                                                      InkWell(
                                                        child: Container(
                                                          width: Get.width * .25,
                                                          margin:
                                                              const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                                          decoration: BoxDecoration(
                                                            color: AppColors.primaryColor,
                                                            borderRadius: BorderRadius.circular(20.0),
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets.all(5.0),
                                                            child: Text(
                                                              'Update',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          var body = {
                                                            "edition": storedMintController[0].text,
                                                            "ap": storedPriceController[0].text,
                                                            "ad": storedDateController[0].text
                                                          };
                                                          postData!
                                                              .editMAO(
                                                                widget.mintId,
                                                                context,
                                                                body,
                                                                requestHeadersWithToken,
                                                              )
                                                              .whenComplete(() => getData!.getVaultProductDetails(
                                                                  widget.productId, widget.productType))
                                                              .whenComplete(() => Navigator.of(context).pop());
                                                        },
                                                      ),
                                                      AppSpaces.spaces_width_5,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Edit",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              //fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ];
                  },
                  body: const ProductDetailsComics(),
                ),
              )
            : ColorLoader(),
      );
    });
  }
}
