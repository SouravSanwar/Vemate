import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/models/CollectiblesModel.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class VaultNewItemCard extends StatefulWidget {
  final List<Results>? list;

  const VaultNewItemCard({
    Key? key,
    this.list,
  }) : super(key: key);

  @override
  State<VaultNewItemCard> createState() => _VaultNewItemCardState();
}

class _VaultNewItemCardState extends State<VaultNewItemCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 6 : 6.0, right: index == 9 ? 8 : 6.0),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => CollectibleDetails(
                    productId: widget.list![index].id,
                  ),
                );
              },
              child: Container(
                width: Get.width * .37,
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.list![index].image == null
                    ? Container(
                      child: Column(
                        children: [
                          Text(
                              widget.list![index].name.toString()[0].toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontFamily: 'Inter',
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),

                            ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: GlassContainer(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.bottomCenter,
                              height: Get.height * .11.h,
                              width: Get.width * .37,
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
                                    widget.list![index].name.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.textColor,
                                        fontFamily: 'Inter',
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
                                        majorGridLines:
                                        const MajorGridLines(width: 0),
                                        labelIntersectAction:
                                        AxisLabelIntersectAction.hide,
                                        labelRotation: 270,
                                        labelAlignment: LabelAlignment.start,
                                        maximumLabels: 7,
                                      ),
                                      primaryYAxis: CategoryAxis(
                                        isVisible: false,
                                        majorGridLines:
                                        const MajorGridLines(width: 0),
                                        labelIntersectAction:
                                        AxisLabelIntersectAction.hide,
                                        labelRotation: 0,
                                        labelAlignment: LabelAlignment.start,
                                        maximumLabels: 10,
                                      ),
                                      tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                      series: <ChartSeries<Graph, String>>[
                                        LineSeries<Graph, String>(
                                          color: widget
                                              .list![index]
                                              .priceChangePercent!
                                              .sign ==
                                              'decrease'
                                              ? Colors.red
                                              : Colors.green,
                                          dataSource:
                                          widget.list![index].graph!,
                                          xValueMapper: (Graph plot, _) =>
                                          plot.date,
                                          yValueMapper: (Graph plot, _) =>
                                          plot.floorPrice,
                                          xAxisName: 'Duration',
                                          yAxisName: 'Total',
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          r"$" +
                                              widget.list![index].floorPrice.toString(),
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                              color: AppColors.textColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              widget
                                                  .list![index]
                                                  .priceChangePercent!
                                                  .percent <
                                                  0.0
                                                  ? widget
                                                  .list![index]
                                                  .priceChangePercent!
                                                  .percent
                                                  .toString()
                                                  : "+" +
                                                  widget
                                                      .list![index]
                                                      .priceChangePercent!
                                                      .percent
                                                      .toString(),
                                              textAlign: TextAlign.end,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                  color: widget
                                                      .list![index]
                                                      .priceChangePercent!
                                                      .percent <
                                                      0.0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  fontSize: 12.sp),
                                            ),
                                            if (widget
                                                .list![index]
                                                .priceChangePercent!
                                                .percent <
                                                0.0)
                                              const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.red,
                                                size: 14,
                                              )
                                            else
                                              const Icon(
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
                          ),
                        ],
                      ),
                    )
                    : CachedNetworkImage(
                        imageUrl: widget.list![index].image!.image_on_list!.src
                            .toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: GlassContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.bottomCenter,
                              height: Get.height * .11.h,
                              width: Get.width * .37,
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
                                    widget.list![index].name.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        fontFamily: 'Inter',
                                        color: AppColors.textColor,
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
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                        labelIntersectAction:
                                            AxisLabelIntersectAction.hide,
                                        labelRotation: 270,
                                        labelAlignment: LabelAlignment.start,
                                        maximumLabels: 7,
                                      ),
                                      primaryYAxis: CategoryAxis(
                                        isVisible: false,
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                        labelIntersectAction:
                                            AxisLabelIntersectAction.hide,
                                        labelRotation: 0,
                                        labelAlignment: LabelAlignment.start,
                                        maximumLabels: 10,
                                      ),
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      series: <ChartSeries<Graph, String>>[
                                        LineSeries<Graph, String>(
                                          color: widget
                                                      .list![index]
                                                      .priceChangePercent!
                                                      .sign ==
                                                  'decrease'
                                              ? Colors.red
                                              : Colors.green,
                                          dataSource:
                                              widget.list![index].graph!,
                                          xValueMapper: (Graph plot, _) =>
                                              plot.date,
                                          yValueMapper: (Graph plot, _) =>
                                              plot.floorPrice,
                                          xAxisName: 'Duration',
                                          yAxisName: 'Total',
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          r"$" +
                                              widget.list![index].floorPrice.toString(),
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.textColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              widget
                                                          .list![index]
                                                          .priceChangePercent!
                                                          .percent <
                                                      0.0
                                                  ? widget
                                                      .list![index]
                                                      .priceChangePercent!
                                                      .percent
                                                      .toString()
                                                  : "+" +
                                                      widget
                                                          .list![index]
                                                          .priceChangePercent!
                                                          .percent
                                                          .toString(),
                                              textAlign: TextAlign.end,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: widget
                                                                  .list![index]
                                                                  .priceChangePercent!
                                                                  .percent <
                                                              0.0
                                                          ? Colors.red
                                                          : Colors.green,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12.sp),
                                            ),
                                            if (widget
                                                    .list![index]
                                                    .priceChangePercent!
                                                    .percent <
                                                0.0)
                                              const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.red,
                                                size: 14,
                                              )
                                            else
                                              const Icon(
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
                          ),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
