import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class NewItemContainer extends StatefulWidget {
  final dynamic series;
  final String floorPrice;
  final String name;
  final double pcpPercent;
  final String pcpSign;

  const NewItemContainer(
      {Key? key,
      this.series,
      required this.name,
      required this.pcpPercent,
      required this.floorPrice,
      required this.pcpSign})
      : super(key: key);

  @override
  State<NewItemContainer> createState() => _NewItemContainerState();
}

class _NewItemContainerState extends State<NewItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.bottomCenter,
        height: Get.height * .15.h,
        width: Get.width * .87,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.40),
            Colors.white.withOpacity(0.10),
          ],
        ),
        borderGradient: AppColors.cardGradient,
        blur: 0,
        isFrostedGlass: true,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyText2!.copyWith(
                  color: AppColors.textColor,
                  //fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp),
            ),
            Divider(
              color: AppColors.white,
            ),
            SizedBox(
              width: Get.width,
              height: Get.height * .035,
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
                  series: widget.series),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    r"$" + widget.floorPrice,
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.textColor,
                        //fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.pcpSign == 'decrease'
                            ? "-" + widget.pcpPercent.toString()
                            : "+" + widget.pcpPercent.toString(),
                        textAlign: TextAlign.end,
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: widget.pcpSign==
                                'decrease'
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp),
                      ),
                      widget.pcpSign == 'decrease'
                          ? const Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                              size: 14,
                            )
                          : const Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                              size: 14,
                            )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
