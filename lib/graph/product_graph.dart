import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductGraph extends StatefulWidget {
  final List<Graph>? graphList;
  final String? graphType;
  const ProductGraph({Key? key, this.graphList, this.graphType}) : super(key: key);

  @override
  State<ProductGraph> createState() => _ProductGraphState();
}

class _ProductGraphState extends State<ProductGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return data.singleProductModel != null
          ? SfCartesianChart(
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
                  color: Colors.green,
                  dataSource: data.singleProductModel!.graph!,
                  xValueMapper: (plot, _) => widget.graphType == '0' ? plot
                  .hourWiseTime : plot.dayWiseTime,
                  yValueMapper: (plot, _) => plot.price,
                  xAxisName: 'Duration',
                  yAxisName: 'Total',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                    angle: 270,
                  ),
                )
              ],
            )
          : LoadingExample();
    });
  }
}
