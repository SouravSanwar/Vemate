import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/vault/mysets_card.dart';
import 'package:ketemaa/features/market/vault/vaule_collectibles_card.dart';
import 'package:ketemaa/features/market/vault/vault_comics_card.dart';
import 'package:ketemaa/features/market/vault/wave_clip.dart';

import 'package:ketemaa/graph/graph_helper.dart';
import 'package:provider/provider.dart';

import '../../../../core/utilities/shimmer/loading.dart';
import 'mywishlist_card.dart';

class Vault extends StatefulWidget {
  @override
  State<Vault> createState() => _VaultState();
}

class _VaultState extends State<Vault> {
  bool _isLoaded = false;
  double scrnHeight = Get.height;
  double scrnWidth = Get.width;

  String? selectedValue;

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

  //For Filter

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    double percent = 3.30;
    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: Color(0xff272E49),
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            //shrinkWrap: true,
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: WaveClip(),
                    child: Container(
                      width: Get.width,
                      height: Get.height * .25,
                      decoration: BoxDecoration(
                        gradient: AppColors.cardGradient,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.width * .1,
                          ),
                          Row(children: [
                            SizedBox(
                              width: Get.width * .05,
                            ),
                            Text(
                              "My Vault",
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodyText2!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            ),
                          ]),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * .05,
                              ),
                              Expanded(
                                flex: 4,
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
                                            16.0)), // set rounded corner radius
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
                              Expanded(
                                flex: 4,
                                child: Text(""),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * .05,
                              ),
                              Expanded(
                                flex: 4,
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
                              Expanded(
                                flex: 4,
                                child: Text(""),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: Get.width * .2,
                            ),
                            alignment: Alignment.centerLeft,
                            height: Get.height * .07,
                            child: LineChart(
                              mainData(), // Optional
                              swapAnimationCurve:
                                  Curves.easeInOutBack, // Optional
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: Get.height * .26),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Collectibles",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    VaultCollectiblesCard(),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Comics",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    VaultComicsCard(),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Sets",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.collectiblesModel != null
                              ? MysetsCard(
                                  list: data
                                      .collectiblesModel!.collectibles!.results,
                                )
                              : LoadingExample(),
                        )),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Wishlist",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.collectiblesModel != null
                              ? MywishlistCard(
                                  list: data
                                      .collectiblesModel!.collectibles!.results,
                                )
                              : LoadingExample(),
                        )),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Get.height * .18,
                left: Get.width * .62,
                right: 0.0,
                child: Container(
                  alignment: Alignment.center,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: const Text(
                        '24H',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      items: <String>[' 24H'' 7D', ' 30D', ' 1Y']
                          .map((item) => DropdownMenuItem<String>(
                                value: "24 H",
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 10,
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
                  width: Get.width * .125,
                  height: Get.width * .125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.purpleGradient,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
