import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/HomeVaultModel.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
import 'package:ketemaa/features/vault/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';
import 'package:intl/intl.dart';

class HomeVaultCard extends StatefulWidget {


  const HomeVaultCard({Key? key}) : super(key: key);

  @override
  State<HomeVaultCard> createState() => _HomeVaultCardState();
}

class _HomeVaultCardState extends State<HomeVaultCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12,left: 6,bottom: 24,right: 10),
      child: Consumer<GetData>(builder: (context, data, child) {
        return Container(
            clipBehavior: Clip.antiAlias,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.graphCard,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Vault Value",
                        textAlign: TextAlign.start,
                        style: Get.textTheme.bodyText2!.copyWith(
                            color: AppColors.textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        height: Get.height * .03,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: AppColors.purpleGradient,
                          // set border width
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Text(
                          '\$${data.homeVaultModel!.totalPriceChange != null ? data.homeVaultModel!.totalPriceChange!.toStringAsFixed(2) : "0.0"}',
                          textAlign: TextAlign.start,
                          style: Get.textTheme.bodyText2!.copyWith(
                              color: AppColors.white,
                              //fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: DropDown(AppColors.backgroundColor,true),
                          width: Get.width * .15,
                          height: Get.height * .03,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        '\$${data.homeVaultModel!.totalVaultValue != null ? data.homeVaultModel!.totalVaultValue!.toStringAsFixed(2) : "0.0"}',
                        textAlign: TextAlign.start,
                        style: Get.textTheme.bodyText2!.copyWith(
                            color: AppColors.greyWhite,
                           // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          data.homeVaultModel!.sign! == 'decrease'
                              ? const RotationTransition(
                                  turns: AlwaysStoppedAnimation(45 / 360),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                )
                              : const RotationTransition(
                                  turns: AlwaysStoppedAnimation(45 / 360),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                ),
                          Text(
                            data.homeVaultModel!.totalPercentChange! < 0.0
                                ? data.homeVaultModel!.totalPercentChange!
                                        .toStringAsFixed(2) +
                                    "%"
                                : data.homeVaultModel!.totalPercentChange!
                                        .toStringAsFixed(2) +
                                    "%",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: data.homeVaultModel!.sign! == 'decrease'
                                  ? Colors.red
                                  : Colors.green,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(""),
                    ),
                    const Expanded(
                      flex: 4,
                      child: Text(""),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .12,
                  child:  data.homeVaultModel!.homeVaultModelGraph != null
                      ? SfCartesianChart(

                    plotAreaBorderWidth: 0,
                    margin: EdgeInsets.zero,
                    primaryXAxis: CategoryAxis(
                      plotOffset: -8,
                      axisLine: AxisLine(width: 0),
                      isVisible: false,
                      majorGridLines: const MajorGridLines(width: 0),
                      labelIntersectAction: AxisLabelIntersectAction.hide,
                      labelRotation: 270,
                      labelAlignment: LabelAlignment.start,
                      maximumLabels: 7,
                      labelPlacement: LabelPlacement.onTicks,
                    ),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      axisLine: AxisLine(width: 0),
                      isVisible: false,
                      majorGridLines: const MajorGridLines(width: 0),
                      labelIntersectAction: AxisLabelIntersectAction.hide,
                      labelRotation: 0,
                      labelAlignment: LabelAlignment.start,
                      maximumLabels: 10,

                    ),
                    series: <ChartSeries<HomeVaultModelGraph, String>>[
                      SplineAreaSeries<HomeVaultModelGraph, String>(
                        color: data.homeVaultModel!.sign! == 'decrease'
                            ? Colors.red
                            : Colors.green,
                        gradient: AppColors.graphGradient,
                        dataSource: data.homeVaultModel!.homeVaultModelGraph!,
                        xValueMapper: (HomeVaultModelGraph plot, _) =>
                            plot.hour,
                        yValueMapper: (HomeVaultModelGraph plot, _) =>
                            plot.total,
                        xAxisName: 'Duration',
                        yAxisName: 'Total',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: false,
                          angle: 270,
                        ),
                        splineType: SplineType.monotonic,
                        cardinalSplineTension: 0.3,
                      )
                    ],
                  )
                      : Container(),
                ),
              ],
            ));
      }),
    );
  }
}
