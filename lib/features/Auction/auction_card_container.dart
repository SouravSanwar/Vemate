import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class AuctionCardContainer extends StatefulWidget {
  final String checkImage;
  final String? name ;
  final String lowResUrl;
  final String scrappedImage;
  final String edition;
  final String brand;
  final String brandName;
  final String rarity;
  final String floorPrice;
  final VoidCallback? onTap;
  final bool isAlert;
  final dynamic series;
  final dynamic changePrice;
  final double pcpPercent;
  final String pcpSign;
  bool? is_listed_on_veve_market;

  AuctionCardContainer(
      {Key? key,
        this.is_listed_on_veve_market,
        required this.checkImage,
        this.name="",
        required this.lowResUrl,
        required this.scrappedImage,
        required this.edition,
        required this.brand,
        required this.brandName,
        required this.rarity,
        required this.floorPrice,
        this.onTap,
        required this.isAlert,
        this.series,
        required this.changePrice,
        required this.pcpPercent,
        required this.pcpSign})
      : super(key: key);

  @override
  State<AuctionCardContainer> createState() => _AuctionCardContainerState();
}

class _AuctionCardContainerState extends State<AuctionCardContainer> {
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
          AppSpaces.spaces_width_5,
          Expanded(
            flex: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    widget.is_listed_on_veve_market==true?
                    Container() :
                    const Icon(
                        Icons.brightness_1,
                        size: 10,
                        color: Color(0xffEC3E3E)
                    ),
                    AppSpaces.spaces_width_2,
                    Expanded(
                        flex: 5,
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
                        )),
                    AppSpaces.spaces_width_2,

                  ],
                ),
                AppSpaces.spaces_height_5,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.brand != null
                        ? widget.brandName .toString()
                        : '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w200,
                        fontSize: 10.sp),
                  ),
                ),
                AppSpaces.spaces_height_5,
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  widget.rarity.toString(),
                                  textAlign: TextAlign.start,
                                  style: Get.textTheme.bodyText1!.copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10.sp),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.edition.toString(),
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
                                flex: 5,
                                child: Text(
                                  r"$" +
                                      widget.floorPrice.toString(),
                                  textAlign: TextAlign.start,
                                  style: Get.textTheme.bodyText1!.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11.sp),
                                ),
                              ),
                              AppSpaces.spaces_width_2,
                              Expanded(
                                flex: 5,
                                child:Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 1.0),
                                    child: Text(
                                      "Auction Price",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                        flex: 5,
                        child: Container(
                          height: Get.height * .04,
                          width: Get.height * .078,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xffD2C3EE))),
                          alignment: Alignment.center,
                          child: CountdownTimer(
                            textStyle: const TextStyle(
                              fontSize: 10,
                              color: Color(0xffD2C3EE),
                            ),
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                Duration(seconds: 300000).inMilliseconds,
                          ),
                        )
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
