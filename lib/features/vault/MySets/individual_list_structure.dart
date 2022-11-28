import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class IndividualListStructure extends StatefulWidget {
  final String checkImage;
  final String? name;

  final String lowResUrl;
  final String scrappedImage;
  final String edition;
  final String brand;
  final String rarity;
  final String floorPrice;
  final dynamic series;
  final double changePrice;
  final double pcpPercent;
  final String pcpSign;
  String ap;

  IndividualListStructure({
    Key? key,
    required this.checkImage,
    this.name = "",
    required this.lowResUrl,
    required this.scrappedImage,
    required this.edition,
    required this.brand,
    required this.rarity,
    required this.floorPrice,
    this.series,
    required this.changePrice,
    required this.pcpPercent,
    required this.pcpSign,
    required this.ap,
  }) : super(key: key);

  @override
  State<IndividualListStructure> createState() => _IndividualListStructureState();
}

class _IndividualListStructureState extends State<IndividualListStructure> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: Get.height * .09,
            width: Get.height * .078,
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.textBoxBgColor)),
            alignment: Alignment.center,
            child: widget.checkImage == ''
                ? FirstLetterImage(
                    firstLetter: widget.name.toString()[0].toUpperCase(),
                    fontsize: 35,
                  )
                : widget.lowResUrl == ''
                    ? VeVeLowImage(
                        imageUrl: widget.scrappedImage.toString(),
                      )
                    : VeVeLowImage(
                        imageUrl: widget.lowResUrl.toString(),
                      ),
          ),
          AppSpaces.spaces_width_5,
          Expanded(
            flex: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: SizedBox(
                          child: Text(
                            widget.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText2!
                                .copyWith(color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 12.sp),
                          ),
                        )),
                    AppSpaces.spaces_width_2,
                  ],
                ),
                AppSpaces.spaces_height_5,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.brand != '' ? widget.brand.toString() : '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.grey, fontWeight: FontWeight.w200, fontSize: 10.sp),
                          ),
                          AppSpaces.spaces_height_5,
                          Text(
                            widget.rarity.toString(),
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.grey, fontWeight: FontWeight.w200, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    AppSpaces.spaces_width_2,
                    Expanded(
                      flex: 4,
                      child: Text(
                        "#"+widget.edition.toString(),
                        textAlign: TextAlign.start,
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: AppColors.textColor,
                            //fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp),
                      ),
                    ),
                  ],
                ),
                AppSpaces.spaces_height_5,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(
                            r"$" + widget.floorPrice.toString(),
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.textColor, fontWeight: FontWeight.w900, fontSize: 10.sp),
                          ),
                          AppSpaces.spaces_width_2,
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                              child: Text(
                                "FP",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpaces.spaces_width_2,
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(
                            r"$" + widget.ap.toString(),
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.textColor, fontWeight: FontWeight.w900, fontSize: 10.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSpaces.spaces_width_2,
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                              child: Text(
                                "AP",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpaces.spaces_width_2,
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                SizedBox(
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
                      series: widget.series),
                ),
                AppSpaces.spaces_height_10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.pcpPercent.toStringAsFixed(1) + "%",
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodyText1!.copyWith(
                                color: widget.pcpSign == 'decrease' ? Colors.red : Colors.green,
                                fontWeight: FontWeight.w300,
                                fontSize: 10),
                          ),
                          if (widget.pcpSign == 'decrease')
                            const Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                              size: 10,
                            )
                          else
                            const Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                              size: 10,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text((widget.pcpSign == 'decrease' ?"-":"")+
                            '\$${widget.changePrice != null ? widget.changePrice.toStringAsFixed(1) : ""}',
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 10),
                          ),
                          AppSpaces.spaces_width_2,
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                              child: Text(
                                "PC",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
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
    );
  }
}
