import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/graph_helper.dart';
import 'package:provider/provider.dart';
import '../core/Provider/getData.dart';

class ChartExample extends StatefulWidget {
  int? id;

  ChartExample({Key? key, this.id}) : super(key: key);

  @override
  _ChartExampleState createState() => _ChartExampleState();
}

class _ChartExampleState extends State<ChartExample> {
  var collectible = Get.arguments;

  bool _isLoaded = false;
  int _currentIndex = 0;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var fetchData = Provider.of<GetData>(context, listen: false);
    fetchData.getSingleProduct(widget.id);

    // make _isLoaded true after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff272E49),
          elevation: 4,
          title: Text(
            data.singleCollectibleModel != null
                ? data.singleCollectibleModel!.details!.name.toString()
                : "",
            style: TextStyle(
                color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),

        ),
        backgroundColor: AppColors.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      child: LineChart(
                        mainData(),
                        swapAnimationDuration: const Duration(milliseconds: 1000),
                        // Optional
                        swapAnimationCurve: Curves.bounceIn, // Optional
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: const GraphHelper(),
        ),
      );
    });
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
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
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 8),
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
            color: Colors.white,
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
                  const FlSpot(0, 3),
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
                  const FlSpot(44, 3),
                ]
              : [
                  const FlSpot(0, 0),
                  const FlSpot(2.4, 0),
                  const FlSpot(4.4, 0),
                  const FlSpot(6.4, 0),
                  const FlSpot(8, 0),
                  const FlSpot(9.5, 0),
                  const FlSpot(12, 0),
                  const FlSpot(16, 0),
                  const FlSpot(20, 0),
                  const FlSpot(24, 0),
                  const FlSpot(28, 0),
                  const FlSpot(32, 0),
                  const FlSpot(36, 0),
                  const FlSpot(40, 0),
                  const FlSpot(44, 0),
                ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradientFrom: const Offset(0, 0),
              gradientTo: const Offset(0, 1),
              colors: [
                const Color(0xff02d39a).withOpacity(0.1),
                const Color(0xff02d39a).withOpacity(0),
              ]),
        ),
      ],
    );
  }
}
