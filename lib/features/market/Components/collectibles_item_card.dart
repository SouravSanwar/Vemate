import 'dart:ffi';
import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/graph/chart_example.dart';
import '../../../core/models/CollectiblesModel.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/graph_helper.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';

class CollectiblesItemCard extends StatefulWidget {
  List<Results>? list;

  CollectiblesItemCard({
    this.list,
  });

  @override
  State<CollectiblesItemCard> createState() => _CollectiblesItemCardState();
}

class _CollectiblesItemCardState extends State<CollectiblesItemCard> {
  bool _isLoaded = false;
  String? firstHalf;

  @override
  void initState() {
    super.initState();

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

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_8,
        right: AppDimension.padding_8,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list!.length,
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
                  //Get.to(() => ChartExample(id: widget.list![index].id));
                  Flushbar(
                    title: "Hey buddy",
                    message: "You selected ${widget.list![index].name}",
                    duration: const Duration(seconds: 1),
                  ).show(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xff454F70))),
                          alignment: Alignment.center,
                          child: Text(
                            widget.list![index].name
                                .toString()[0]
                                .toUpperCase(),
                            style: TextStyle(
                                color: AppColors.lightBackgroundColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )

                          /*Initicon(
                          text: widget.list![index].name.toString()[0],
                          color:Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          backgroundColor:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          size: 55,

                        ),*/

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
                                        widget.list![index].name.toString(),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                      ),
                                    )),
                                AppSpaces.spaces_width_5,
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.list![index].edition.toString(),
                                      textAlign: TextAlign.start,
                                      style: Get.textTheme.bodyText1!.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w300,
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
                                    widget.list![index].brand.toString(),
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.greyWhite
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10),
                                  ),
                                ),
                                AppSpaces.spaces_width_5,
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    widget.list![index].rarity.toString(),
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.greyWhite
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.w300,
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
                                    '\$' +
                                        widget.list![index].floorPrice
                                            .toString(),
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.greyWhite
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12),
                                  ),
                                ),
                                AppSpaces.spaces_width_5,
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "MCP " +
                                        widget.list![index].rarePoint
                                            .toString(),
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.greyWhite
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 25,
                              child: LineChart(
                                mainData(), // Optional
                                swapAnimationCurve: Curves.linear, // Optional
                              ),
                            ),
                            AppSpaces.spaces_height_10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '\$${widget.list![index].cpp}',
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        widget.list![index].priceChangePercent!
                                            .percent!
                                            .toString(),
                                        textAlign: TextAlign.end,
                                        style: Get.textTheme.bodyText1!
                                            .copyWith(
                                                color: widget
                                                            .list![index]
                                                            .priceChangePercent!
                                                            .sign ==
                                                        'decrease'
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10),
                                      ),
                                      if (widget.list![index]
                                              .priceChangePercent!.sign ==
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
    );
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
          spots: _isLoaded
              ? const [
                  FlSpot(0, 0),
                  FlSpot(2.9, 2),
                  FlSpot(4.4, 3),
                  FlSpot(6.4, 3.1),
                  FlSpot(8, 4),
                  FlSpot(9.5, 4),
                  FlSpot(12, 5),
                  FlSpot(16, 1),
                  FlSpot(20, 8),
                  FlSpot(24, 2),
                  FlSpot(28, 4.1),
                  FlSpot(32, 5),
                  FlSpot(36, 2.9),
                  FlSpot(40, 1.8),
                  FlSpot(44, 6),
                ]
              : const [
                  FlSpot(0, 0),
                  FlSpot(2.4, 0),
                  FlSpot(4.4, 0),
                  FlSpot(6.4, 0),
                  FlSpot(8, 0),
                  FlSpot(9.5, 0),
                  FlSpot(12, 0),
                  FlSpot(16, 0),
                  FlSpot(20, 0),
                  FlSpot(24, 0),
                  FlSpot(28, 0),
                  FlSpot(32, 0),
                  FlSpot(36, 0),
                  FlSpot(40, 0),
                  FlSpot(44, 0),
                ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
          /*belowBarData: BarAreaData(
              show: true,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(0, 1),
              colors: [
                Colors.grey.shade800,
                Colors.grey.shade700,
              ]),*/
        ),
      ],
    );
  }
}
