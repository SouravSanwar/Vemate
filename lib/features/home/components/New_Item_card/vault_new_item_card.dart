import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/CollectiblesModel.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/utilities/app_colors/app_colors.dart';

class VaultNewItemCard extends StatefulWidget {
  final List<Results>? list;

  const
  VaultNewItemCard({
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
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.list![index].name
                                .toString()[0]
                                .toUpperCase(),
                            style: TextStyle(
                                color: AppColors.textColor,
                                //fontFamily: 'Inter',
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          NewItemContainer(
                            name: widget.list![index].name.toString(),
                            series: <ChartSeries<Graph, String>>[
                              LineSeries<Graph, String>(
                                color: widget.list![index].graphData!.priceChangePercent!
                                            .sign ==
                                        'decrease'
                                    ? Colors.red
                                    : Colors.green,
                                dataSource: widget.list![index].graphData!.graph!,
                                xValueMapper: (Graph plot, _) => plot.date,
                                yValueMapper: (Graph plot, _) =>
                                    plot.floorPrice,
                                xAxisName: 'Duration',
                                yAxisName: 'Total',
                              )
                            ],
                            floorPrice:
                                widget.list![index].floorPrice.toString(),
                            pcpPercent:
                                widget.list![index].graphData!.priceChangePercent!.percent,
                            pcpSign: widget
                                .list![index].graphData!.priceChangePercent!.sign
                                .toString(),
                          )
                        ],
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.list![index].image!.low_res_url == null
                            ? widget.list![index].image!.image_on_list
                                .toString()
                            : widget.list![index].image!.low_res_url.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: NewItemContainer(
                              name: widget.list![index].name.toString(),
                              series: <ChartSeries<Graph, String>>[
                                LineSeries<Graph, String>(
                                  color: widget.list![index].graphData!.priceChangePercent!
                                              .sign ==
                                          'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: widget.list![index].graphData!.graph!,
                                  xValueMapper: (Graph plot, _) => plot.date,
                                  yValueMapper: (Graph plot, _) =>
                                      plot.floorPrice,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                )
                              ],
                              floorPrice:
                                  widget.list![index].floorPrice.toString(),
                              pcpPercent: widget
                                  .list![index].graphData!.priceChangePercent!.percent,
                              pcpSign: widget
                                  .list![index].graphData!.priceChangePercent!.sign
                                  .toString(),
                            )),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
