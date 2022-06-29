import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/Provider/getData.dart';
import '../../market/presentation/collectible_details.dart';

class MywishlistCard extends StatefulWidget {

  const MywishlistCard({
    Key? key
  }) : super(key: key);

  @override
  State<MywishlistCard> createState() => _MywishlistCardState();
}

class _MywishlistCardState extends State<MywishlistCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.wishListModel!.results!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 8 : 4.0,
                right:
                    index == data.wishListModel!.results!.length - 1 ? 8 : 4.0,
                top: 4),
            child: Container(
              width: Get.width * .37,
              //height: Get.height * .22,
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  data.wishListModel!.results![index].productDetail!.type == 1
                      ? Get.to(() => ComicDetails(
                            productId: data.wishListModel!.results![index]
                                .productDetail!.id!,
                          ))
                      : Get.to(
                          () => CollectibleDetails(
                            productId: data.wishListModel!.results![index]
                                .productDetail!.id!,
                          ),
                        );
                },
                child: Container(
                  width: Get.width * .37,
                  decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff454F70))),
                  child: data.wishListModel!.results![index].productDetail!
                              .image! == null
                      ? Text(
                          data.wishListModel!.results![index].productDetail!
                              .name
                              .toString()[0]
                              .toUpperCase(),
                          style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontFamily: 'Inter',
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        )
                      : CachedNetworkImage(
                          imageUrl: data.wishListModel!.results![index]
                              .productDetail!.image!.image_on_list!.src
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.wishListModel!.results![index]
                                            .productDetail!.name
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
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
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 7,
                                          ),
                                          primaryYAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            labelIntersectAction:
                                                AxisLabelIntersectAction.hide,
                                            labelRotation: 0,
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 10,
                                          ),
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <ChartSeries<Graph, String>>[
                                            LineSeries<Graph, String>(
                                              color: data
                                                          .wishListModel!
                                                          .results![index]
                                                          .productDetail!
                                                          .priceChangePercent!
                                                          .sign ==
                                                      'decrease'
                                                  ? Colors.red
                                                  : Colors.green,
                                              dataSource: data
                                                  .wishListModel!
                                                  .results![index]
                                                  .productDetail!
                                                  .graph!,
                                              xValueMapper: (Graph plot, _) =>
                                                  plot.hour,
                                              yValueMapper: (Graph plot, _) =>
                                                  plot.total,
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
                                                  data
                                                      .wishListModel!
                                                      .results![index]
                                                      .productDetail!.floorPrice.toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color: AppColors.white,
                                                  fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  data
                                                              .wishListModel!
                                                              .results![index]
                                                              .productDetail!
                                                              .priceChangePercent!
                                                              .percent <
                                                          0.0
                                                      ? data
                                                          .wishListModel!
                                                          .results![index]
                                                          .productDetail!
                                                          .priceChangePercent!
                                                          .percent
                                                          .toString()
                                                      : "+" +
                                                          data
                                                              .wishListModel!
                                                              .results![index]
                                                              .productDetail!
                                                              .priceChangePercent!
                                                              .percent
                                                              .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: Get.textTheme.bodyText1!.copyWith(
                                                      color: data
                                                                  .wishListModel!
                                                                  .results![
                                                                      index]
                                                                  .productDetail!
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
                                                if (data
                                                        .wishListModel!
                                                        .results![index]
                                                        .productDetail!
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
                              )),
                        ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
