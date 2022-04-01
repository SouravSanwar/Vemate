import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/graph/chart_example.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/models/CollectiblesModel.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/graph_helper.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';

class CollectiblesItemCard extends StatefulWidget {
  const CollectiblesItemCard({Key? key}) : super(key: key);

  @override
  State<CollectiblesItemCard> createState() => _CollectiblesItemCardState();
}

class _CollectiblesItemCardState extends State<CollectiblesItemCard> {
  bool _isLoaded = false;
  String? firstHalf;

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

    getData!.getCollectibles();

    // make _isLoaded true after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double percent = 3.30;

    return Consumer<GetData>(builder: (context, data, child) {
      return SizedBox(
        height: Get.height * .7,
        child: data.collectiblesModel != null
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
                  itemCount: data.collectiblesModel!.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: AppColors.cardGradient,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => CollectibleDetails(
                                productId:
                                    data.collectiblesModel!.results![index].id,
                              ),
                            );
                            /*Get.to(
                                () => ChartExample(id: data.collectiblesModel!.results![index].id));*/
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
                                      color: const Color(0xD3C89EF3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xff454F70))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data.collectiblesModel!.results![index].name
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                AppSpaces.spaces_width_5,
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 5,
                                              child: SizedBox(
                                                height: Get.height * .02,
                                                child: Text(
                                                  data.collectiblesModel!
                                                      .results![index].name
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
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
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                data.collectiblesModel!
                                                    .results![index].edition
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: Get.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10),
                                              )),
                                        ],
                                      ),
                                      AppSpaces.spaces_height_10,
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              data.collectiblesModel!
                                                  .results![index].brand
                                                  .toString(),
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
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              data.collectiblesModel!
                                                  .results![index].rarity
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
                                            flex: 5,
                                            child: Text(
                                              r"$" +
                                                  data
                                                      .collectiblesModel!
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
                                                      fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "MCP " +
                                                  data.collectiblesModel!
                                                      .results![index].rarePoint
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
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Get.height * .03,
                                        child: LineChart(
                                          mainData(), // Optional
                                          swapAnimationCurve:
                                              Curves.linear, // Optional
                                        ),
                                      ),
                                      AppSpaces.spaces_height_10,
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$${data.collectiblesModel!.results![index].cpp}',
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                  color: AppColors.white
                                                      .withOpacity(0.9),
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  data
                                                      .collectiblesModel!
                                                      .results![index]
                                                      .priceChangePercent!
                                                      .percent!
                                                      .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                      color: data
                                                          .collectiblesModel!
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
                                                    .collectiblesModel!
                                                    .results![index]
                                                    .priceChangePercent!
                                                    .sign ==
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
                    );
                  },
                ),
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

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d31a),
  ];

  LineChartData mainData() {
    return LineChartData(
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
          show: false,
          horizontalInterval: 1.6,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              dashArray: const [3, 3],
              color: const Color(0xff37434d).withOpacity(0.2),
              strokeWidth: 2,
            );
          },
          drawVerticalLine: false),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 8),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return gh.aa;
              case 4:
                return gh.bb;
              case 8:
                return gh.cc;
              case 12:
                return gh.dd;
              case 16:
                return gh.ee;
              case 20:
                return gh.ff;
              case 24:
                return gh.gg;
              case 28:
                return gh.hh;
              case 32:
                return gh.ii;
              case 36:
                return gh.jj;
              case 40:
                return gh.kk;
              case 44:
                return gh.ll;
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10';
              case 3:
                return '30';
              case 5:
                return '50';
              case 7:
                return '70';
              case 9:
                return '90';
            }
            return '';
          },
          reservedSize: 25,
          margin: 2,
        ),
      ),
      minX: 0,
      maxX: 45,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            const FlSpot(2.9, 2),
            const FlSpot(4.4, 3),
            const FlSpot(6.4, 3.1),
            const FlSpot(8, 4),
            const FlSpot(9.5, 4),
            const FlSpot(12, 5),
            const FlSpot(16, 1),
            const FlSpot(20, 8),
            const FlSpot(24, 2),
            const FlSpot(28, 4.1),
            const FlSpot(32, 5),
            const FlSpot(36, 2.9),
            const FlSpot(40, 1.8),
            const FlSpot(44, 6),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
