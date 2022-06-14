import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductGraph extends StatefulWidget {
  final List<Graph>? graphList;
  final String? graphType;

  const ProductGraph({Key? key, this.graphList, this.graphType})
      : super(key: key);

  @override
  State<ProductGraph> createState() => _ProductGraphState();
}

class _ProductGraphState extends State<ProductGraph> {
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState(){


    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
      width: Get.width,
      decoration: BoxDecoration(
      gradient: AppColors.cardGradient,
      borderRadius: BorderRadius.circular(12.0),
      ),
      child:data.singleProductModel != null
          ? SfCartesianChart(

              plotAreaBorderWidth: 0,
              zoomPanBehavior: _zoomPanBehavior,
              primaryXAxis: CategoryAxis(
                axisBorderType: AxisBorderType.withoutTopAndBottom,
                majorGridLines: const MajorGridLines(width: 0,),
                majorTickLines: const MajorTickLines(width: 0),
                axisLine: AxisLine(width: 0),
                labelIntersectAction: AxisLabelIntersectAction.hide,
                labelRotation:0,
                labelStyle:  TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                    fontSize:8.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900
                ),
                labelAlignment: LabelAlignment.start,
                maximumLabels: 12,
              ),
              primaryYAxis: NumericAxis(

                axisBorderType: AxisBorderType.withoutTopAndBottom,
                borderWidth: 0,
                axisLine: AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0,),
                majorTickLines: const MajorTickLines(width: 0),
                labelIntersectAction: AxisLabelIntersectAction.hide,
                labelRotation: 0,
                labelStyle: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                    fontSize:10,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900
                ),
                labelAlignment: LabelAlignment.start,
                maximumLabels: 24,
              ),
              series: <ChartSeries<Graph, String>>[
                SplineAreaSeries<Graph, String>(
                  dataSource: data.singleProductModel!.graph!,
                  borderColor: Color(0xff2093D7),
                  borderWidth: 1,
                  gradient: AppColors.graphGradient,
                  xValueMapper: (plot, _) => widget.graphType == '0'
                      ? plot.hourWiseTime
                      : plot.dayWiseTime,

                  yValueMapper: (plot, _) => plot.floorPrice,
                  xAxisName: 'Duration',
                  yAxisName: 'Total',
                   enableTooltip: true,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                    angle: 270,
                  ),
                ),
              ],
            )
          : const LoadingExample()
              )
      );
    });
  }
}
