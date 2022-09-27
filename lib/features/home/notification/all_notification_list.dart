import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../vault/Wishlist/alert/new_alert.dart';

import '../../../core/models/WishListModel.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({Key? key}) : super(key: key);

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList>
    with SingleTickerProviderStateMixin {
  GetData? getData;
  PostData? postData;
  int alertCheck = 0;
  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refreshkey = GlobalKey();

  int? currentIndex = 1;
  bool? notificationSelected = true;
  bool? alarmSelected = false;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    // TODO: implement initState
    postData = Provider.of<PostData>(context, listen: false);

    getData = Provider.of<GetData>(context, listen: false);
    getData!.getWishList();
    setState(() {
      getData!.getNotification();
    });
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.offAll(() => ControllerPage());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Consumer<GetData>(builder: (context, data, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 1.0,
              titleSpacing: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              backgroundColor: AppColors.backgroundColor,
              title: Text(
                notificationSelected == true ? 'Notifications' : "Alarms set",
                style: Get.textTheme.headline2!
                    .copyWith(color: AppColors.textColor),
              ),
              actions: [
                notificationSelected == true
                    ? PopupMenuButton(
                        color: Colors.transparent,
                        itemBuilder: (ctx) => [
                          _buildPopupMenuItem('Mark all as Read'),
                        ],
                      )
                    : Container()
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            currentIndex = 1;
                            setState(() {
                              notificationSelected = true;
                              alarmSelected = false;
                            });
                          },
                          child: CategoryCard(
                            name: 'Notifications',
                            gradient: notificationSelected == true
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
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            currentIndex = 2;
                            setState(() {
                              notificationSelected = false;
                              alarmSelected = true;
                            });
                          },
                          child: CategoryCard(
                            name: 'Alarms Set',
                            gradient: alarmSelected == true
                                ? AppColors.purpleGradient
                                : LinearGradient(
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
              ),
            ),
            body: Container(
              child: notificationSelected == true
                  ? SmartRefresher(
                      key: _refreshkey,
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropMaterialHeader(
                        color: AppColors.primaryColor,
                      ),
                      footer: const ClassicFooter(
                        loadStyle: LoadStyle.ShowWhenLoading,
                      ),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: data.notificationListModel != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  data.notificationListModel!.results!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: SizedBox(
                                        width: Get.width,
                                        child: InkWell(
                                            onTap: () async {
                                              var body = {};

                                              Map<String, String>
                                                  requestHeadersWithToken = {
                                                'Content-type':
                                                    'application/json',
                                                'Accept': 'application/json',
                                                'Authorization':
                                                    'token ${prefs!.getString('token')}',
                                              };

                                              if (data
                                                      .notificationListModel!
                                                      .results![index]
                                                      .target!
                                                      .type ==
                                                  0) {
                                                setState(() {
                                                  postData!
                                                      .notificationRead(
                                                          context,
                                                          data
                                                              .notificationListModel!
                                                              .results![index]
                                                              .id,
                                                          requestHeadersWithToken)
                                                      .whenComplete(() => data
                                                          .notificationListModel!
                                                          .results![index]
                                                          .unread = false);
                                                });
                                                Get.to(() => CollectibleDetails(
                                                      productId: data
                                                          .notificationListModel!
                                                          .results![index]
                                                          .target!
                                                          .id,
                                                      fromNotification: 1,
                                                    ));
                                              } else {
                                                setState(() {
                                                  postData!
                                                      .notificationRead(
                                                          context,
                                                          data
                                                              .notificationListModel!
                                                              .results![index]
                                                              .id,
                                                          requestHeadersWithToken)
                                                      .whenComplete(() => data
                                                          .notificationListModel!
                                                          .results![index]
                                                          .unread = false);
                                                });
                                                Get.to(
                                                  () => ComicDetails(
                                                    productId: data
                                                        .notificationListModel!
                                                        .results![index]
                                                        .target!
                                                        .id,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                ///dot icon
                                                Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    size: 10,
                                                    color: data
                                                                .notificationListModel!
                                                                .results![index]
                                                                .unread ==
                                                            true
                                                        ? const Color(
                                                            0xffA473E6)
                                                        : Colors.transparent,
                                                  ),
                                                ),

                                                ///Image
                                                Container(
                                                    height: 55.h,
                                                    width: 55.h,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor
                                                            .withOpacity(.8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .borderColor)),
                                                    alignment: Alignment.center,
                                                    child: data
                                                                .notificationListModel!
                                                                .results![index]
                                                                .target!
                                                                .image ==
                                                            null
                                                        ? FirstLetterImage(
                                                            firstLetter: data
                                                                .notificationListModel!
                                                                .results![index]
                                                                .description
                                                                .toString()[0]
                                                                .toUpperCase(),
                                                            fontsize: 35,
                                                          )
                                                        : data
                                                                    .notificationListModel!
                                                                    .results![
                                                                        index]
                                                                    .target!
                                                                    .image!
                                                                    .low_res_url ==
                                                                null
                                                            ? VeVeLowImage(
                                                                imageUrl: data
                                                                    .notificationListModel!
                                                                    .results![
                                                                        index]
                                                                    .target!
                                                                    .image!
                                                                    .image_on_list
                                                                    .toString(),
                                                              )
                                                            : VeVeLowImage(
                                                                imageUrl: data
                                                                    .notificationListModel!
                                                                    .results![
                                                                        index]
                                                                    .target!
                                                                    .image!
                                                                    .low_res_url
                                                                    .toString(),
                                                              )),
                                                SizedBox(
                                                  width: Get.width * .02,
                                                ),

                                                ///details
                                                Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data
                                                            .notificationListModel!
                                                            .results![index]
                                                            .description
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Get.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor,
                                                                //fontFamily: 'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    12.sp),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * .01,
                                                      ),
                                                      Text(
                                                        data
                                                            .notificationListModel!
                                                            .results![index]
                                                            .timesince
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Get.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor
                                                                    .withOpacity(
                                                                        .7),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : const ColorLoader())
                  : data.wishListModel != null
                      ? SmartRefresher(
                          key: _refreshkey,
                          controller: refreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          header: WaterDropMaterialHeader(
                            color: AppColors.primaryColor,
                          ),
                          footer: const ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                          ),
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: data.wishListModel!.results != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      data.wishListModel!.results!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return data.wishListModel!.results![index]
                                                .alertData !=
                                            null
                                        ? Stack(
                                            children: [
                                              SwipeActionCell(
                                                backgroundColor: Colors.transparent,
                                                key: ObjectKey(data
                                                    .wishListModel!
                                                    .results![index]),
                                                trailingActions: <SwipeAction>[
                                                  SwipeAction(
                                                    title: "Delete",style: TextStyle(fontSize: 14),
                                                      performsFirstActionWithFullSwipe: true,

                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: AppColors.white,
                                                      ),
                                                      onTap: (CompletionHandler
                                                      handler) async {
                                                        alertCheck = 0;
                                                        if (data
                                                            .wishListModel!
                                                            .results![index]
                                                            .alertData !=
                                                            null) {
                                                          postData!.deleteAlert(
                                                            context,
                                                            data
                                                                .wishListModel!
                                                                .results![index]
                                                                .alertData!
                                                                .id,
                                                            requestHeadersWithToken,
                                                          );
                                                          alertCheck = 1;
                                                        }
                                                        postData!.deleteWishlist(
                                                            context,
                                                            alertCheck,
                                                            data
                                                                .wishListModel!
                                                                .results![index]
                                                                .id,
                                                            requestHeadersWithToken,
                                                            check: 12);
                                                      },
                                                      color: Colors.red),
                                                  SwipeAction(
                                                    title: "Close",style: TextStyle(fontSize: 14),
                                                      icon: Icon(
                                                        Icons.close_sharp,
                                                        color: AppColors.white,
                                                      ),
                                                      onTap: (CompletionHandler
                                                          handler) async {
                                                        handler(false);
                                                      },
                                                      color: Colors.transparent),

                                                ],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.graphCard,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .type ==
                                                                0
                                                            ? Get.to(
                                                                () =>
                                                                    CollectibleDetails(
                                                                  productId: data
                                                                      .wishListModel!
                                                                      .results![
                                                                          index]
                                                                      .productDetail!
                                                                      .id!,
                                                                ),
                                                              )
                                                            : Get.to(
                                                                () =>
                                                                    ComicDetails(
                                                                  productId: data
                                                                      .wishListModel!
                                                                      .results![
                                                                          index]
                                                                      .productDetail!
                                                                      .id!,
                                                                ),
                                                              );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                                height:
                                                                    Get.height *
                                                                        .09,
                                                                width:
                                                                    Get.height *
                                                                        .078,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .backgroundColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .textBoxBgColor)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: data
                                                                            .wishListModel!
                                                                            .results![index]
                                                                            .productDetail!
                                                                            .image ==
                                                                        null
                                                                    ? FirstLetterImage(
                                                                        firstLetter: data
                                                                            .wishListModel!
                                                                            .results![index]
                                                                            .productDetail!
                                                                            .name
                                                                            .toString()[0]
                                                                            .toUpperCase(),
                                                                        fontsize:
                                                                            35,
                                                                      )
                                                                    : data.wishListModel!.results![index].productDetail!.image!.low_res_url == null
                                                                        ? VeVeLowImage(
                                                                            imageUrl:
                                                                                data.wishListModel!.results![index].productDetail!.image!.image_on_list.toString(),
                                                                          )
                                                                        : VeVeLowImage(
                                                                            imageUrl:
                                                                                data.wishListModel!.results![index].productDetail!.image!.low_res_url.toString(),
                                                                          )),
                                                            AppSpaces
                                                                .spaces_width_5,
                                                            Expanded(
                                                              flex: 7,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                Get.height * .02,
                                                                            child:
                                                                                Text(
                                                                              data.wishListModel!.results![index].productDetail!.name.toString(),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.start,
                                                                              style: Get.textTheme.bodyText2!.copyWith(
                                                                                  color: AppColors.textColor,
                                                                                  /*fontFamily:
                                                                        'Inter',*/
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 13.sp),
                                                                            ),
                                                                          )),
                                                                      AppSpaces
                                                                          .spaces_width_2,
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            data.wishListModel!.results![index].productDetail!.edition.toString(),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: Get.textTheme.bodyText1!.copyWith(
                                                                                color: AppColors.textColor,
                                                                                /*fontFamily:
                                                                      'Inter',*/
                                                                                fontWeight: FontWeight.w300,
                                                                                fontSize: 10.sp),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_10,
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Text(
                                                                          data.wishListModel!.results![index].productDetail!.type == 1
                                                                              ? data.wishListModel!.results![index].productDetail!.series != null
                                                                                  ? data.wishListModel!.results![index].productDetail!.series.toString()
                                                                                  : ""
                                                                              : data.wishListModel!.results![index].productDetail!.brand != null
                                                                                  ? data.wishListModel!.results![index].productDetail!.brand!.name.toString()
                                                                                  : "",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: Get.textTheme.bodyText1!.copyWith(
                                                                              color: AppColors.textColor,
                                                                              /*fontFamily:
                                                                    'Inter',*/
                                                                              fontWeight: FontWeight.w900,
                                                                              fontSize: 10.sp),
                                                                        ),
                                                                      ),
                                                                      AppSpaces
                                                                          .spaces_width_2,
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          data
                                                                              .wishListModel!
                                                                              .results![index]
                                                                              .productDetail!
                                                                              .rarity
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: Get.textTheme.bodyText1!.copyWith(
                                                                              color: AppColors.textColor,
                                                                              /*fontFamily:
                                                                    'Inter',*/
                                                                              fontWeight: FontWeight.w300,
                                                                              fontSize: 10.sp),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_10,
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Text(
                                                                          r"$" +
                                                                              data.wishListModel!.results![index].productDetail!.floorPrice.toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: Get.textTheme.bodyText1!.copyWith(
                                                                              color: AppColors.textColor,
                                                                              /*fontFamily:
                                                                    'Inter',*/
                                                                              fontWeight: FontWeight.w900,
                                                                              fontSize: 11.sp),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: InkWell(
                                                                            focusColor: Colors.transparent,
                                                                            onTap: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (ctx) => ShowAlertBox(
                                                                                  results: data.wishListModel!.results![index],
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Icon(
                                                                              Icons.notifications_none,
                                                                              color: data.wishListModel!.results![index].isAlert == true ? AppColors.primaryColor : AppColors.textColor,
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            AppSpaces
                                                                .spaces_width_2,
                                                            Expanded(
                                                              flex: 4,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            .05,
                                                                    child:
                                                                        SfCartesianChart(
                                                                      plotAreaBorderWidth:
                                                                          0,
                                                                      primaryXAxis:
                                                                          CategoryAxis(
                                                                        isVisible:
                                                                            false,
                                                                        majorGridLines:
                                                                            const MajorGridLines(width: 0),
                                                                        labelIntersectAction:
                                                                            AxisLabelIntersectAction.hide,
                                                                        labelRotation:
                                                                            270,
                                                                        labelAlignment:
                                                                            LabelAlignment.start,
                                                                        maximumLabels:
                                                                            7,
                                                                      ),
                                                                      primaryYAxis:
                                                                          NumericAxis(
                                                                        numberFormat:
                                                                            NumberFormat.compact(),
                                                                        isVisible:
                                                                            false,
                                                                        majorGridLines:
                                                                            const MajorGridLines(width: 0),
                                                                        labelIntersectAction:
                                                                            AxisLabelIntersectAction.hide,
                                                                        labelRotation:
                                                                            0,
                                                                        labelAlignment:
                                                                            LabelAlignment.start,
                                                                        maximumLabels:
                                                                            10,
                                                                      ),
                                                                      tooltipBehavior:
                                                                          TooltipBehavior(
                                                                              enable: true),
                                                                      series: <
                                                                          ChartSeries<
                                                                              Graph,
                                                                              String>>[
                                                                        LineSeries<
                                                                            Graph,
                                                                            String>(
                                                                          color: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign == 'decrease'
                                                                              ? Colors.red
                                                                              : Colors.green,
                                                                          dataSource: data
                                                                              .wishListModel!
                                                                              .results![index]
                                                                              .productDetail!
                                                                              .graphData!
                                                                              .graph!,
                                                                          xValueMapper: (Graph plot, _) =>
                                                                              plot.date,
                                                                          yValueMapper: (Graph plot, _) =>
                                                                              plot.floorPrice,
                                                                          xAxisName:
                                                                              'Duration',
                                                                          yAxisName:
                                                                              'Total',
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  AppSpaces
                                                                      .spaces_height_10,
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      /*Expanded(
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.9),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 11),
                                                      ),
                                                    ),*/
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.percent!.toString() + "%",
                                                                              textAlign: TextAlign.end,
                                                                              style: Get.textTheme.bodyText1!.copyWith(color: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign == 'decrease' ? Colors.red : Colors.green, fontFamily: 'Inter', fontWeight: FontWeight.w300, fontSize: 10.sp),
                                                                            ),
                                                                            if (data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign ==
                                                                                'decrease')
                                                                              const Icon(
                                                                                Icons.arrow_downward,
                                                                                color: Colors.red,
                                                                                size: 12,
                                                                              )
                                                                            else
                                                                              const Icon(
                                                                                Icons.arrow_upward,
                                                                                color: Colors.green,
                                                                                size: 12,
                                                                              )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container();
                                  },
                                )
                              : const LoadingExample(),
                        )
                      : const ColorLoader(),
            ),
          );
        }));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getNotification();
    getData!.getWishList();
    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getNotification(offset: offset);
    getData!.getWishList(offset: offset);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
        child: InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LoadingDialogue(
                        message: "Please wait",
                      ));
              postData!
                  .notificationAllRead(context, requestHeadersWithToken)
                  .whenComplete(() => getData!.getNotification());

              await Future.delayed(Duration(seconds: 1));
              Navigator.of(context).pop();
            },
            child: Text(
              title,
              style: TextStyle(color: AppColors.white),
            )));
  }
}
