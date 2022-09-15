import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/Graphs/one_day_graph_model.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/graph/components/no_graph_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class OneDayProductGraphPage extends StatefulWidget {
  const OneDayProductGraphPage({Key? key}) : super(key: key);

  @override
  State<OneDayProductGraphPage> createState() => _OneDayProductGraphPageState();
}

class _OneDayProductGraphPageState extends State<OneDayProductGraphPage> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;
  late CrosshairBehavior _crosshairBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.xy,
        enablePanning: true,
        //enableSelectionZooming: true,
        enableDoubleTapZooming: true,
        maximumZoomLevel: 0.6);
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: "",
      tooltipPosition: TooltipPosition.auto,
      canShowMarker: false,
      color: const Color(0xff00A7FF),
    );

    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineColor: const Color(0xff00A7FF),
      lineDashArray: <double>[2, 2],
      lineWidth: 1,
      lineType: CrosshairLineType.vertical,
      activationMode: ActivationMode.singleTap,
    );

    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineWidth: 0,
        shouldAlwaysShow: true,
        tooltipSettings: const InteractiveTooltip(
          canShowMarker: false,
          connectorLineColor: Colors.white,
          enable: true,
          color: Color(0xff00A7FF),
        ),
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.auto));

    /*  crosshair behaviour kete diye ei portion er kaj korte hbe

  _trackballBehavior =  TrackballBehavior(
        enable: true,
        lineType: TrackballLineType.vertical,
        activationMode: ActivationMode.singleTap,
        tooltipAlignment: ChartAlignment.center,
        tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
        tooltipSettings: InteractiveTooltip(format: 'point.y'),
        shouldAlwaysShow: false,
        hideDelay: 2000
    );*/
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
          child: data.oneDayGraphModel != null
              ? data.oneDayGraphModel!.graphData!.graph!.isEmpty
                  ? const NoGraphCard(
                      title: "No data for 24 hours!",
                    )
                  : SfCartesianChart(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 2, left: 2, right: 2),
                      crosshairBehavior: _crosshairBehavior,
                      plotAreaBorderWidth: 0,
                      zoomPanBehavior: _zoomPanBehavior,
                      // tooltipBehavior: _tooltipBehavior,
                      trackballBehavior: TrackballBehavior(
                          enable: true,
                          lineWidth: 0,
                          shouldAlwaysShow: true,
                          builder: (context, tooltipSettings) {
                            return Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: const Color(0xff00A7FF)),
                                    color: const Color(0xff00A7FF)),
                                child: Text(
                                    '${tooltipSettings.point?.dataLabelMapper}',style: TextStyle(fontSize: 12.sp),));
                          },
                          tooltipSettings: const InteractiveTooltip(
                            canShowMarker: false,
                            connectorLineColor: Colors.white,
                            enable: true,
                            color: Color(0xff00A7FF),
                          ),
                          markerSettings: const TrackballMarkerSettings(
                              markerVisibility: TrackballVisibilityMode.auto)),


                      primaryXAxis: CategoryAxis(
                        interactiveTooltip: const InteractiveTooltip(
                          enable: false,
                        ),
                        //rangePadding: ChartRangePadding.auto,
                        axisBorderType: AxisBorderType.withoutTopAndBottom,
                        majorGridLines: const MajorGridLines(
                          width: 0,
                        ),
                        majorTickLines: const MajorTickLines(width: 0),
                        axisLine: const AxisLine(width: 0),
                        //labelIntersectAction: AxisLabelIntersectAction.hide,
                        labelRotation: 0,
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: 'Inter',
                          fontSize: 8.sp,
                          fontStyle: FontStyle.italic,
                          //fontWeight: FontWeight.w900,
                        ),
                        labelAlignment: LabelAlignment.center,
                        labelIntersectAction: AxisLabelIntersectAction.wrap,
                        labelPlacement:
                            data.oneDayGraphModel!.graphData!.graph!.length == 1
                                ? LabelPlacement.betweenTicks
                                : LabelPlacement.onTicks,
                        //maximumLabels: 6
                      ),


                      primaryYAxis: NumericAxis(
                        decimalPlaces: 2,
                        numberFormat: NumberFormat.compact(),
                        interactiveTooltip: const InteractiveTooltip(
                          enable: false,
                        ),
                        axisBorderType: AxisBorderType.withoutTopAndBottom,
                        borderWidth: 0,
                        axisLine: const AxisLine(width: 0),
                        majorGridLines: const MajorGridLines(
                          width: 0,
                        ),
                        majorTickLines: const MajorTickLines(width: 0),
                        //labelIntersectAction: AxisLabelIntersectAction.hide,
                        labelRotation: 0,
                        labelStyle: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'Inter',
                            fontSize: 8.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900),
                        labelAlignment: LabelAlignment.center,
                        maximumLabelWidth: 40,
                      ),
                      series: <ChartSeries<OneDayProductGraph, String>>[
                        data.oneDayGraphModel!.graphData!.graph!.length == 1
                            ? ColumnSeries<OneDayProductGraph, String>(
                                width: .01,
                                gradient: AppColors.graphGradient,
                                dataSource: data.oneDayGraphModel!.graphData!.graph!,
                                xValueMapper: (plot, _) => plot.hourWiseTime,
                                yValueMapper: (plot, _) => plot.floorPrice,
                              )
                            : SplineAreaSeries<OneDayProductGraph, String>(
                                dataSource: data.oneDayGraphModel!.graphData!.graph!,
                                borderColor: const Color(0xff2093D7),
                                borderWidth: 1,
                                gradient: AppColors.graphGradient,
                                xValueMapper: (plot, _) => plot.hourWiseTime,
                                yValueMapper: (plot, _) => plot.floorPrice,
                                xAxisName: 'Duration',
                                yAxisName: 'Total',
                                enableTooltip: true,
                                dataLabelMapper: (plot, _) =>
                                    plot.floorPriceString,
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
