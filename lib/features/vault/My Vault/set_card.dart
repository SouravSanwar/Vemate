import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:ketemaa/core/models/SetListModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SetCard extends StatefulWidget {
  final SetResults? list;

  const SetCard({Key? key, this.list}) : super(key: key);

  @override
  State<SetCard> createState() => _SetCardState();
}

class _SetCardState extends State<SetCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.list!.setProductDetail!.type == 0
              ? Get.to(
                  () => CollectibleDetails(
                    productId: widget.list!.setProductDetail!.id!,
                  ),
                )
              : Get.to(
                  () => ComicDetails(
                    productId: widget.list!.setProductDetail!.id!,
                  ),
                );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.list!.setProductDetail!.image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.list!.setProductDetail!.name
                          .toString()[0]
                          .toUpperCase(),
                      style: TextStyle(
                          color: AppColors.textColor,
                          //fontFamily: 'Inter',
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              widget.list!.setProductDetail!.name.toString(),
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
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ChartSeries<Graph, String>>[
                                  LineSeries<Graph, String>(
                                    color: widget.list!.setProductDetail!.graphData!
                                                .priceChangePercent!.sign ==
                                            'decrease'
                                        ? Colors.red
                                        : Colors.green,
                                    dataSource:
                                        widget.list!.setProductDetail!.graphData!.graph!,
                                    xValueMapper: (Graph plot, _) => plot.date,
                                    yValueMapper: (Graph plot, _) =>
                                        plot.floorPrice,
                                    xAxisName: 'Duration',
                                    yAxisName: 'Total',
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    r"$" +
                                        widget
                                            .list!.setProductDetail!.floorPrice
                                            .toString(),
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
                                        widget
                                                    .list!
                                                    .setProductDetail!.graphData!
                                                    .priceChangePercent!
                                                    .percent <
                                                0.0
                                            ? widget.list!.setProductDetail!.graphData!
                                                .priceChangePercent!.percent
                                                .toString()
                                            : "+" +
                                                widget.list!.setProductDetail!.graphData!
                                                    .priceChangePercent!.percent
                                                    .toString(),
                                        textAlign: TextAlign.end,
                                        style: Get.textTheme.bodyText1!
                                            .copyWith(
                                                color: widget
                                                            .list!
                                                            .setProductDetail!.graphData!
                                                            .priceChangePercent!
                                                            .percent <
                                                        0.0
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12.sp),
                                      ),
                                      if (widget.list!.setProductDetail!.graphData!
                                              .priceChangePercent!.percent <
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
                )
              : CachedNetworkImage(
                  imageUrl: widget
                      .list!.setProductDetail!.image!.low_res_url.toString(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.bottomCenter,
                        height: Get.height * .11,
                        width: Get.width ,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.25),
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
                                primaryYAxis: NumericAxis(
                                  numberFormat: NumberFormat.compact(),
                                  isVisible: false,
                                  majorGridLines:
                                  const MajorGridLines(width: 0),
                                  labelIntersectAction:
                                  AxisLabelIntersectAction.hide,
                                  labelRotation: 0,
                                  labelAlignment: LabelAlignment.start,
                                  maximumLabels: 10,
                                ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ChartSeries<Graph, String>>[
                                  LineSeries<Graph, String>(
                                    color: widget.list!.setProductDetail!.graphData!
                                        .priceChangePercent!.sign ==
                                        'decrease'
                                        ? Colors.red
                                        : Colors.green,
                                    dataSource:
                                    widget.list!.setProductDetail!.graphData!.graph!,
                                    xValueMapper: (Graph plot, _) => plot.date,
                                    yValueMapper: (Graph plot, _) =>
                                    plot.floorPrice,
                                    xAxisName: 'Duration',
                                    yAxisName: 'Total',
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.white,
                            ),
                            Text(
                              widget.list!.setProductDetail!.name.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodyText2!.copyWith(
                                //fontFamily: 'Inter',
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    r"$" +
                                        widget
                                            .list!.setProductDetail!.floorPrice
                                            .toString(),
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
                                        widget
                                                    .list!
                                                    .setProductDetail!.graphData!
                                                    .priceChangePercent!
                                                    .percent <
                                                0.0
                                            ? widget.list!.setProductDetail!.graphData!
                                                .priceChangePercent!.percent
                                                .toString()
                                            : "+" +
                                                widget.list!.setProductDetail!.graphData!
                                                    .priceChangePercent!.percent
                                                    .toString(),
                                        textAlign: TextAlign.end,
                                        style: Get.textTheme.bodyText1!
                                            .copyWith(
                                                color: widget
                                                            .list!
                                                            .setProductDetail!.graphData!
                                                            .priceChangePercent!
                                                            .percent <
                                                        0.0
                                                    ? Colors.red
                                                    : Colors.green,
                                                //fontFamily: 'Inter',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12.sp),
                                      ),
                                      if (widget.list!.setProductDetail!.graphData!
                                              .priceChangePercent!.percent <
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
  }
}
