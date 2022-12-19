import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/Auction/auction_card_container.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/models/CollectiblesModel.dart';
import 'package:intl/intl.dart';
import '../../../core/utilities/app_colors/app_colors.dart';

class Auction extends StatefulWidget {
  final String? keyword;
  final String? rarity;
  final String? mintNumber;

  const Auction({Key? key, this.keyword, this.rarity, this.mintNumber}) : super(key: key);

  @override
  State<Auction> createState() => _AuctionState();
}

class _AuctionState extends State<Auction> {
  int offset = 0;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refreshkey = GlobalKey();

  GetData? getData;

  @override
  void initState() {
    super.initState();
    getData = Provider.of<GetData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: Get.height*.065,
            color: AppColors.graphCard,
            padding: EdgeInsets.symmetric(horizontal: Get.width *0.02778,),
            child: Row(
              children: [
                Text("Auction",style: TextStyle(fontSize: 20,fontFamily: 'Inter',fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          AppSpaces.spaces_height_10,
          Consumer<GetData>(builder: (context, data, child) {
            return SizedBox(
              height: Get.height * .772,
              child: data.collectiblesModel != null
                  ? SmartRefresher(
                key: _refreshkey,
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
                child: data.collectiblesModel!.results!.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.collectiblesModel!.results!.length,
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
                                    () => CollectibleDetails(
                                  productId: data.collectiblesModel!
                                      .results![index].id,
                                ),
                              );
                            },
                            child: AuctionCardContainer(
                              is_listed_on_veve_market: data.collectiblesModel!
                                  .results![index].is_listed_on_veve_market,
                              checkImage: data.collectiblesModel!
                                  .results![index].image == null ? "" :data.collectiblesModel!
                                  .results![index].image.toString(),
                              name: data.collectiblesModel!
                                  .results![index].name == null ? "" : data.collectiblesModel!
                                  .results![index].name!,
                              lowResUrl: data.collectiblesModel!
                                  .results![index].image != null ? data.collectiblesModel!
                                  .results![index].image!.low_res_url! :"",
                              scrappedImage:data.collectiblesModel!
                                  .results![index].image != null ? data.collectiblesModel!
                                  .results![index].image!.image_on_list
                                  .toString() :"",
                              edition: data.collectiblesModel!
                                  .results![index].edition == null ? "" : data.collectiblesModel!
                                  .results![index].edition!,
                              brand: data.collectiblesModel!
                                  .results![index].brand == null ? "" :data.collectiblesModel!
                                  .results![index].brand
                                  .toString(),

                              brandName: data.collectiblesModel!
                                  .results![index].brand == null ? "" : data.collectiblesModel!
                                  .results![index].brand!.name!,
                              rarity: data.collectiblesModel!
                                  .results![index].rarity ==null ? "" :data.collectiblesModel!
                                  .results![index].rarity!,
                              floorPrice: data.collectiblesModel!
                                  .results![index].floorPrice == null ? "" :data.collectiblesModel!
                                  .results![index].floorPrice!,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      ShowAlertBox(
                                        results: data.collectiblesModel!.results![index],
                                        origin: 'collectible',
                                      ),
                                );
                              },
                              isAlert: data.collectiblesModel!
                                  .results![index].isProductAlert!,
                              series: <ChartSeries<Graph, String>>[
                                LineSeries<Graph, String>(
                                  color: data
                                      .collectiblesModel!
                                      .results![index]
                                      .graphData!.priceChangePercent!
                                      .sign ==
                                      'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: data.collectiblesModel!
                                      .results![index].graphData!.graph!,
                                  xValueMapper: (Graph plot, _) =>
                                  plot.date,
                                  yValueMapper: (Graph plot, _) =>
                                  plot.floorPrice,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                )
                              ],
                              changePrice: data.collectiblesModel!.results![index].graphData!.priceChangePercent!.changePrice,
                              pcpPercent: data.collectiblesModel!.results![index].graphData!.priceChangePercent!.percent,
                              pcpSign: data.collectiblesModel!.results![index].graphData!.priceChangePercent!.sign! ,
                            )
                        ),
                      ),
                    );
                  },
                )
                    : Center(
                    child: Text(
                      'No Collectible Found',
                      style: Get.textTheme.bodySmall!
                          .copyWith(color: Colors.white),
                    )),
              )
                  : const ColorLoader(),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getCollectibles(
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

    getData!.getCollectibles(
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
