import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel30D.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VaultCard30D extends StatefulWidget {
  const VaultCard30D({Key? key}) : super(key: key);

  @override
  State<VaultCard30D> createState() => _VaultCard30DState();
}

class _VaultCard30DState extends State<VaultCard30D> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return data.vaultStatsModel30D != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: Get.height * .03,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      // set border width
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0),
                                      ), // set rounded corner radius
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
                                  child: Text(""
                                      /*"MCP",
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontSize: 14),*/
                                      ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    height: Get.height * .03,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${data.vaultStatsModel30D!.totalPriceChange != null ? data.vaultStatsModel30D!.totalPriceChange!.toStringAsFixed(2) : ""}',
                                      textAlign: TextAlign.start,
                                      style: Get.textTheme.bodyText2!.copyWith(
                                          color: AppColors.white,
                                          //fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * .005,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: Get.height * .03,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$' + data.vaultStatsModel30D!.totalVaultValue!.toStringAsFixed(2),
                                      textAlign: TextAlign.start,
                                      style: Get.textTheme.bodyText2!.copyWith(
                                          color: AppColors.textColor,
                                          //fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: Text(""
                                      /* '\$' +
                                                data.vaultStatsModel30D!.mcp!
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!
                                                .copyWith(
                                                    color: AppColors.grey,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontSize: 14),*/
                                      ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      data.vaultStatsModel30D!.sign! == 'decrease'
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
                                        data.vaultStatsModel30D!.totalPercentChange! < 0.0
                                            ? data.vaultStatsModel30D!.totalPercentChange!.toStringAsFixed(2)
                                            : data.vaultStatsModel30D!.totalPercentChange!.toStringAsFixed(2) + "%",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: data.vaultStatsModel30D!.sign! == 'decrease'
                                                ? Colors.red
                                                : Colors.green,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .11,
                  child: data.vaultStatsModel30D!.vaultStatsModelGraph30D != null
                      ? SfCartesianChart(
                          margin: EdgeInsets.zero,
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                            plotOffset: -8,
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
                            isVisible: false,
                            majorGridLines: const MajorGridLines(width: 0),
                            labelIntersectAction: AxisLabelIntersectAction.hide,
                            labelRotation: 0,
                            labelAlignment: LabelAlignment.start,
                            maximumLabels: 10,
                          ),
                          series: <ChartSeries<VaultStatsModelGraph30D, String>>[
                            SplineAreaSeries<VaultStatsModelGraph30D, String>(
                              color: data.vaultStatsModel30D!.sign! == 'decrease' ? Colors.red : Colors.green,
                              gradient: AppColors.graphGradient,
                              dataSource: data.vaultStatsModel30D!.vaultStatsModelGraph30D!,
                              xValueMapper: (VaultStatsModelGraph30D plot, _) => plot.hour,
                              yValueMapper: (VaultStatsModelGraph30D plot, _) => plot.total,
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
          : Container();
    });
  }
}
