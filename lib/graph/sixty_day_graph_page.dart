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
  State<SixtyDayProductGraphPage> createState() => _SixtyDayProductGraphPageState();
}

class _SixtyDayProductGraphPageState extends State<SixtyDayProductGraphPage> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;
  late CrosshairBehavior _crosshairBehavior;
  final tooltipBoxColor=const Color(0xff3E488F);
  final gridColor=Colors.grey.withOpacity(0.2);

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
        markerSettings: const TrackballMarkerSettings(markerVisibility: TrackballVisibilityMode.auto));

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
            margin: const EdgeInsets.only(top: 10, bottom: 2, left: 2, right: 2),
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
                  var profit =
                  widget.fromVault == true?
                  (double.parse(tooltipSettings.point!.dataLabelMapper!) - double.parse(detailsAp!))
                      :0;

                  return widget.fromVault == true
                      ? Container(
                      height: Get.height * .07,
                      width: Get.width * .3,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: tooltipBoxColor),
                          color: tooltipBoxColor),
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
                              Text(
                                profit > 0
                                    ? "\$" + profit.toStringAsFixed(2)
                                    : "-\$" + (profit.abs().toStringAsFixed(2)),
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
                          border: Border.all(color: tooltipBoxColor),
                          color: tooltipBoxColor),
                      child: Text(
                        '${tooltipSettings.point?.dataLabelMapper}',
                        style: TextStyle(fontSize: 12.sp),
                      ));
                },
                tooltipSettings: const InteractiveTooltip(
                  canShowMarker: false,
                  connectorLineColor: Colors.white,
                  enable: true,
                  color: Color(0xff3E488F),
                ),
                markerSettings:
                const TrackballMarkerSettings(markerVisibility: TrackballVisibilityMode.auto)),
            axes: [
              NumericAxis(

                  axisLine: AxisLine(color: gridColor),
                  name: 'second',
                  opposedPosition: true,
                  interval: widget.fromVault == true ?double.parse(detailsAp!):1,
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  axisLabelFormatter: (args) {
                    return ChartAxisLabel(
                        widget.fromVault == true ?
                        double.parse(args.value.toString())==double.parse(detailsAp!) ? 'AP' : ''
                            :"",
                        args.textStyle);
                  },
                  interactiveTooltip: const InteractiveTooltip(
                    enable: false,
                  ),
                  enableAutoIntervalOnZooming: false,
                  labelIntersectAction: AxisLabelIntersectAction.none,
                  maximum:widget.fromVault == true ?
                  double.parse(detailsAp!) > maxPriceSixtyDayGraph!
                      ? double.parse(detailsAp!) + (double.parse(detailsAp!)*.1)
                      : maxPriceSixtyDayGraph!+(maxPriceSixtyDayGraph!*.2)
                      :null,
                  minimum: widget.fromVault == true ? 0 :null

              )

            ],

            primaryXAxis: CategoryAxis(
              interactiveTooltip: const InteractiveTooltip(
                enable: false,
              ),
              //rangePadding: ChartRangePadding.auto,
              axisBorderType: AxisBorderType.withoutTopAndBottom,
              borderWidth: 0,
              minorGridLines: MinorGridLines(color: gridColor),
              majorTickLines: const MajorTickLines(width: 0),
              minorTicksPerInterval: 0,
              axisLine: AxisLine(color: gridColor),
              majorGridLines: MajorGridLines(color: gridColor),
              //labelIntersectAction: AxisLabelIntersectAction.hide,
              // labelRotation: 90,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: TextStyle(
                color: AppColors.textColor,
                fontFamily: 'Inter',
                fontSize: 7.sp,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),
              labelAlignment: LabelAlignment.center,
              //labelIntersectAction: AxisLabelIntersectAction.wrap,
              labelPlacement: data.oneDayGraphModel!.graphData!.graph!.length == 1
                  ? LabelPlacement.betweenTicks
                  : LabelPlacement.onTicks,
              //maximumLabels: 6
            ),

            primaryYAxis: NumericAxis(
                plotBands: <PlotBand>[
                  PlotBand(
                    verticalTextPadding: '0%',
                    horizontalTextPadding: '0%',
                    text:  "",
                    textAngle: 0,
                    start: widget.fromVault == true ? double.parse(detailsAp!) : 0,
                    end: widget.fromVault == true ? double.parse(detailsAp!) : 0,
                    textStyle: TextStyle(color: AppColors.textColor.withOpacity(.5), fontSize: 8),
                    horizontalTextAlignment: TextAnchor.end,
                    borderColor: widget.fromVault == true ? const Color(0xffFFFFFF) : AppColors.graphCard,
                    borderWidth: 1.5,
                    dashArray: [2,2]
                  )
                ],
                decimalPlaces: 2,
                numberFormat: NumberFormat.compact(),
                interactiveTooltip: const InteractiveTooltip(
                  enable: false,
                ),
                axisBorderType: AxisBorderType.withoutTopAndBottom,
                borderWidth: 0,
                minorGridLines: MinorGridLines(color: gridColor),
                majorTickLines: const MajorTickLines(width: 0),
                minorTicksPerInterval: 0,
                axisLine: AxisLine(color: gridColor),
                majorGridLines: MajorGridLines(color: gridColor),
                //labelIntersectAction: AxisLabelIntersectAction.hide,
                labelRotation: 0,
                labelStyle: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Inter',
                    fontSize: 7.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
                labelAlignment: LabelAlignment.center,
                maximumLabelWidth: 40,
                maximum:widget.fromVault == true ?
                double.parse(detailsAp!) > maxPriceSixtyDayGraph!
                    ? double.parse(detailsAp!) + (double.parse(detailsAp!)*.1)
                    : maxPriceSixtyDayGraph!+(maxPriceSixtyDayGraph!*.2)
                    :null,
                minimum: widget.fromVault == true ? 0 :null
            ),
            series: <ChartSeries<SixtyDayProductGraph, String>>[
              data.sixtyDayGraphModel!.graphData!.graph!.length == 1
                  ? ColumnSeries<SixtyDayProductGraph, String>(
                dataSource: data.sixtyDayGraphModel!.graphData!.graph!,
                width: .01,
                gradient: AppColors.graphGradient,
                xValueMapper: (plot, _) => data.sixtyDayGraphModel!.graphData!.status == 0
                    ? plot.dayWiseTimeWithDate
                    : plot.dayWiseTimeWithDate1,
                yValueMapper: (plot, _) => plot.floorPrice, //widget.fromVault == true ? plot.floorPrice1 : plot.floorPrice,
              )
                  : SplineAreaSeries<SixtyDayProductGraph, String>(
                dataSource: data.sixtyDayGraphModel!.graphData!.graph!,
                borderColor: const Color(0xff8A56E1),
                //color: Colors.transparent,
                gradient: AppColors.graphGradient.scale(.8),
                borderWidth: 1,
                xValueMapper: (plot, _) => data.sixtyDayGraphModel!.graphData!.status == 0
                    ? plot.dayWiseTimeWithDate
                    : plot.dayWiseTimeWithDate1,
                yValueMapper: (plot, _) => plot.floorPrice, //widget.fromVault == true ? plot.floorPrice1 : plot.floorPrice,
                xAxisName: 'Duration',
                yAxisName: 'Total',
                enableTooltip: true,
                dataLabelMapper: (plot, _) => plot.floorPriceString,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                  angle: 270,
                ),
                splineType: SplineType.monotonic,
                cardinalSplineTension: 0.3,
              ),
              LineSeries(
                yAxisName: 'second',
                dataSource: [],
                xValueMapper: (plot, _) => data.sixtyDayGraphModel!.graphData!.status == 0
                    ? plot.dayWiseTimeWithDate
                    : plot.dayWiseTimeWithDate1,
                yValueMapper: (plot, _) => plot.floorPrice, //widget.fromVault == true ? plot.floorPrice1 : plot.floorPrice,
              )
            ],
          )
              : const LoadingExample(),
        ),
      );
    });
  }
}
