import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class SeparateVaultStructure extends StatefulWidget {
  final String checkImage;
  final String? name;

  final String lowResUrl;
  final String scrappedImage;
  final String edition;
  final String brand;
  final String rarity;
  final String floorPrice;
  final dynamic series;
  final dynamic changePrice;
  final double pcpPercent;
  final String pcpSign;

  const SeparateVaultStructure(
      {Key? key,
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
      required this.pcpSign})
      : super(key: key);

  @override
  State<SeparateVaultStructure> createState() => _SeparateVaultStructureState();
}

class _SeparateVaultStructureState extends State<SeparateVaultStructure> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(Get.width *0.007),
            width: Get.width * .22,
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.textBoxBgColor)),
            alignment: Alignment.center,
            child: widget.checkImage == null
                ? FirstLetterImage(
                    firstLetter: widget.name.toString()[0].toUpperCase(),
                    fontsize: 35,
                  )
                : widget.lowResUrl == null
                    ? VeVeLowImage(
                        imageUrl: widget.scrappedImage.toString(),
                      )
                    : VeVeLowImage(
                        imageUrl: widget.lowResUrl.toString(),
                      )),
        Container(
          width: Get.width * .7,
          margin: const EdgeInsets.only(left: 2,right: 2,top: 4,bottom: 4),
          decoration: BoxDecoration(
            // color: Colors.white,
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                        child: Text(
                          widget.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: Get.textTheme.bodyText2!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      )
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                  child:Text(
                                    widget.brand != ""
                                        ? widget.brand.toString()
                                        : '',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 10.sp),
                                  ),
                              ),
                              Expanded(
                                flex: 5,
                                child:Text(
                                  widget.brand != ""
                                      ? widget.rarity .toString()
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: Get.textTheme.bodyText1!.copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10.sp),
                                ),
                              ),
                            ],
                          )
                      ),
                      Expanded(
                          flex: 5,
                          child: SizedBox(
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
                                series: widget.series
                            ),
                          ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Row(

                            children: [
                              Text(
                                r"$" +
                                    widget.floorPrice.toString(),
                                textAlign: TextAlign.start,
                                style: Get.textTheme.bodyText1!.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11.sp),
                              ),
                              AppSpaces.spaces_width_5,
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                                  child: Text(
                                    "FP",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.pcpPercent.toStringAsFixed(2) +
                                  "%",
                              textAlign: TextAlign.end,
                              style: Get.textTheme.bodyText1!.copyWith(
                                  color: widget.pcpSign ==
                                      'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11),
                            ),
                            if (widget.pcpSign ==
                                'decrease')
                              Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                                size: 11,
                              )
                            else
                              Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 11,
                              ),
                          ],
                        ),

                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              r"$" +
                                  widget.changePrice.toString(),
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodyText1!.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11.sp),
                            ),
                            AppSpaces.spaces_width_5,
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                                child: Text(
                                  "PC",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
