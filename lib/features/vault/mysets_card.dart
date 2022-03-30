import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/graph/chart_example.dart';
import 'package:ketemaa/graph/graph_helper.dart';

import '../../../../core/models/CollectiblesModel.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class MysetsCard extends StatefulWidget {
  List<Results>? list;

  MysetsCard({
    this.list,
  });

  @override
  State<MysetsCard> createState() => _MysetsCardState();
}

class _MysetsCardState extends State<MysetsCard> {
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
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: Get.width * .37,
              height: Get.height * .22,
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => ChartExample(id: widget.list![index].id));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: Get.width * .37,
                        height: Get.height * .22,
                        decoration: BoxDecoration(
                            gradient: AppColors.cardGradient,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff454F70))),
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * .1,
                              width: Get.width * .3,
                              child: LineChart(
                                mainData(), // Optional
                                swapAnimationCurve:
                                    Curves.easeInOutQuad, // Optional
                              ),
                            ),
                            new Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: Get.height * .02,
                              child: Text(
                                widget.list![index].name.toString().length > 15
                                    ? widget.list![index].name
                                            .toString()
                                            .substring(0, 14) +
                                        "....."
                                    : widget.list![index].name.toString(),
                                textAlign: TextAlign.start,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .02,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: Get.height * .02,
                                        child: Text(
                                          r"$" + widget.list![index].floorPrice
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            percent < 0.0
                                                ? percent.toString()
                                                : "+" + percent.toString(),
                                            textAlign: TextAlign.end,
                                            style: Get.textTheme.bodyText1!
                                                .copyWith(
                                                    color: percent < 0.0
                                                        ? Colors.red
                                                        : Colors.green,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11),
                                          ),
                                          if (percent < 0.0)
                                            const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.red,
                                              size: 14,
                                            )
                                          else
                                            const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.green,
                                              size: 14,
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ],
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
              ? [
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
              : [
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
