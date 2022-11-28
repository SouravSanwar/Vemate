import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/Graphs/sixty_day_graph_model.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/graph/components/no_graph_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'product_details_collectibles.dart';

class SixtyDayProductGraphPage extends StatefulWidget {
  final bool? fromVault;
  final String? ap;
  const SixtyDayProductGraphPage({Key? key, this.fromVault, this.ap}) : super(key: key);

  @override
  State<SixtyDayProductGraphPage> createState() =>
      _SixtyDayProductGraphPageState();
}

class _SixtyDayProductGraphPageState extends State<SixtyDayProductGraphPage> {
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
      // format: getData!.sixtyDayGraphModel!.floorPrice.toString(),
      header: "",
      tooltipPosition: TooltipPosition.auto,
      canShowMarker: false,
      color: const Color(0xff00A7FF),
    );

    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineColor: const Color(0xff00A7FF),
      lineWidth: 1,
      lineDashArray: <double>[2, 2],
      lineType: CrosshairLineType.vertical,
      activationMode: ActivationMode.singleTap,
    );

    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineWidth: 0,
        shouldAlwaysShow: true,
        tooltipSettings: const InteractiveTooltip(
          canShowMarker: false,
          format: '1000',
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
          child: data.sixtyDayGraphModel != null
              ? data.sixtyDayGraphModel!.graphData!.graph!.isEmpty
              ? const NoGraphCard(
            title: "No data for 60 days!",
          )
              : SfCartesianChart(
            margin: const EdgeInsets.only(
                top: 10, bottom: 2, left: 2, right: 2),
            crosshairBehavior: _crosshairBehavior,
            plotAreaBorderWidth: 0,
            zoomPanBehavior: _zoomPanBehavior,
            // tooltipBehavior: _tooltipBehavior,
            trackballBehavior: TrackballBehavior(
                activationMode: ActivationMode.singleTap,
                enable: true,
                lineWidth: 0,
                shouldAlwaysShow: true,
                builder: (context, tooltipSettings) {
                  return widget.fromVault == true
                      ? Container(
                      height: Get.height*.07,
                      width: Get.width*.3,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: const Color(0xff00A7FF)),
                          color: const Color(0xff00A7FF)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FP',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Text(
                                '\$${tooltipSettings.point?.dataLabelMapper}',
                                style: TextStyle(fontSize: 12.sp),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profit',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Text("\$"+(double.parse(tooltipSettings.point!.dataLabelMapper!)-double.parse(detailsAp!)).toStringAsFixed(2),
                                style: TextStyle(fontSize: 12.sp),
                              )
                            ],
                          ),
                        ],
                      ))
                      : Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: const Color(0xff00A7FF)),
                          color: const Color(0xff00A7FF)),
                      child: Text(
                        '${tooltipSettings.point?.dataLabelMapper}',
                        style: TextStyle(fontSize: 12.sp),
                      ));
                },
                tooltipSettings: const InteractiveTooltip(
                  decimalPlaces: 0,
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
              // labelIntersectAction: AxisLabelIntersectAction.hide,
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
              labelPlacement:
              data.sixtyDayGraphModel!.graphData!.graph!.length == 1
                  ? LabelPlacement.betweenTicks
                  : LabelPlacement.onTicks,
              //maximumLabels: 6
            ),


            primaryYAxis: NumericAxis(

              /*visibleMaximum:  data.sixtyDayGraphModel!.graph![data.sixtyDayGraphModel!.graph!.length-1].floorPrice,*/
              //visibleMinimum: data.sixtyDayGraphModel!.graph!;
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
              // labelIntersectAction: AxisLabelIntersectAction.hide,
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
              data.sixtyDayGraphModel!.graphData!.graph!.length == 1
                  ? ColumnSeries<SixtyDayProductGraph, String>(
                dataSource: data.sixtyDayGraphModel!.graphData!.graph!,
                width: .01,
                gradient: AppColors.graphGradient,
                xValueMapper: (plot, _) =>data.sixtyDayGraphModel!.graphData!.status==0 ? plot.dayWiseTimeWithDate : plot.dayWiseTimeWithDate1,
                yValueMapper: (plot, _) => plot.floorPrice,
              )
                  : SplineAreaSeries<SixtyDayProductGraph, String>(

                dataSource: data.sixtyDayGraphModel!.graphData!.graph!,
                borderColor: const Color(0xff2093D7),
                borderWidth: 1,
                gradient: AppColors.graphGradient,
                xValueMapper: (plot, _) =>data.sixtyDayGraphModel!.graphData!.status==0 ? plot.dayWiseTimeWithDate : plot.dayWiseTimeWithDate1,
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