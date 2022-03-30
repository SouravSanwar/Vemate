//For Items of graphn page
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ketemaa/graph/graph_helper.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';
class HomeVaultCard extends StatefulWidget {

  @override
  State<HomeVaultCard> createState() => _HomeVaultCardState();
}


class _HomeVaultCardState extends State<HomeVaultCard> {

  double percent = 3.30;
  String? selectedValue;



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child:Column(
            children: [
              SizedBox(height: Get.height*.01,),
               Row(
                 children: [
                   SizedBox(
                     width: Get.width * .03,
                   ),
                   Expanded(
                     flex: 5,
                     child: Text(
                       "Vault Value",
                       textAlign: TextAlign.start,
                       style: Get.textTheme.bodyText2!.copyWith(
                           color: AppColors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: 15),
                     ),
                   ),
                   Expanded(
                     flex: 2,
                     child: Text(
                       "MCP",
                       textAlign: TextAlign.start,
                       style: Get.textTheme.bodyText2!.copyWith(
                           color: AppColors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: 15),
                     ),
                   ),
                   Expanded(
                     flex: 3,
                     child: Container(
                       width: Get.width * .15,
                       height: Get.height * .03,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         gradient: AppColors
                             .purpleGradient, // set border width
                         borderRadius: const BorderRadius.all(
                             Radius.circular(
                                 8.0)),
                       ),
                       child: Text(
                         r"$" + "456",
                         textAlign: TextAlign.start,
                         style: Get.textTheme.bodyText2!.copyWith(
                             color: AppColors.white,
                             fontWeight: FontWeight.w600,
                             fontSize: 15),
                       ),
                     ),
                   ),
                   const Expanded(
                     flex: 2,
                     child: Text(
                     ""
                     ),
                   ),
                   Expanded(
                     flex: 4,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child:Container(
                       alignment: Alignment.center,
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton2(
                           hint: const Text(
                             '24H',
                             style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w600,
                                 fontSize: 15
                             ),
                           ),
                           items: <String>['24H','7D', '30D', '1Y']
                               .map((item) => DropdownMenuItem<String>(
                             value: "24 H",
                             child: Text(
                               item,
                               style: const TextStyle(
                                 fontSize: 13,
                                 color: Colors.white,
                               ),
                             ),
                           ))
                               .toList(),
                           value: selectedValue,
                           onChanged: (value) {
                             setState(() {
                               selectedValue = value as String;
                             });
                           },
                           alignment: Alignment.center,
                           dropdownDecoration:
                           BoxDecoration(gradient: AppColors.purpleGradient),
                         ),
                       ),

                       width: Get.width * .15,
                       height: Get.height * .03,
                       decoration: BoxDecoration(
                           border: Border.all(color: AppColors.primaryColor),
                         borderRadius: BorderRadius.circular(8.0),
                       ),
                     ),
                   ),
                   ),

                 ],
               ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * .03,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      r"$" + "4563",
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "187",
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (percent < 0.0)
                        //toRotateIcon
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(
                                45 / 360),
                            child: Icon(
                              Icons.arrow_downward,
                              size: 18,
                              color: Colors.red,
                            ),
                          )
                        else
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(
                                45 / 360),
                            child: Icon(
                              Icons.arrow_upward,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                        Text(
                          percent < 0.0
                              ? percent.toString()
                              : percent.toString() + "%",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: percent < 0.0
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                        ""
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(""),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.only(
                  left: Get.width * .02,
                ),
                height: Get.height * .12,
                child: LineChart(
                  mainData(), // Optional
                  swapAnimationCurve:
                  Curves.easeInOutBack, // Optional
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

            ],
          )
      ),

    );
  }
  List<Color> gradientColors = [];

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
          margin: 0,
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
          margin: 0,
        ),
      ),
      minX: 0,
      maxX: 44,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots:  [
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
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 1,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(0, 1),
              colors: [
                const Color(0xff8053B7),
                const Color(0xff8053B7),
                const Color(0xff584D9F),
                const Color(0xff393E6B),
              ]),
        ),
      ],
    );
  }

}