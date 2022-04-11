import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import "package:swipeable_tile/swipeable_tile.dart";

class MyWishlistCollectiblesLists extends StatefulWidget {
  const MyWishlistCollectiblesLists({Key? key}) : super(key: key);

  @override
  State<MyWishlistCollectiblesLists> createState() =>
      _MyWishlistCollectiblesListsState();
}

class _MyWishlistCollectiblesListsState
    extends State<MyWishlistCollectiblesLists> {
  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshkey = GlobalKey();

  GetData? getData;

  @override
  void initState() {
    super.initState();
    getData = Provider.of<GetData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return SizedBox(
        height: Get.height * .8,
        child: data.wishListModel!.results!.length != null
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
                child: data.wishListModel!.results!.length != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.wishListModel!.results!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SwipeableTile.card(
                              color: Color(0xff5c5c5c),
                              shadow: BoxShadow(
                                color: Colors.black.withOpacity(0.35),
                                blurRadius: 0,
                                offset: Offset(2, 2),
                              ),
                              horizontalPadding: 16,
                              verticalPadding: 8,
                              direction: SwipeDirection.horizontal,
                              onSwiped: (direction) {
                                // Here call setState to update state
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                // You can animate background using the progress
                                return AnimatedBuilder(
                                  animation: progress,
                                  builder: (context, child) {
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      color: progress.value > 0.4
                                          ? Color(0xFFed7474)
                                          : Color(0xFFeded98),
                                    );
                                  },
                                );
                              },
                              key: UniqueKey(),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.cardGradient,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: data.wishListModel!.results![index]
                                              .productDetail!.type ==
                                          0
                                      ? InkWell(
                                          onTap: () {
                                            /*Get.to(() => ChartExample(id: widget.list![index].id));*/

                                            data.wishListModel!.results![index]
                                                        .productDetail!.type ==
                                                    1
                                                ? Get.to(() => () {})
                                                : Get.to(
                                                    () => CollectibleDetails(
                                                          productId: data
                                                              .wishListModel!
                                                              .results![index]
                                                              .productDetail!
                                                              .id!,
                                                        ));
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
                                                      color: const Color(
                                                          0xD3C89EF3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xff454F70))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data
                                                        .wishListModel!
                                                        .results![index]
                                                        .productDetail!
                                                        .name
                                                        .toString()[0]
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                                    Get.height *
                                                                        .02,
                                                                child: Text(
                                                                  data
                                                                      .wishListModel!
                                                                      .results![
                                                                          index]
                                                                      .productDetail!
                                                                      .name
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: Get
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                          color: AppColors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              13),
                                                                ),
                                                              )),
                                                          AppSpaces
                                                              .spaces_width_2,
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                data
                                                                    .wishListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .edition
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: Get
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            10),
                                                              )),
                                                        ],
                                                      ),
                                                      AppSpaces
                                                          .spaces_height_10,
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
                                                                  ? data.wishListModel!.results![index].productDetail!.series !=
                                                                          null
                                                                      ? data
                                                                          .wishListModel!
                                                                          .results![
                                                                              index]
                                                                          .productDetail!
                                                                          .series
                                                                          .toString()
                                                                      : ""
                                                                  : data.wishListModel!.results![index].productDetail!.brand !=
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
                                                                  TextAlign
                                                                      .start,
                                                              style: Get.textTheme.bodyText1!.copyWith(
                                                                  color: AppColors
                                                                      .greyWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                          AppSpaces
                                                              .spaces_width_2,
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              data
                                                                  .wishListModel!
                                                                  .results![
                                                                      index]
                                                                  .productDetail!
                                                                  .rarity
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Get.textTheme.bodyText1!.copyWith(
                                                                  color: AppColors
                                                                      .greyWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 10),
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
                                                            child: Text(
                                                              r"$" +
                                                                  data
                                                                      .wishListModel!
                                                                      .results![
                                                                          index]
                                                                      .productDetail!
                                                                      .floorPrice
                                                                      .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Get.textTheme.bodyText1!.copyWith(
                                                                  color: AppColors
                                                                      .greyWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 11),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          const Expanded(
                                                            flex: 2,
                                                            child: Text(""),
                                                          ),
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
                                                        height:
                                                            Get.height * .05,
                                                        child: SfCartesianChart(
                                                          plotAreaBorderWidth:
                                                              0,
                                                          primaryXAxis:
                                                              CategoryAxis(
                                                            isVisible: false,
                                                            majorGridLines:
                                                                const MajorGridLines(
                                                                    width: 0),
                                                            labelIntersectAction:
                                                                AxisLabelIntersectAction
                                                                    .hide,
                                                            labelRotation: 270,
                                                            labelAlignment:
                                                                LabelAlignment
                                                                    .start,
                                                            maximumLabels: 7,
                                                          ),
                                                          primaryYAxis:
                                                              CategoryAxis(
                                                            isVisible: false,
                                                            majorGridLines:
                                                                const MajorGridLines(
                                                                    width: 0),
                                                            labelIntersectAction:
                                                                AxisLabelIntersectAction
                                                                    .hide,
                                                            labelRotation: 0,
                                                            labelAlignment:
                                                                LabelAlignment
                                                                    .start,
                                                            maximumLabels: 10,
                                                          ),
                                                          tooltipBehavior:
                                                              TooltipBehavior(
                                                                  enable: true),
                                                          series: <
                                                              ChartSeries<Graph,
                                                                  String>>[
                                                            LineSeries<Graph,
                                                                String>(
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
                                                              dataSource: data
                                                                  .wishListModel!
                                                                  .results![
                                                                      index]
                                                                  .productDetail!
                                                                  .graph!,
                                                              xValueMapper:
                                                                  (Graph plot,
                                                                          _) =>
                                                                      plot.hour,
                                                              yValueMapper:
                                                                  (Graph plot,
                                                                          _) =>
                                                                      plot.total,
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
                                                          Expanded(
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          11),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
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
                                                                      TextAlign
                                                                          .end,
                                                                  style: Get.textTheme.bodyText1!.copyWith(
                                                                      color: data.wishListModel!.results![index].productDetail!.priceChangePercent!.sign ==
                                                                              'decrease'
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          10),
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
                                                                    color: Colors
                                                                        .red,
                                                                    size: 12,
                                                                  )
                                                                else
                                                                  const Icon(
                                                                    Icons
                                                                        .arrow_upward,
                                                                    color: Colors
                                                                        .green,
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
                                        )
                                      : Container(),
                                ),
                              ));
                        },
                      )
                    : const LoadingExample(),
              )
            : LoadingExample(),
      );
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getCollectibles();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getCollectibles(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
