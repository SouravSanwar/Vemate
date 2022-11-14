//For Items of graphn page
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/features/vault/Wishlist/Separate_Vault_List/vault_collectibles_lists.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import 'package:intl/intl.dart';

/*
class VaultCollectiblesCard extends StatefulWidget {
  final Collectible? data;

  const VaultCollectiblesCard({Key? key, this.data}) : super(key: key);

  @override
  State<VaultCollectiblesCard> createState() => _VaultCollectiblesCardState();
}

class _VaultCollectiblesCardState extends State<VaultCollectiblesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        Get.to(
          () => const VaultCollectiblesLists(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 6, right: 10, top: Get.height * .0167, bottom: Get.height * .0334),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.graphCard,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Collectibles Value",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        '\$' + widget.data!.totalCollectibleValue!.toString(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            //fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      AppSpaces.spaces_height_30,
                      Text(
                        "",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      const Text(""),
                      AppSpaces.spaces_height_10,
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .07,
                        child: widget.data!.collectibleGraph == null
                            ? Container()
                            : SizedBox(
                                height: Get.height * .05,
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    isVisible: false,
                                    majorGridLines: const MajorGridLines(width: 0),
                                    labelIntersectAction: AxisLabelIntersectAction.hide,
                                    labelRotation: 270,
                                    labelAlignment: LabelAlignment.start,
                                    maximumLabels: 7,
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
                                  series: <ChartSeries<CollectibleGraph, String>>[
                                    LineSeries<CollectibleGraph, String>(
                                      color: widget.data!.sign! == 'decrease' ? Colors.red : Colors.green,
                                      dataSource: widget.data!.collectibleGraph!,
                                      xValueMapper: (CollectibleGraph plot, _) => plot.hour,
                                      yValueMapper: (CollectibleGraph plot, _) => plot.total,
                                      xAxisName: 'Duration',
                                      yAxisName: 'Total',
                                    )
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: Get.height * .038,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${widget.data!.changePrice != null ? widget.data!.changePrice.toStringAsFixed(2) : "0.0"}',
                            style: TextStyle(
                                color: Colors.white,
                                //fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: Get.width * .03,
                                ),
                                Text(
                                  widget.data!.changePercent != null
                                      ? widget.data!.changePercent.toStringAsFixed(2) + "%"
                                      : "0.0" "%",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: widget.data!.sign == 'decrease' ? Colors.red : Colors.green,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * .01,
                                ),
                                if (widget.data!.sign == 'decrease')
                                  const Icon(
                                    Icons.arrow_downward,
                                    color: Colors.red,
                                    size: 18,
                                  )
                                else
                                  const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
