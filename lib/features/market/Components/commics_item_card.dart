import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/Provider/getData.dart';

import '../../../core/models/ComicsModel.dart';

class ComicsItemCard extends StatefulWidget {
  const ComicsItemCard({Key? key}) : super(key: key);

  @override
  State<ComicsItemCard> createState() => _ComicsItemCardState();
}

class _ComicsItemCardState extends State<ComicsItemCard> {
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

    getData!.getComics();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return SizedBox(
        height: Get.height * .8,
        child: data.comicsModel != null
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: data.comicsModel!.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff454F70),
                              Color(0xff3F496A),
                              Color(0xff374162),
                              Color(0xff303B5B),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => ComicDetails(
                                productId: data.comicsModel!.results![index].id,
                              ),
                            );

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: Get.height * .078,
                                  width: Get.height * .078,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xff454F70))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data.comicsModel!.results![index].name
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.lightBackgroundColor,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                AppSpaces.spaces_width_2,
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                height: Get.height * .02,
                                                child: Text(
                                                  data.comicsModel!
                                                      .results![index].name
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get
                                                      .textTheme.bodyText2!
                                                      .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                ),
                                              )),
                                          AppSpaces.spaces_width_2,
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              data.comicsModel!.results![index]
                                                  .edition
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppSpaces.spaces_height_10,
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child:data.comicsModel!.results![index]
                                                .series==null? Text("") : Text(
                                              data.comicsModel!.results![index]
                                                  .series
                                                  .toString(),
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 10),
                                            ),
                                          ),
                                          AppSpaces.spaces_width_2,
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              data.comicsModel!.results![index]
                                                  .rarity
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 10),
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
                                              '\$' +
                                                  data
                                                      .comicsModel!
                                                      .results![index]
                                                      .floorPrice
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 11),
                                            ),
                                          ),
                                          AppSpaces.spaces_width_2,
                                          const Expanded(
                                            flex: 2,
                                            child: Text("" ),
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
                                        height: Get.height * .05,
                                        child: data.comicsModel!
                                            .results![index].graph == null? Text("") : SfCartesianChart(
                                          plotAreaBorderWidth: 0,
                                          primaryXAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            labelIntersectAction:
                                                AxisLabelIntersectAction.hide,
                                            labelRotation: 270,
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 7,
                                          ),
                                          primaryYAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            labelIntersectAction:
                                                AxisLabelIntersectAction.hide,
                                            labelRotation: 0,
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 10,
                                          ),
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <ChartSeries<Graph, String>>[
                                            LineSeries<Graph, String>(
                                              color: data
                                                          .comicsModel!
                                                          .results![index]
                                                          .priceChangePercent!
                                                          .sign ==
                                                      'decrease'
                                                  ? Colors.red
                                                  : Colors.green,
                                              dataSource: data.comicsModel!
                                                  .results![index].graph!,
                                              xValueMapper: (Graph plot, _) =>
                                                  plot.inHour,
                                              yValueMapper: (Graph plot, _) =>
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$${data.comicsModel!
                                                  .results![index]
                                                  .priceChangePercent!
                                                  .changePrice !=null
                                                  ?data.comicsModel!
                                                  .results![index]
                                                  .priceChangePercent!
                                                  .changePrice!
                                                  .toStringAsFixed(2)
                                                  :""

                                              }',
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.white
                                                          .withOpacity(0.9),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11),
                                            ),
                                          ),
                                          AppSpaces.spaces_width_2,
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  data
                                                      .comicsModel!
                                                      .results![index]
                                                      .priceChangePercent!
                                                      .percent!
                                                      .toStringAsFixed(2)+"%",
                                                  textAlign: TextAlign.end,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: data
                                                                      .comicsModel!
                                                                      .results![
                                                                          index]
                                                                      .priceChangePercent!
                                                                      .sign ==
                                                                  'decrease'
                                                              ? Colors.red
                                                              : Colors.green,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 10),
                                                ),
                                                if (data
                                                        .comicsModel!
                                                        .results![index]
                                                        .priceChangePercent!
                                                        .sign ==
                                                    'decrease')
                                                  const Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.red,
                                                    size: 10,
                                                  )
                                                else
                                                  const Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.green,
                                                    size: 10,
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
                    );
                  },
                ),
              )
            : const LoadingExample(),
      );
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    getData!.getComics();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getComics(offset: offset);

    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
