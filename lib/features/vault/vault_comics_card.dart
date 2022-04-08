import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/vault_comics_lists.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class VaultComicsCard extends StatefulWidget {
  final Comic? data;

  const VaultComicsCard({Key? key, this.data}) : super(key: key);

  @override
  State<VaultComicsCard> createState() => _VaultComicsCardState();
}

class _VaultComicsCardState extends State<VaultComicsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
              () => VaultComicsList(),
        );
        /*Get.to(
                                () => ChartExample(id: data.collectiblesModel!.results![index].id));*/
      },
      child:Padding(
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
                        "Comics Value",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        '\$' + widget.data!.totalComicValue!.toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      AppSpaces.spaces_height_30,
                      const Text(
                        "MCP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        '\$' + widget.data!.mcp!.toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      AppSpaces.spaces_height_10,
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .07,
                        child: widget.data!.comicGraph == null
                            ? Container()
                            : SizedBox(
                                height: Get.height * .05,
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    isVisible: false,
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.hide,
                                    labelRotation: 270,
                                    labelAlignment: LabelAlignment.start,
                                    maximumLabels: 7,
                                  ),
                                  primaryYAxis: CategoryAxis(
                                    isVisible: false,
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.hide,
                                    labelRotation: 0,
                                    labelAlignment: LabelAlignment.start,
                                    maximumLabels: 10,
                                  ),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries<ComicGraph, String>>[
                                    LineSeries<ComicGraph, String>(
                                      color: widget.data!.sign! == 'decrease'
                                          ? Colors.red
                                          : Colors.green,
                                      dataSource: widget.data!.comicGraph!,
                                      xValueMapper: (ComicGraph plot, _) =>
                                          plot.hour,
                                      yValueMapper: (ComicGraph plot, _) =>
                                          plot.total,
                                      xAxisName: 'Duration',
                                      yAxisName: 'Total',
                                    )
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: Get.height * .038,
                      ),
                      Row(
                        children: [

                          Text(
                            '\$' + widget.data!.changePrice!.toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: Get.width * .03,
                                ),
                                Text(
                                  widget.data!.changePercent! < 0.0
                                      ? widget.data!.changePercent!
                                          .toStringAsFixed(2)
                                      : widget.data!.changePercent!
                                              .toStringAsFixed(2) +
                                          "%",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: widget.data!.sign == 'decrease'
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: Get.width * .005,
                                ),
                                if (widget.data!.sign == 'decrease')
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
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    ),
    );
  }
}
