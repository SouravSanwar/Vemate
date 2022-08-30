import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/Graphs/seven_day_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/sixty_day_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/thirty_day_graph_model.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SixtyDayProductGraphPage extends StatefulWidget {
  const SixtyDayProductGraphPage({Key? key}) : super(key: key);

  @override
  State<SixtyDayProductGraphPage> createState() => _SixtyDayProductGraphPageState();
}

class _SixtyDayProductGraphPageState extends State<SixtyDayProductGraphPage> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _zoomPanBehavior =
        ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true, maximumZoomLevel: 0.3);
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.y',
      header: "",
      tooltipPosition: TooltipPosition.auto,
      canShowMarker: false,
      color: const Color(0xff00A7FF),
    );

    _trackballBehavior = TrackballBehavior(
        enable: true,
        shouldAlwaysShow: true,
        tooltipSettings: const InteractiveTooltip(
            canShowMarker: true, connectorLineColor: Colors.white, enable: true, color: Colors.red),
        markerSettings: const TrackballMarkerSettings(markerVisibility: TrackballVisibilityMode.visible));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.graphCard,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: data.sixtyDayGraphModel != null
              ? SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  zoomPanBehavior: _zoomPanBehavior,
                  tooltipBehavior: _tooltipBehavior,
                  trackballBehavior: _trackballBehavior,
                  primaryXAxis: CategoryAxis(
                    //rangePadding: ChartRangePadding.auto,
                    axisBorderType: AxisBorderType.withoutTopAndBottom,
                    majorGridLines: const MajorGridLines(
                      width: 0,
                    ),
                    majorTickLines: const MajorTickLines(width: 0),
                    axisLine: const AxisLine(width: 0),
                    labelIntersectAction: AxisLabelIntersectAction.hide,
                    labelRotation: 0,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    labelStyle: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Inter',
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic,
                      //fontWeight: FontWeight.w900,
                    ),
                    labelAlignment: LabelAlignment.end,
                    labelPlacement: LabelPlacement.onTicks,
                    maximumLabelWidth: Get.width,
                    //maximumLabels: 6
                  ),
                  primaryYAxis: NumericAxis(
                    axisBorderType: AxisBorderType.withoutTopAndBottom,
                    borderWidth: 0,
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: const MajorGridLines(
                      width: 0,
                    ),
                    majorTickLines: const MajorTickLines(width: 0),
                    labelIntersectAction: AxisLabelIntersectAction.hide,
                    labelRotation: 0,
                    labelStyle: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: 'Inter',
                        fontSize: 8.sp,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900),
                    labelAlignment: LabelAlignment.center,
                  ),
                  series: <ChartSeries<SixtyDayProductGraph, String>>[
                    SplineAreaSeries<SixtyDayProductGraph, String>(
                      dataSource: data.sixtyDayGraphModel!.graph!,
                      borderColor: const Color(0xff2093D7),
                      borderWidth: 1,
                      gradient: AppColors.graphGradient,
                      xValueMapper: (plot, _) => plot.dayWiseTimeWithDate,
                      yValueMapper: (plot, _) => plot.floorPrice,
                      xAxisName: 'Duration',
                      yAxisName: 'Total',
                      enableTooltip: true,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,
                        angle: 270,
                      ),
                      splineType: SplineType.monotonic,
                      cardinalSplineTension: 0.3,
                    ),
                  ],
                )
              : const LoadingExample(),
        ),
      );
    });
  }
}
