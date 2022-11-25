import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/models/Graphs/one_day_graph_model.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/_controller/sign_in_controller.dart';
import 'package:ketemaa/features/auth/verification/otpPage.dart';
import 'package:ketemaa/features/market/Components/reports_step_card.dart';
import 'package:ketemaa/features/market/presentation/Details/DetailsTextField.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/date_picker.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/i18n/date_picker_i18n.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/multi_row.dart';
import 'package:ketemaa/features/market/presentation/widgets/details_appbar.dart';
import 'package:ketemaa/graph/one_year_graph_page.dart';
import 'package:ketemaa/graph/one_day_graph_page.dart';
import 'package:ketemaa/graph/product_details_collectibles.dart';
import 'package:ketemaa/graph/seven_day_graph_page.dart';
import 'package:ketemaa/graph/sixty_day_graph_page.dart';
import 'package:ketemaa/graph/thirty_day_graph_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:marquee/marquee.dart';

class CollectibleDetails extends StatefulWidget {
  final int? productId;
  final int? fromNotification;
  final int? productType;
  final bool? fromVault;
  final int? mintId;
  final String? edition;
  final String? ap;
  final String? ad;
  final int? index;

  const CollectibleDetails({
    Key? key,
    this.productId,
    this.fromNotification = 0,
    this.productType,
    this.fromVault = false,
    this.edition = '',
    this.ap = '',
    this.ad = '',
    this.mintId,
    this.index,
  }) : super(key: key);

  @override
  _CollectibleDetailsState createState() => _CollectibleDetailsState();
}

class _CollectibleDetailsState extends State<CollectibleDetails> {
  GetData? getData;
  TextEditingController mintController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final form = GlobalKey<FormState>();

  String? textDate;

  List<TextEditingController> storedMintController = [];
  List<TextEditingController> storedPriceController = [];
  List<TextEditingController> storedDateController = [];

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

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    super.initState();
    detailsEdition = widget.edition!;
    detailsAp = widget.ap;
    detailsAd = widget.ad;
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData!.getSingleProduct(widget.productId);
    getData!.getSingleProductGraphs(widget.productId);

    getData!.checkWishlist(widget.productId!);
    getData!.checkSetList(widget.productId!);
    getData!.getWishList();

    widget.fromNotification == 1
        ? getData!.getNotification()
        : print("no pass from notification");
  }

  Future<bool> _willPopCallback() async {
    if (widget.fromVault == true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LoadingDialogue(
                message: "Please wait",
              ));
      await getData!
          .getMySets1(0, widget.productId!, true, graph_data: true)
          .whenComplete(() => Navigator.of(context).pop());
    }
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    Get.put(SigninController());
    return Consumer<GetData>(builder: (context, data, child) {
      return WillPopScope(
          onWillPop: _willPopCallback,
          child: Scaffold(
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
                    : Container() /*Container(
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
            body:
                data.singleProductModel != null &&
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
                                      height:
                                          data.singleProductModel!.image != null
                                              ? data.singleProductModel!.image!
                                                          .direction ==
                                                      "PORTRAIT"
                                                  ? Get.width * 1.173
                                                  : Get.width * .66
                                              : Get.height * .3,
                                      width:
                                          data.singleProductModel!.image != null
                                              ? Get.width * .88
                                              : Get.height * .5,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          gradient: AppColors.vaultCardGradient,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.primaryColor)),
                                      alignment: Alignment.center,
                                      child: data.singleProductModel!.image ==
                                              null
                                          ? Text(
                                              data.singleProductModel!.name
                                                  .toString()[0]
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  //fontFamily: 'Inter',
                                                  fontSize: 65,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: data
                                                          .singleProductModel!
                                                          .image!
                                                          .high_res_url !=
                                                      null
                                                  ? data.singleProductModel!
                                                      .image!.high_res_url
                                                      .toString()
                                                  : data.singleProductModel!
                                                      .image!.original
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

                                  ///Add Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var body = {
                                            "product":
                                                data.singleProductModel!.id,
                                            "type": 1
                                          };
                                          Map<String, String>
                                              requestHeadersWithToken = {
                                            'Content-type': 'application/json',
                                            'Accept': 'application/json',
                                            'Authorization':
                                                'token ${prefs!.getString('token')}',
                                          };

                                          if (data.checkWishlistModel!
                                                  .isFound ==
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
                                                      element
                                                          .productDetail!.id ==
                                                      data.singleProductModel!
                                                          .id)
                                                  .id,
                                              requestHeadersWithToken,
                                            );

                                            data.checkWishlistModel!.isFound =
                                                false;
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: data.checkWishlistModel!
                                                        .isFound ==
                                                    false
                                                ? AutoSizeText(
                                                    'Add to Wishlist',
                                                    style: Get
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : AutoSizeText(
                                                    'Delete from Wishlist',
                                                    style: Get
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                      fontFamily: 'Inter',
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      AppSpaces.spaces_width_20,
                                      InkWell(
                                        onTap: () async {
                                          /*var body = {
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


                                  }*/
                                          /*showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.zero,
                                      content: Container(
                                          height: Get.height * .6,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Multiform(id: data.singleProductModel!.id, type: 0)),
                                    ),
                                  );*/
                                          getData!.maoModel = null;
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    insetPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16,
                                                            horizontal: 16),
                                                    child: Multiform(
                                                        id: data
                                                            .singleProductModel!
                                                            .id,
                                                        type: 0),
                                                  ));
                                        },
                                        child: Container(
                                          width: Get.width * .42,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.purpleGradient,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: /* data.checkSetCheck!.isFound == false
                                        ? */
                                                  AutoSizeText(
                                                'Add to Vault',
                                                style: Get.textTheme.bodyMedium!
                                                    .copyWith(
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
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///Graph
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(graphType.length,
                                        (index) {
                                      return Expanded(
                                        child: ReportStepCard(
                                          onTap: () {
                                            setState(() {
                                              stepSelected = index;
                                            });
                                          },
                                          stepName: graphType[index].toString(),
                                          selected: stepSelected == index
                                              ? true
                                              : false,
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
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 250,
                                        child: stepSelected == 0
                                            ?  OneDayProductGraphPage(fromVault: widget.fromVault,ap: widget.ap,)
                                            : stepSelected == 1
                                                ? SevenDayProductGraphPage(fromVault: widget.fromVault,ap: widget.ap,)
                                                : stepSelected == 2
                                                    ? ThirtyDayProductGraphPage(fromVault: widget.fromVault,ap: widget.ap,)
                                                    : stepSelected == 3
                                                        ? SixtyDayProductGraphPage(fromVault: widget.fromVault,ap: widget.ap,)
                                                        : stepSelected == 4
                                                            ?  OneYearProductGraphPage(fromVault: widget.fromVault,ap: widget.ap,)
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.singleProductModel != null
                                                ? data.singleProductModel!.name
                                                        .toString() +
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
                                        widget.fromVault == true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        storedMintController
                                                            .add(
                                                          TextEditingController(
                                                              text: widget
                                                                  .edition),
                                                        );
                                                        storedPriceController
                                                            .add(
                                                          TextEditingController(
                                                              text: widget.ap),
                                                        );
                                                        storedDateController.add(
                                                            TextEditingController(
                                                          text: DateFormat(
                                                                  'MMMM dd, yyyy')
                                                              .format(DateTime
                                                                  .parse(
                                                            widget.ad
                                                                .toString(),
                                                          )),
                                                        ));

                                                        return Dialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .backgroundColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          elevation: 16,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Container(
                                                              height:
                                                                  Get.height *
                                                                      .38,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AppSpaces
                                                                      .spaces_height_5,
                                                                  DetailsTextField(
                                                                    controller:
                                                                        storedMintController[
                                                                            0],
                                                                    textType:
                                                                        TextInputType
                                                                            .number,
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_2,
                                                                  Text(
                                                                    'Mint Number or Edition',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(.5)),
                                                                  ),
                                                                  DetailsTextField(
                                                                    controller:
                                                                        storedPriceController[
                                                                            0],
                                                                    textType:
                                                                        TextInputType
                                                                            .number,
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_2,
                                                                  Text(
                                                                    'Aquisition Price',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(.5)),
                                                                  ),

                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      var datePicked =
                                                                      await DatePicker.showSimpleDatePicker(
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
                                                                        textDate = datePicked!.toIso8601String();
                                                                        storedDateController[0].text = DateFormat('MMMM dd, yyyy').format(DateTime.parse(datePicked.toIso8601String()));
                                                                      });
                                                                    },
                                                                    child:Stack(
                                                                    children: [
                                                                      DetailsTextField(
                                                                        controller:
                                                                            storedDateController[0],
                                                                        enabled: false,
                                                                      ),
                                                                      Positioned(
                                                                        top: 10,
                                                                        right:
                                                                            50,
                                                                        child:
                                                                              Icon(
                                                                            Icons.calendar_month,
                                                                            color:
                                                                                AppColors.white.withOpacity(.7),
                                                                            // size: 17,
                                                                          ),

                                                                      )
                                                                    ],
                                                                  ),
                                                              ),
                                                                  AppSpaces
                                                                      .spaces_height_2,
                                                                  Text(
                                                                    'Aquisition Date',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(.5)),
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_5,
                                                                  AppSpaces
                                                                      .spaces_height_25,
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width:
                                                                        Get.width *
                                                                            .7,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        String? ad = widget.ad ==
                                                                                textDate
                                                                            ? widget.ad
                                                                            : textDate;

                                                                        var body =
                                                                            {
                                                                          "mint_number":
                                                                              storedMintController[0].text,
                                                                          "ap":
                                                                              storedPriceController[0].text,
                                                                          "ad": ad ??
                                                                              DateTime.now().toIso8601String()
                                                                        };
                                                                        print('body: ' +
                                                                            storedPriceController[0].text.isNum.toString());
                                                                        if (storedPriceController[0].text.isNum ==
                                                                            true) {
                                                                          postData!
                                                                              .editMAO(
                                                                                widget.mintId,
                                                                                context,
                                                                                body,
                                                                                requestHeadersWithToken,
                                                                              )
                                                                              .whenComplete(() => {
                                                                                    getData!.getMySets(0, true, graph_data: true),
                                                                                    getData!.getMySets1(0, widget.productId!, true)
                                                                                  })
                                                                              .whenComplete(() => {
                                                                                    Navigator.of(context).pop(),
                                                                                    storedMintController[0].text = data.mySetsModel!.results![widget.index!].mintNumber.toString(),
                                                                                    storedPriceController[0].text = data.mySetsModel!.results![widget.index!].ap!,
                                                                                    storedDateController[0].text = DateFormat('MMMM dd, yyyy').format(DateTime.parse(data.mySetsModel!.results![widget.index!].ad!)),
                                                                                  });
                                                                        } else {
                                                                          showDialog(
                                                                              context: context,
                                                                              barrierDismissible: false,
                                                                              builder: (_) => const ResponseMessage(
                                                                                    icon: Icons.error,
                                                                                    color: Colors.purpleAccent,
                                                                                    message: "Invalid Input",
                                                                                  ));
                                                                        }
                                                                        await Future.delayed(Duration(
                                                                            seconds:
                                                                                1));
                                                                        Navigator.of(context)
                                                                            .pop();

                                                                        printInfo(
                                                                            info:
                                                                                'ap b: ' + prefs!.getString('ap').toString());
                                                                        setState(
                                                                            () {
                                                                          print("Value1" +
                                                                              detailsEdition.toString() +
                                                                              detailsAd.toString() +
                                                                              detailsAp.toString());
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                         alignment: Alignment.center,
                                                                        width: Get.width *
                                                                            0.46,
                                                                        height: Get.height *
                                                                            0.051,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(14.0),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                            'Update',
                                                                            textAlign:
                                                                              TextAlign.center,
                                                                            style:
                                                                              TextStyle(fontSize: 14),
                                                                          ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_width_5,
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      "Edit",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .textColor,
                                                          //fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                            ];
                          },
                          body: ProductDetailsCollectibles(
                            fromVault: widget.fromVault,
                            mintId: widget.mintId,
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  storedMintController
                                      .add(
                                    TextEditingController(
                                        text: widget
                                            .edition),
                                  );
                                  storedPriceController
                                      .add(
                                    TextEditingController(
                                        text: widget.ap),
                                  );
                                  storedDateController.add(
                                      TextEditingController(
                                        text: DateFormat(
                                            'MMMM dd, yyyy')
                                            .format(DateTime
                                            .parse(
                                          widget.ad
                                              .toString(),
                                        )),
                                      ));

                                  return Dialog(
                                    backgroundColor:
                                    AppColors
                                        .backgroundColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5)),
                                    elevation: 16,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .all(20.0),
                                      child: Container(
                                        height:
                                        Get.height *
                                            .38,
                                        margin: EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            AppSpaces
                                                .spaces_height_5,
                                            DetailsTextField(
                                              controller:
                                              storedMintController[
                                              0],
                                              textType:
                                              TextInputType
                                                  .number,
                                            ),
                                            AppSpaces
                                                .spaces_height_2,
                                            Text(
                                              'Mint Number or Edition',
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey
                                                      .withOpacity(.5)),
                                            ),
                                            DetailsTextField(
                                              controller:
                                              storedPriceController[
                                              0],
                                              textType:
                                              TextInputType
                                                  .number,
                                            ),
                                            AppSpaces
                                                .spaces_height_2,
                                            Text(
                                              'Aquisition Price',
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey
                                                      .withOpacity(.5)),
                                            ),
                                            InkWell(
                                              onTap:
                                                  () async {
                                                var datePicked =
                                                await DatePicker.showSimpleDatePicker(
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
                                                  textDate = datePicked!.toIso8601String();
                                                  storedDateController[0].text = DateFormat('MMMM dd, yyyy').format(DateTime.parse(datePicked.toIso8601String()));
                                                });
                                              },
                                              child:Stack(
                                              children: [
                                                DetailsTextField(
                                                  controller:
                                                  storedDateController[0],
                                                  enabled: false,
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  right:
                                                  50,
                                                  child:

                                                    Icon(
                                                      Icons.calendar_month,
                                                      color:
                                                      AppColors.white.withOpacity(.7),
                                                      // size: 17,
                                                    ),

                                                )
                                              ],
                                            ),
                                        ),
                                            AppSpaces
                                                .spaces_height_2,
                                            Text(
                                              'Aquisition Date',
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey
                                                      .withOpacity(.5)),
                                            ),
                                            AppSpaces
                                                .spaces_height_5,
                                            AppSpaces
                                                .spaces_height_25,
                                            Container(
                                              alignment:
                                              Alignment
                                                  .center,
                                              width:
                                              Get.width *
                                                  .7,
                                              child:
                                              InkWell(
                                                onTap:
                                                    () async {
                                                  String? ad = widget.ad ==
                                                      textDate
                                                      ? widget.ad
                                                      : textDate;

                                                  var body =
                                                  {
                                                    "mint_number":
                                                    storedMintController[0].text,
                                                    "ap":
                                                    storedPriceController[0].text,
                                                    "ad": ad ??
                                                        DateTime.now().toIso8601String()
                                                  };
                                                  print('body: ' +
                                                      storedPriceController[0].text.isNum.toString());
                                                  if (storedPriceController[0].text.isNum ==
                                                      true) {
                                                    postData!
                                                        .editMAO(
                                                      widget.mintId,
                                                      context,
                                                      body,
                                                      requestHeadersWithToken,
                                                    )
                                                        .whenComplete(() => {
                                                      getData!.getMySets(0, true, graph_data: true),
                                                      getData!.getMySets1(0, widget.productId!, true)
                                                    })
                                                        .whenComplete(() => {
                                                      Navigator.of(context).pop(),
                                                      storedMintController[0].text = data.mySetsModel!.results![widget.index!].mintNumber.toString(),
                                                      storedPriceController[0].text = data.mySetsModel!.results![widget.index!].ap!,
                                                      storedDateController[0].text = DateFormat('MMMM dd, yyyy').format(DateTime.parse(data.mySetsModel!.results![widget.index!].ad!)),
                                                    });
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (_) => const ResponseMessage(
                                                          icon: Icons.error,
                                                          color: Colors.purpleAccent,
                                                          message: "Invalid Input",
                                                        ));
                                                  }
                                                  await Future.delayed(Duration(
                                                      seconds:
                                                      1));
                                                  Navigator.of(context)
                                                      .pop();

                                                  printInfo(
                                                      info:
                                                      'ap b: ' + prefs!.getString('ap').toString());
                                                  setState(
                                                          () {
                                                        print("Value1" +
                                                            detailsEdition.toString() +
                                                            detailsAd.toString() +
                                                            detailsAp.toString());
                                                      });
                                                },
                                                child:
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: Get.width *
                                                      0.46,
                                                  height: Get.height *
                                                      0.051,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    AppColors.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(14.0),
                                                  ),
                                                  child:
                                                  Text(
                                                    'Update',
                                                    textAlign:
                                                    TextAlign.center,
                                                    style:
                                                    TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            AppSpaces
                                                .spaces_width_5,
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : const ColorLoader(),
          ));
    });
  }
}
