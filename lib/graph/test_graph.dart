import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphTest extends StatefulWidget {
  final List<Graph>? graphList;

  const GraphTest({Key? key, this.graphList}) : super(key: key);

  @override
  State<GraphTest> createState() => _GraphTestState();
}

class _GraphTestState extends State<GraphTest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            //title: ChartTitle(text: 'Half yearly sales analysis'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<Graph, String>>[
              LineSeries<Graph, String>(
                dataSource: widget.graphList!,
                xValueMapper: (Graph plot, _) => plot.formattedTime,
                yValueMapper: (Graph plot, _) => plot.price,
                xAxisName: 'Duration',
                yAxisName: 'Total',
                name: 'Comic',
                //dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
        /*Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfSparkLineChart.custom(
              dataCount: widget.graphList!.length,
              trackball: const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              marker: const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => widget.graphList![index].inHour,
              yValueMapper: (int index) =>
                  widget.graphList![index].total!.toInt(),
              isInversed: true,

            ),
          ),
        ),*/
      ],
    );
  }
}
