import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertItems.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/WishListModel.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  GetData? getData;

  PostData? postData;

  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refreshkey = GlobalKey();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);

    getData!.getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Wishlist',
              style:
                  Get.textTheme.headline2!.copyWith(color: AppColors.textColor),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const AlertListPage());
              },
              child: Icon(
                Icons.alarm_on,
                color: AppColors.textColor,
              ),
            )
          ],
        ),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.wishListModel != null
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
                        itemCount: data.wishListModel!.results!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      gradient: AppColors.cardGradient,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: AppColors.borderColor)),
                                  child: InkWell(
                                    onTap: () {
                                      data.wishListModel!.results![index]
                                                  .productDetail!.type ==
                                              0
                                          ? Get.to(
                                              () => CollectibleDetails(
                                                productId: data
                                                    .wishListModel!
                                                    .results![index]
                                                    .productDetail!
                                                    .id!,
                                              ),
                                            )
                                          : Get.to(
                                              () => ComicDetails(
                                                productId: data
                                                    .wishListModel!
                                                    .results![index]
                                                    .productDetail!
                                                    .id!,
                                              ),
                                            );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: Get.height * .078,
                                            width: Get.height * .078,
                                            decoration: BoxDecoration(
                                                color: const Color(0xD3C89EF3),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color:
                                                        AppColors.borderColor)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              data
                                                  .wishListModel!
                                                  .results![index]
                                                  .productDetail!
                                                  .name
                                                  .toString()[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 35.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          AppSpaces.spaces_width_2,
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 4,
                                                        child: SizedBox(
                                                          height:
                                                              Get.height * .02,
                                                          child: Text(
                                                            data
                                                                .wishListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .name
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: Get.textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13.sp),
                                                          ),
                                                        )),
                                                    AppSpaces.spaces_width_2,
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          data
                                                              .wishListModel!
                                                              .results![index]
                                                              .productDetail!
                                                              .edition
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: Get.textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize:
                                                                      10.sp),
                                                        )),
                                                  ],
                                                ),
                                                AppSpaces.spaces_height_10,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .type ==
                                                                1
                                                            ? data
                                                                        .wishListModel!
                                                                        .results![
                                                                            index]
                                                                        .productDetail!
                                                                        .series !=
                                                                    null
                                                                ? data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .series
                                                                    .toString()
                                                                : ""
                                                            : data
                                                                        .wishListModel!
                                                                        .results![
                                                                            index]
                                                                        .productDetail!
                                                                        .brand !=
                                                                    null
                                                                ? data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .brand!
                                                                    .name
                                                                    .toString()
                                                                : "",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    ),
                                                    AppSpaces.spaces_width_2,
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        data
                                                            .wishListModel!
                                                            .results![index]
                                                            .productDetail!
                                                            .rarity
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                AppSpaces.spaces_height_10,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        r"$" +
                                                            data
                                                                .wishListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .floorPrice
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize:
                                                                    11.sp),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  ShowAlertBox(
                                                                results: data
                                                                    .wishListModel!
                                                                    .results![index],
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .notifications_none,
                                                            color: data
                                                                        .wishListModel!
                                                                        .results![
                                                                            index]
                                                                        .isAlert ==
                                                                    true
                                                                ? AppColors
                                                                    .primaryColor
                                                                : AppColors
                                                                    .textColor,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          AppSpaces.spaces_width_2,
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * .05,
                                                  child: SfCartesianChart(
                                                    plotAreaBorderWidth: 0,
                                                    primaryXAxis: CategoryAxis(
                                                      isVisible: false,
                                                      majorGridLines:
                                                          const MajorGridLines(
                                                              width: 0),
                                                      labelIntersectAction:
                                                          AxisLabelIntersectAction
                                                              .hide,
                                                      labelRotation: 270,
                                                      labelAlignment:
                                                          LabelAlignment.start,
                                                      maximumLabels: 7,
                                                    ),
                                                    primaryYAxis: CategoryAxis(
                                                      isVisible: false,
                                                      majorGridLines:
                                                          const MajorGridLines(
                                                              width: 0),
                                                      labelIntersectAction:
                                                          AxisLabelIntersectAction
                                                              .hide,
                                                      labelRotation: 0,
                                                      labelAlignment:
                                                          LabelAlignment.start,
                                                      maximumLabels: 10,
                                                    ),
                                                    tooltipBehavior:
                                                        TooltipBehavior(
                                                            enable: true),
                                                    series: <
                                                        ChartSeries<Graph,
                                                            String>>[
                                                      LineSeries<Graph, String>(
                                                        color: data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .priceChangePercent!
                                                                    .sign ==
                                                                'decrease'
                                                            ? Colors.red
                                                            : Colors.green,
                                                        dataSource: data
                                                            .wishListModel!
                                                            .results![index]
                                                            .productDetail!
                                                            .graph!,
                                                        xValueMapper:
                                                            (Graph plot, _) =>
                                                                plot.hour,
                                                        yValueMapper:
                                                            (Graph plot, _) =>
                                                                plot.total,
                                                        xAxisName: 'Duration',
                                                        yAxisName: 'Total',
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                AppSpaces.spaces_height_10,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .priceChangePercent!
                                                                    .percent!
                                                                    .toString() +
                                                                "%",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: Get.textTheme.bodyText1!.copyWith(
                                                                color: data
                                                                            .wishListModel!
                                                                            .results![
                                                                                index]
                                                                            .productDetail!
                                                                            .priceChangePercent!
                                                                            .sign ==
                                                                        'decrease'
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                          if (data
                                                                  .wishListModel!
                                                                  .results![
                                                                      index]
                                                                  .productDetail!
                                                                  .priceChangePercent!
                                                                  .sign ==
                                                              'decrease')
                                                            const Icon(
                                                              Icons
                                                                  .arrow_downward,
                                                              color: Colors.red,
                                                              size: 12,
                                                            )
                                                          else
                                                            const Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color:
                                                                  Colors.green,
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
                              Positioned(
                                bottom: 9.0,
                                right: 10.0,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                AppColors.backgroundColor,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  20.0,
                                                ),
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            titlePadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            title: Text(
                                              data
                                                  .wishListModel!
                                                  .results![index]
                                                  .productDetail!
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.textColor,
                                                  fontSize: 20),
                                            ),
                                            content: Text(
                                              'Do you really want to delete this item?',
                                              style: TextStyle(
                                                  color: AppColors.textColor,
                                                  fontSize: 15),
                                            ),
                                            actions: <Widget>[
                                              CustomButtons(
                                                width: Get.width * .2,
                                                height: Get.height * .05,
                                                onTap: () {
                                                  postData!.deleteWishlist(
                                                    context,
                                                    data.wishListModel!
                                                        .results![index].id,
                                                    requestHeadersWithToken,
                                                  );
                                                },
                                                text: 'Yes'.toUpperCase(),
                                                style: Get.textTheme.button!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textColor),
                                              ),
                                              CustomButtons(
                                                width: Get.width * .2,
                                                height: Get.height * .05,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Close'.toUpperCase(),
                                                style: Get.textTheme.button!
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const LoadingExample(),
              )
            : const LoadingExample();
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getWishList();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getWishList(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
