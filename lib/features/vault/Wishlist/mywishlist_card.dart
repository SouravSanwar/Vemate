import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/Provider/getData.dart';
import '../../market/presentation/collectible_details.dart';

class MywishlistCard extends StatefulWidget {
  final List<Results>? list;

  const MywishlistCard({
    Key? key,
    this.list,
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
    return Consumer<GetData>(builder: (context, data, child)
    {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:data.wishListModel!
            .results!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 8 : 4.0, right: index == data.wishListModel!.results!.length-1 ? 8 : 4.0,top:4),
            child: Container(
              width: Get.width * .37,
              //height: Get.height * .22,
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  data.wishListModel!
                      .results![index].productDetail!.type == 1
                      ? Get.to(() =>
                      ComicDetails(
                        productId: data.wishListModel!
                            .results![index].productDetail!.id!,
                      ))
                      : Get.to(() =>CollectibleDetails(

                    productId: data.wishListModel!
                        .results![index].productDetail!.id!,
                  ),);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: Get.width * .37,
                      //height: Get.height * .22,
                      decoration: BoxDecoration(
                          gradient: AppColors.cardGradient,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:AppColors.borderColor)),
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * .1,
                            width: Get.width * .3,
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
                                  color: data.wishListModel!
                                      .results![
                                  index]
                                      .productDetail!.priceChangePercent!.sign ==
                                      'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: data.wishListModel!
                                      .results![index].productDetail!.graph!,
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
                          const Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            data.wishListModel!
                                .results![index].productDetail!.name
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Get.textTheme.bodyText2!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    r"$" +
                                        data.wishListModel!
                                            .results![index].productDetail!
                                            .floorPrice
                                            .toString(),
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.sp),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data.wishListModel!
                                            .results![index].productDetail!
                                            .priceChangePercent!.percent!
                                            .toString() + "%",
                                        textAlign: TextAlign.end,
                                        style: Get.textTheme.bodyText1!
                                            .copyWith(
                                            color: data.wishListModel!
                                                .results![index]
                                                .productDetail!
                                                .priceChangePercent!
                                                .sign ==
                                                'decrease'
                                                ? Colors.red
                                                : Colors.green,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10.sp),
                                      ),
                                      if (data.wishListModel!
                                          .results![index].productDetail!
                                          .priceChangePercent!.sign ==
                                          'decrease')
                                        const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                          size: 12,
                                        )
                                      else
                                        const Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
                                          size: 12,
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    );
  }

}
