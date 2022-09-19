import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/Provider/getData.dart';

import '../../../core/models/ComicsModel.dart';

class ComicsItemCard extends StatefulWidget {
  final String? keyword;
  final String? rarity;
  final String? mintNumber;

  const ComicsItemCard({Key? key, this.keyword, this.rarity, this.mintNumber})
      : super(key: key);

  @override
  State<ComicsItemCard> createState() => _ComicsItemCardState();
}

class _ComicsItemCardState extends State<ComicsItemCard> {
  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refreshKey = GlobalKey();

  GetData? getData;

  @override
  void initState() {
    super.initState();
    getData = Provider.of<GetData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return SizedBox(
          height: Get.height * .8,
          child: data.comicsModel != null
              ? SmartRefresher(
                  key: _refreshKey,
                  controller: refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(
                    color: AppColors.graphCard,
                  ),
                  footer: const ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                  ),
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: data.comicsModel!.results!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.comicsModel!.results!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 4, right: 4),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.graphCard,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ComicDetails(
                                        productId: data
                                            .comicsModel!.results![index].id,
                                      ),
                                    );
                                  },
                                  child: ProductListContainer(
                                    checkImage: data.comicsModel!
                                        .results![index].image == null ? "" :data.comicsModel!
                                        .results![index].image.toString(),
                                    name: data.comicsModel!
                                        .results![index].name == null ? "" : data.comicsModel!
                                        .results![index].name!,
                                    lowResUrl: data.comicsModel!
                                        .results![index].image != null ? data.comicsModel!
                                        .results![index].image!.low_res_url! :"",
                                    scrappedImage:data.comicsModel!
                                        .results![index].image != null ? data.comicsModel!
                                        .results![index].image!.image_on_list
                                        .toString() :"",
                                    edition: data.comicsModel!
                                        .results![index].edition == null ? "" : data.comicsModel!
                                        .results![index].edition!,
                                    brand: data.comicsModel!
                                        .results![index].series == null ? "" :data.comicsModel!
                                        .results![index].series
                                        .toString(),

                                    brandName: data.comicsModel!
                                        .results![index].series == null ? "" : data.comicsModel!
                                        .results![index].series!,
                                    rarity: data.comicsModel!
                                        .results![index].rarity ==null ? "" :data.comicsModel!
                                        .results![index].rarity!,
                                    floorPrice: data.comicsModel!
                                        .results![index].floorPrice == null ? "" :data.comicsModel!
                                        .results![index].floorPrice!,
                                    series: <ChartSeries<Graph, String>>[
                                      LineSeries<Graph, String>(
                                        color: data.comicsModel!
                                            .results![index]
                                            .priceChangePercent!
                                            .sign ==
                                            'decrease'
                                            ? Colors.red
                                            : Colors.green,
                                        dataSource: data.comicsModel!
                                            .results![index].graph!,
                                        xValueMapper: (Graph plot, _) =>
                                        plot.date,
                                        yValueMapper: (Graph plot, _) =>
                                        plot.floorPrice,
                                        xAxisName: 'Duration',
                                        yAxisName: 'Total',
                                      )
                                    ],
                                    changePrice: data.comicsModel!.results![index].priceChangePercent!.changePrice,
                                    pcpPercent: data.comicsModel!.results![index].priceChangePercent!.percent,
                                    pcpSign: data.comicsModel!.results![index].priceChangePercent!.sign! ,
                                  )
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          'No Comic Found',
                          style: Get.textTheme.bodySmall!
                              .copyWith(color: Colors.white),
                        )))
              : const ColorLoader());
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getComics(
      keyword: widget.keyword,
      rarity: widget.rarity!,
      mint_number: widget.mintNumber,
    );

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getComics(
      offset: offset,
      keyword: widget.keyword,
      rarity: widget.rarity!,
      mint_number: widget.mintNumber,
    );

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
