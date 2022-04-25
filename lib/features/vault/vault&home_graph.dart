import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
import '../../../core/models/VaultStatusModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VaultHomeGraph extends StatefulWidget {

  final VaultStatsModel? vaultStatsModel;
  const VaultHomeGraph({Key? key,this.vaultStatsModel}) : super(key: key);

  @override
  _VaultHomeGraphState createState() => _VaultHomeGraphState();
}

class _VaultHomeGraphState extends State<VaultHomeGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .12,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        margin: EdgeInsets.zero,
        primaryXAxis: CategoryAxis(
          isVisible: false,
          majorGridLines: const MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.hide,
          labelRotation: 270,
          labelAlignment: LabelAlignment.start,
          maximumLabels: 7,
        ),
        primaryYAxis: CategoryAxis(
          isVisible: false,
          majorGridLines: const MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.hide,
          labelRotation: 0,
          labelAlignment: LabelAlignment.start,
          maximumLabels: 10,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<VaultStatsModelGraph, String>>[
          SplineAreaSeries<VaultStatsModelGraph, String>(
            gradient: AppColors.graphGradient,
            dataSource: widget.vaultStatsModel!.vaultStatsModelGraph!,
            xValueMapper: (VaultStatsModelGraph plot, _) => plot.hour,
            yValueMapper: (VaultStatsModelGraph plot, _) =>
            plot.total,
            xAxisName: 'Duration',
            yAxisName: 'Total',
          )
        ],
      ),
    );
  }
}
