import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';
import '../../core/Provider/getData.dart';
import '../../core/models/SetListModel.dart';
import '../market/presentation/collectible_details.dart';

class MysetsCard extends StatefulWidget {
  const MysetsCard({
    Key? key,
  }) : super(key: key);

  @override
  State<MysetsCard> createState() => _MysetsCardState();
}

class _MysetsCardState extends State<MysetsCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(
      builder: (context, data, child) {
        return data.setListModel != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: data.setListModel!.setResults!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 6 : 6.0,
                      right: index == data.setListModel!.setResults!.length - 1 ? 6 : 6.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        data.setListModel!.setResults![index].setProductDetail!.type == 1
                            ? Get.to(() => ComicDetails(
                                  productId: data.setListModel!.setResults![index].setProductDetail!.id!,
                                ))
                            : Get.to(() => CollectibleDetails(
                                  productId: data.setListModel!.setResults![index].setProductDetail!.id!,
                                  productType: data.setListModel!.setResults![index].setProductDetail!.type!,
                                  fromVault: true,
                                ));
                      },
                      child: Container(
                        width: Get.width * .37,
                        decoration: BoxDecoration(
                          gradient: AppColors.cardGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: data.setListModel!.setResults![index].setProductDetail!.image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.setListModel!.setResults![index].setProductDetail!.name
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        //fontFamily: 'Inter',
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  NewItemContainer(
                                    name: data.setListModel!.setResults![index].setProductDetail!.name.toString(),
                                    series: <ChartSeries<Graph, String>>[
                                      LineSeries<Graph, String>(
                                        color: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                                    .priceChangePercent!.sign ==
                                                'decrease'
                                            ? Colors.red
                                            : Colors.green,
                                        dataSource:
                                            data.setListModel!.setResults![index].setProductDetail!.graphData!.graph!,
                                        xValueMapper: (Graph plot, _) => plot.date,
                                        yValueMapper: (Graph plot, _) => plot.floorPrice,
                                        xAxisName: 'Duration',
                                        yAxisName: 'Total',
                                      )
                                    ],
                                    floorPrice:
                                        data.setListModel!.setResults![index].setProductDetail!.floorPrice.toString(),
                                    pcpPercent: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                        .priceChangePercent!.percent,
                                    pcpSign: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                        .priceChangePercent!.sign
                                        .toString(),
                                  )
                                ],
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    data.setListModel!.setResults![index].setProductDetail!.image!.low_res_url == null
                                        ? data.setListModel!.setResults![index].setProductDetail!.image!.image_on_list
                                            .toString()
                                        : data.setListModel!.setResults![index].setProductDetail!.image!.low_res_url
                                            .toString(),
                                imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: NewItemContainer(
                                      name: data.setListModel!.setResults![index].setProductDetail!.name.toString(),
                                      series: <ChartSeries<Graph, String>>[
                                        LineSeries<Graph, String>(
                                          color: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                                      .priceChangePercent!.sign ==
                                                  'decrease'
                                              ? Colors.red
                                              : Colors.green,
                                          dataSource:
                                              data.setListModel!.setResults![index].setProductDetail!.graphData!.graph!,
                                          xValueMapper: (Graph plot, _) => plot.date,
                                          yValueMapper: (Graph plot, _) => plot.floorPrice,
                                          xAxisName: 'Duration',
                                          yAxisName: 'Total',
                                        )
                                      ],
                                      floorPrice:
                                          data.setListModel!.setResults![index].setProductDetail!.floorPrice.toString(),
                                      pcpPercent: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                          .priceChangePercent!.percent,
                                      pcpSign: data.setListModel!.setResults![index].setProductDetail!.graphData!
                                          .priceChangePercent!.sign
                                          .toString(),
                                    )),
                              ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }
}
