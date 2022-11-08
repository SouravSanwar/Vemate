import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class MySetsStructure extends StatefulWidget {
  final String checkImage;
  final String? name ;
  final String lowResUrl;
  final String scrappedImage;
  final String edition;
  final String rarity;
  final String floorPrice;
  final double pcpPercent;
  final String pcpSign;
  final Color color;

  const MySetsStructure(
      {Key? key,
        required this.checkImage,
        this.name="",
        required this.lowResUrl,
        required this.scrappedImage,
        required this.edition,
        required this.rarity,
        required this.floorPrice,
        required this.pcpPercent,
        required this.pcpSign,
        required this.color,
      })
      : super(key: key);

  @override
  State<MySetsStructure> createState() => _MySetsStructureState();
}

class _MySetsStructureState extends State<MySetsStructure> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*.296,
      width: Get.width*.45,
      margin: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: Get.height*.160,
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: widget.checkImage == null
                  ? FirstLetterImage(
                firstLetter: widget.name.toString()[0]
                    .toUpperCase(),
                fontsize: 35,
              )
                  : widget.lowResUrl == null
                  ? VeVeLowImage(
                imageUrl:widget.scrappedImage.toString(),
              )
                  : VeVeLowImage(
                imageUrl: widget.lowResUrl.toString(),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              child: Text(
                widget.name.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyText2!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
              )
          ),
          Container(
            height: 2,
              margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff282742),
                  widget.color,
                  Color(0xff282742),
                ],
              ),
            ),

          ),
          Container(
            height:20,
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.rarity.toString(),
                  textAlign: TextAlign.start,
                  style: Get.textTheme.bodyText1!.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w200,
                      fontSize: 10.sp),
                ),
                Text(
                  widget.edition.toString(),
                  textAlign: TextAlign.start,
                  style: Get.textTheme.bodyText1!.copyWith(
                      color: AppColors.textColor,
                      //fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp),
                ),

              ],
            ),
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
               /* Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                          fontSize: 10),
                    ),
                    if (widget.pcpSign ==
                        'decrease')
                      const Expanded(
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: 10,
                        ),
                      )
                    else
                      const Expanded(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                          size: 10,
                        ),
                      )
                  ],
                ),*/

              ],
            ),
          ),

        ],
      ),
    );
  }
}
