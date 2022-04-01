//For Items of graphn page
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';

import 'package:ketemaa/graph/graph_helper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class VaultCollectiblesCard extends StatefulWidget {
  final Collectible? data;

  const VaultCollectiblesCard({Key? key, this.data}) : super(key: key);

  @override
  State<VaultCollectiblesCard> createState() => _VaultCollectiblesCardState();
}

class _VaultCollectiblesCardState extends State<VaultCollectiblesCard> {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Collectibles Value",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$' + widget.data!.totalCollectibleValue!.toString(),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "MCP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$' + widget.data!.mcp!.toString(),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .09,
                      child: widget.data!.collectibleGraph == null
                          ? Container()
                          : SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                isVisible: false,
                                majorGridLines: const MajorGridLines(width: 0),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.hide,
                                labelRotation: 270,
                                labelAlignment: LabelAlignment.start,
                                maximumLabels: 7,
                              ),
                              primaryYAxis: CategoryAxis(
                                isVisible: false,
                                majorGridLines: const MajorGridLines(width: 0),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.hide,
                                labelRotation: 0,
                                labelAlignment: LabelAlignment.start,
                                maximumLabels: 10,
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<CollectibleGraph, String>>[
                                LineSeries<CollectibleGraph, String>(
                                  color: widget.data!.sign! == 'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: widget.data!.collectibleGraph!,
                                  xValueMapper: (CollectibleGraph plot, _) =>
                                      plot.inHour,
                                  yValueMapper: (CollectibleGraph plot, _) =>
                                      plot.total,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                )
                              ],
                            ),
                    ),
                    SizedBox(
                      height: Get.height * .038,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * .1,
                        ),
                        Text(
                          '\$' + widget.data!.changePrice!.toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: Get.width * .05,
                              ),
                              Text(
                                widget.data!.changePercent! < 0.0
                                    ? widget.data!.changePercent!.toString()
                                    : widget.data!.changePercent!.toString() +
                                        "%",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: widget.data!.changePercent! < 0.0
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * .01,
                              ),
                              if (widget.data!.changePercent! < 0.0)
                                const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                  size: 18,
                                )
                              else
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 18,
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
