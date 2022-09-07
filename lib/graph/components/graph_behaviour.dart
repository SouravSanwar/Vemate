import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphBehaviour{


  static   final ZoomPanBehavior? _zoomPanBehavior= ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
      //enableSelectionZooming: true,
      maximumZoomLevel: 0.6);


  late final TooltipBehavior _tooltipBehavior=TooltipBehavior(
    enable: true,
    // format: getData!.sixtyDayGraphModel!.floorPrice.toString(),
    header: "",
    tooltipPosition: TooltipPosition.auto,
    canShowMarker: false,
    color: const Color(0xff00A7FF),
  );


  late final TrackballBehavior _trackballBehavior= TrackballBehavior(
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


  late final CrosshairBehavior _crosshairBehavior =CrosshairBehavior(
    enable: true,
    lineColor: const Color(0xff00A7FF),
    lineDashArray: <double>[2, 2],
    lineWidth: 1,
    lineType: CrosshairLineType.vertical,
    activationMode: ActivationMode.singleTap,
  );

}