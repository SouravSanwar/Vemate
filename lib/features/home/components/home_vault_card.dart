import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph1Y.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph30D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph60D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph7D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultModel.dart';
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
  String? value = "24H";

  final items = ['24H', '7D', '30D', '60D', '1Y'];
  int homeSelectDropDownIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 6, bottom: 24, right: 10),
      child: Consumer<GetData>(builder: (context, data, child) {
        return Container(
            clipBehavior: Clip.antiAlias,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.graphCard,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: homeSelectDropDownIndex == 0
                ? Column(
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
                            child: Container(
                              height: Get.height * .03,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: AppColors.purpleGradient,
                                // set border width
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              ),
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
                          ),
                          const Expanded(
                            flex: 2,
                            child: Text(""),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              alignment: Alignment.center,
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
                                child: dropDown(),
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
                            child: Container(
                              height: Get.height * .03,
                              alignment: Alignment.center,
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
                                      ? data.homeVaultModel!.totalPercentChange!.toStringAsFixed(2) + "%"
                                      : data.homeVaultModel!.totalPercentChange!.toStringAsFixed(2) + "%",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: data.homeVaultModel!.sign! == 'decrease' ? Colors.red : Colors.green,
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
                        child: data.homeVaultModel!.homeVaultModelGraph != null
                            ? SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                margin: EdgeInsets.zero,
                                primaryXAxis: CategoryAxis(
                                  plotOffset: -8,
                                  axisLine: const AxisLine(width: 0),
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
                                  axisLine: const AxisLine(width: 0),
                                  isVisible: false,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  labelIntersectAction: AxisLabelIntersectAction.hide,
                                  labelRotation: 0,
                                  labelAlignment: LabelAlignment.start,
                                  maximumLabels: 10,
                                ),
                                series: <ChartSeries<HomeVaultModelGraph, String>>[
                                  SplineAreaSeries<HomeVaultModelGraph, String>(
                                    color: data.homeVaultModel!.sign! == 'decrease' ? Colors.red : Colors.green,
                                    gradient: AppColors.graphGradient,
                                    dataSource: data.homeVaultModel!.homeVaultModelGraph!,
                                    xValueMapper: (HomeVaultModelGraph plot, _) => plot.hour,
                                    yValueMapper: (HomeVaultModelGraph plot, _) => plot.total,
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
                  )
                : (homeSelectDropDownIndex == 1
                    ? Column(
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
                                child: Container(
                                  height: Get.height * .03,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.purpleGradient,
                                    // set border width
                                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                  ),
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
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text(""),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '\$${data.homeVaultModel7D!.totalPriceChange != null ? data.homeVaultModel7D!.totalPriceChange!.toStringAsFixed(2) : "0.0"}',
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
                                    child: dropDown(),
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
                                child: Container(
                                  height: Get.height * .03,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '\$${data.homeVaultModel7D!.totalVaultValue != null ? data.homeVaultModel7D!.totalVaultValue!.toStringAsFixed(2) : "0.0"}',
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.greyWhite,
                                        // fontFamily: 'Inter',
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
                                flex: 6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data.homeVaultModel7D!.sign! == 'decrease'
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
                                      data.homeVaultModel7D!.totalPercentChange! < 0.0
                                          ? data.homeVaultModel7D!.totalPercentChange!.toStringAsFixed(2) + "%"
                                          : data.homeVaultModel7D!.totalPercentChange!.toStringAsFixed(2) + "%",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: data.homeVaultModel7D!.sign! == 'decrease' ? Colors.red : Colors.green,
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
                            child: data.homeVaultModel7D!.homeVaultModelGraph7D != null
                                ? SfCartesianChart(
                                    plotAreaBorderWidth: 0,
                                    margin: EdgeInsets.zero,
                                    primaryXAxis: CategoryAxis(
                                      plotOffset: -8,
                                      axisLine: const AxisLine(width: 0),
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
                                      axisLine: const AxisLine(width: 0),
                                      isVisible: false,
                                      majorGridLines: const MajorGridLines(width: 0),
                                      labelIntersectAction: AxisLabelIntersectAction.hide,
                                      labelRotation: 0,
                                      labelAlignment: LabelAlignment.start,
                                      maximumLabels: 10,
                                    ),
                                    series: <ChartSeries<HomeVaultModelGraph7D, String>>[
                                      SplineAreaSeries<HomeVaultModelGraph7D, String>(
                                        color: data.homeVaultModel7D!.sign! == 'decrease' ? Colors.red : Colors.green,
                                        gradient: AppColors.graphGradient,
                                        dataSource: data.homeVaultModel7D!.homeVaultModelGraph7D!,
                                        xValueMapper: (HomeVaultModelGraph7D plot, _) => plot.hour,
                                        yValueMapper: (HomeVaultModelGraph7D plot, _) => plot.total,
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
                      )
                    : (homeSelectDropDownIndex == 2
                        ? Column(
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
                                    child: Container(
                                      height: Get.height * .03,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.purpleGradient,
                                        // set border width
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      ),
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
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: Text(""),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '\$${data.homeVaultModel30D!.totalPriceChange != null ? data.homeVaultModel30D!.totalPriceChange!.toStringAsFixed(2) : "0.0"}',
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
                                        child: dropDown(),
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
                                    child: Container(
                                      height: Get.height * .03,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '\$${data.homeVaultModel30D!.totalVaultValue != null ? data.homeVaultModel30D!.totalVaultValue!.toStringAsFixed(2) : "0.0"}',
                                        textAlign: TextAlign.start,
                                        style: Get.textTheme.bodyText2!.copyWith(
                                            color: AppColors.greyWhite,
                                            // fontFamily: 'Inter',
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
                                    flex: 6,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        data.homeVaultModel30D!.sign! == 'decrease'
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
                                          data.homeVaultModel30D!.totalPercentChange! < 0.0
                                              ? data.homeVaultModel30D!.totalPercentChange!.toStringAsFixed(2) + "%"
                                              : data.homeVaultModel30D!.totalPercentChange!.toStringAsFixed(2) + "%",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color:
                                                data.homeVaultModel30D!.sign! == 'decrease' ? Colors.red : Colors.green,
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
                                child: data.homeVaultModel30D!.homeVaultModelGraph30D != null
                                    ? SfCartesianChart(
                                        plotAreaBorderWidth: 0,
                                        margin: EdgeInsets.zero,
                                        primaryXAxis: CategoryAxis(
                                          plotOffset: -8,
                                          axisLine: const AxisLine(width: 0),
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
                                          axisLine: const AxisLine(width: 0),
                                          isVisible: false,
                                          majorGridLines: const MajorGridLines(width: 0),
                                          labelIntersectAction: AxisLabelIntersectAction.hide,
                                          labelRotation: 0,
                                          labelAlignment: LabelAlignment.start,
                                          maximumLabels: 10,
                                        ),
                                        series: <ChartSeries<HomeVaultModelGraph30D, String>>[
                                          SplineAreaSeries<HomeVaultModelGraph30D, String>(
                                            color:
                                                data.homeVaultModel30D!.sign! == 'decrease' ? Colors.red : Colors.green,
                                            gradient: AppColors.graphGradient,
                                            dataSource: data.homeVaultModel30D!.homeVaultModelGraph30D!,
                                            xValueMapper: (HomeVaultModelGraph30D plot, _) => plot.hour,
                                            yValueMapper: (HomeVaultModelGraph30D plot, _) => plot.total,
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
                          )
                        : (homeSelectDropDownIndex == 3
                            ? Column(
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
                                        child: Container(
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.purpleGradient,
                                            // set border width
                                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          ),
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
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Text(""),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '\$${data.homeVaultModel60D!.totalPriceChange != null ? data.homeVaultModel60D!.totalPriceChange!.toStringAsFixed(2) : "0.0"}',
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
                                            child: dropDown(),
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
                                        child: Container(
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '\$${data.homeVaultModel60D!.totalVaultValue != null ? data.homeVaultModel60D!.totalVaultValue!.toStringAsFixed(2) : "0.0"}',
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!.copyWith(
                                                color: AppColors.greyWhite,
                                                // fontFamily: 'Inter',
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
                                        flex: 6,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            data.homeVaultModel60D!.sign! == 'decrease'
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
                                              data.homeVaultModel60D!.totalPercentChange! < 0.0
                                                  ? data.homeVaultModel60D!.totalPercentChange!.toStringAsFixed(2) + "%"
                                                  : data.homeVaultModel60D!.totalPercentChange!.toStringAsFixed(2) +
                                                      "%",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: data.homeVaultModel60D!.sign! == 'decrease'
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
                                    child: data.homeVaultModel60D!.homeVaultModelGraph60D != null
                                        ? SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            margin: EdgeInsets.zero,
                                            primaryXAxis: CategoryAxis(
                                              plotOffset: -8,
                                              axisLine: const AxisLine(width: 0),
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
                                              axisLine: const AxisLine(width: 0),
                                              isVisible: false,
                                              majorGridLines: const MajorGridLines(width: 0),
                                              labelIntersectAction: AxisLabelIntersectAction.hide,
                                              labelRotation: 0,
                                              labelAlignment: LabelAlignment.start,
                                              maximumLabels: 10,
                                            ),
                                            series: <ChartSeries<HomeVaultModelGraph60D, String>>[
                                              SplineAreaSeries<HomeVaultModelGraph60D, String>(
                                                color: data.homeVaultModel60D!.sign! == 'decrease'
                                                    ? Colors.red
                                                    : Colors.green,
                                                gradient: AppColors.graphGradient,
                                                dataSource: data.homeVaultModel60D!.homeVaultModelGraph60D!,
                                                xValueMapper: (HomeVaultModelGraph60D plot, _) => plot.hour,
                                                yValueMapper: (HomeVaultModelGraph60D plot, _) => plot.total,
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
                              )
                            : Column(
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
                                        child: Container(
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.purpleGradient,
                                            // set border width
                                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          ),
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
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Text(""),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '\$${data.homeVaultModel1Y!.totalPriceChange != null ? data.homeVaultModel1Y!.totalPriceChange!.toStringAsFixed(2) : "0.0"}',
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
                                            child: dropDown(),
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
                                        child: Container(
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '\$${data.homeVaultModel1Y!.totalVaultValue != null ? data.homeVaultModel1Y!.totalVaultValue!.toStringAsFixed(2) : "0.0"}',
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!.copyWith(
                                                color: AppColors.greyWhite,
                                                // fontFamily: 'Inter',
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
                                        flex: 6,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            data.homeVaultModel1Y!.sign! == 'decrease'
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
                                              data.homeVaultModel1Y!.totalPercentChange! < 0.0
                                                  ? data.homeVaultModel1Y!.totalPercentChange!.toStringAsFixed(2) + "%"
                                                  : data.homeVaultModel1Y!.totalPercentChange!.toStringAsFixed(2) + "%",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: data.homeVaultModel1Y!.sign! == 'decrease'
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
                                    child: data.homeVaultModel1Y!.homeVaultModelGraph1Y != null
                                        ? SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            margin: EdgeInsets.zero,
                                            primaryXAxis: CategoryAxis(
                                              plotOffset: -8,
                                              axisLine: const AxisLine(width: 0),
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
                                              axisLine: const AxisLine(width: 0),
                                              isVisible: false,
                                              majorGridLines: const MajorGridLines(width: 0),
                                              labelIntersectAction: AxisLabelIntersectAction.hide,
                                              labelRotation: 0,
                                              labelAlignment: LabelAlignment.start,
                                              maximumLabels: 10,
                                            ),
                                            series: <ChartSeries<HomeVaultModelGraph1Y, String>>[
                                              SplineAreaSeries<HomeVaultModelGraph1Y, String>(
                                                color: data.homeVaultModel1Y!.sign! == 'decrease'
                                                    ? Colors.red
                                                    : Colors.green,
                                                gradient: AppColors.graphGradient,
                                                dataSource: data.homeVaultModel1Y!.homeVaultModelGraph1Y!,
                                                xValueMapper: (HomeVaultModelGraph1Y plot, _) => plot.hour,
                                                yValueMapper: (HomeVaultModelGraph1Y plot, _) => plot.total,
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
                              )))));
      }),
    );
  }

  Widget dropDown() {
    return DropdownButton<String>(
      value: value,
      items: items.map(buildMenuItem).toList(),
      onChanged: (value) {
        setState(() {
          this.value = value;

          value == '24H'
              ? homeSelectDropDownIndex = 0
              : value == '7D'
                  ? homeSelectDropDownIndex = 1
                  : value == '30D'
                      ? homeSelectDropDownIndex = 2
                      : value == '60D'
                          ? homeSelectDropDownIndex = 3
                          : homeSelectDropDownIndex = 4;

          // widget.isHome == true
          //     ? getData!.getHomeVault(graphType: homeSelectDropDownIndex)
          //     : getData!.getVaultStats(graphType: homeSelectDropDownIndex);
          printInfo(info: 'Value value: ' + value.toString());
        }); //get value when changed
      },
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 10,
      ),

      iconEnabledColor: Colors.white,
      //Icon color
      style: TextStyle(
          //te
          color: Colors.white,
          fontFamily: 'Inter', //Font color
          fontSize: 20.sp //font size on dropdown button
          ),
      dropdownColor: AppColors.backgroundColor,
      underline: Container(),
      //dropdown background color
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));
}
