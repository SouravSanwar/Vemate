/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/graph/graph_helper.dart';


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
        */
/*belowBarData: BarAreaData(
              show: true,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(0, 1),
              colors: [
                Colors.grey.shade800,
                Colors.grey.shade700,
              ]),*//*

      ),
    ],
  );
}*/
