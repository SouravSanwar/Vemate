import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ProductGraph extends StatefulWidget {
  final List<Graph>? graphList;

  const ProductGraph({Key? key, this.graphList}) : super(key: key);

  @override
  State<ProductGraph> createState() => _ProductGraphState();
}

class _ProductGraphState extends State<ProductGraph> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisBorderType: AxisBorderType.withoutTopAndBottom,
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
        labelRotation: 270,
        labelAlignment: LabelAlignment.start,
        maximumLabels: 7,
      ),

      primaryYAxis: CategoryAxis(
        axisBorderType: AxisBorderType.withoutTopAndBottom,
        borderWidth: 0,
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
        labelRotation: 0,
        labelAlignment: LabelAlignment.start,
        maximumLabels: 10,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<Graph, String>>[
        LineSeries<Graph, String>(
          color: Colors.lime,
          dataSource: widget.graphList!,
          xValueMapper: (Graph plot, _) => plot.formattedTime,
          yValueMapper: (Graph plot, _) => plot.price,
          xAxisName: 'Duration',
          yAxisName: 'Total',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            angle: 270,
          ),
        )
      ],
    );
  }
}
