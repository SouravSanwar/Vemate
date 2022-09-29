import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/Provider/getData.dart';
import '../../market/presentation/collectible_details.dart';

class MywishlistCard extends StatefulWidget {
  const MywishlistCard({Key? key}) : super(key: key);

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
              left: index == 0 ? 6 : 6.0,
              right: index == data.wishListModel!.results!.length - 1 ? 6 : 6.0,
            ),
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
                            productId: data.wishListModel!.results![index].productDetail!.id!,
                          ))
                      : Get.to(
                          () => CollectibleDetails(
                            productId: data.wishListModel!.results![index].productDetail!.id!,
                          ),
                        );
                },
                child: Container(
                  width: Get.width * .37,
                  decoration: BoxDecoration(
                    gradient: AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: data.wishListModel!.results![index].productDetail!.image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.wishListModel!.results![index].productDetail!.name.toString()[0].toUpperCase(),
                              style: TextStyle(
                                color: AppColors.backgroundColor,
                                //fontFamily: 'Inter',
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            NewItemContainer(
                              name: data.wishListModel!.results![index].productDetail!.name.toString(),
                              series: <ChartSeries<Graph, String>>[
                                LineSeries<Graph, String>(
                                  color: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!
                                      .sign ==
                                      'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: data.wishListModel!.results![index].productDetail!.graphData!.graph!,
                                  xValueMapper: (Graph plot, _) => plot.date,
                                  yValueMapper: (Graph plot, _) =>
                                  plot.floorPrice,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                )
                              ],
                              floorPrice:
                              data.wishListModel!.results![index].productDetail!.floorPrice.toString(),
                              pcpPercent:
                              data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.percent,
                              pcpSign: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign
                                  .toString(),
                            )
                          ],
                  )
                      : CachedNetworkImage(
                    imageUrl: data.wishListModel!.results![index].productDetail!.image!.low_res_url == null
                        ? data.wishListModel!.results![index].productDetail!.image!.image_on_list
                        .toString()
                        : data.wishListModel!.results![index].productDetail!.image!.low_res_url.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: NewItemContainer(
                          name: data.wishListModel!.results![index].productDetail!.name.toString(),
                          series: <ChartSeries<Graph, String>>[
                            LineSeries<Graph, String>(
                              color: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!
                                  .sign ==
                                  'decrease'
                                  ? Colors.red
                                  : Colors.green,
                              dataSource: data.wishListModel!.results![index].productDetail!.graphData!.graph!,
                              xValueMapper: (Graph plot, _) => plot.date,
                              yValueMapper: (Graph plot, _) =>
                              plot.floorPrice,
                              xAxisName: 'Duration',
                              yAxisName: 'Total',
                            )
                          ],
                          floorPrice:
                          data.wishListModel!.results![index].productDetail!.floorPrice.toString(),
                          pcpPercent: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.percent,
                          pcpSign: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign
                              .toString(),
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
