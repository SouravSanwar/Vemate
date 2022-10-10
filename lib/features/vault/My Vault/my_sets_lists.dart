import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/models/SetListModel.dart';

class SetListPage extends StatefulWidget {
  const SetListPage({Key? key}) : super(key: key);

  @override
  State<SetListPage> createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  GetData? getData;

  PostData? postData;

  int alertCheck = 0;
  int offset = 0;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refreshkey = GlobalKey();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);

    getData!.getSetList('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Vault',
              style: Get.textTheme.headline2!
                  .copyWith(fontFamily: 'Inter', color: AppColors.textColor),
            ),
          ],
        ),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.setListModel != null
            ? SmartRefresher(
          key: _refreshkey,
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            color: AppColors.primaryColor,
          ),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: data.setListModel!.setResults != null
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: data.setListModel!.setResults!.length,
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
                      child: SwipeActionCell(
                        backgroundColor: Colors.transparent,
                        key: ObjectKey(data
                            .setListModel!
                            .setResults![index]),
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                              title: "Delete",style: TextStyle(fontSize: 14),
                              performsFirstActionWithFullSwipe: true,

                              icon: Icon(
                                Icons.delete,
                                color: AppColors.white,
                              ),
                              onTap: (CompletionHandler
                              handler) async {
                                postData!
                                    .deleteSetList(
                                    context,
                                    data
                                        .setListModel!
                                        .setResults![
                                    index]
                                        .id,
                                    requestHeadersWithToken,
                                    'product__type=0',deleteset: 13
                                ).whenComplete(() => Provider.of<GetData>(context,listen: false).getSetList(''))
                                    .whenComplete(() => Provider.of<GetData>(context,listen: false).getHomeVault());
                              },
                              color: Colors.red),

                        ],
                        child: InkWell(
                            onTap: () {
                              Get.to(() => CollectibleDetails(
                                productId: data
                                    .setListModel!
                                    .setResults![index]
                                    .setProductDetail!
                                    .id!,
                              ));
                            },
                            child: ProductListContainer(
                              checkImage: data.setListModel!
                                  .setResults![index].setProductDetail!.image == null ? "" :data.setListModel!
                                  .setResults![index].setProductDetail!.image.toString(),
                              name: data.setListModel!
                                  .setResults![index].setProductDetail!.name == null ? "" : data.setListModel!
                                  .setResults![index].setProductDetail!.name!,
                              lowResUrl: data.setListModel!
                                  .setResults![index].setProductDetail!.image != null ? data.setListModel!
                                  .setResults![index].setProductDetail!.image!.low_res_url! :"",
                              scrappedImage:data.setListModel!
                                  .setResults![index].setProductDetail!.image != null ? data.setListModel!
                                  .setResults![index].setProductDetail!.image!.image_on_list
                                  .toString() :"",
                              edition: data.setListModel!
                                  .setResults![index].setProductDetail!.edition == null ? "" : data.setListModel!
                                  .setResults![index].setProductDetail!.edition!,
                              brand: data.setListModel!
                                  .setResults![index].setProductDetail!.brand == null ? "" :data.setListModel!
                                  .setResults![index].setProductDetail!.brand
                                  .toString(),

                              brandName: data.setListModel!
                                  .setResults![index].setProductDetail!.brand == null ? "" : data.setListModel!
                                  .setResults![index].setProductDetail!.brand!.name!,
                              rarity: data.setListModel!
                                  .setResults![index].setProductDetail!.rarity ==null ? "" :data.setListModel!
                                  .setResults![index].setProductDetail!.rarity!,
                              floorPrice: data.setListModel!
                                  .setResults![index].setProductDetail!.floorPrice == null ? "" :data.setListModel!
                                  .setResults![index].setProductDetail!.floorPrice!,
                              isAlert: data.setListModel!
                                  .setResults![index].setProductDetail!.isProductAlert!,
                              series: <ChartSeries<Graph, String>>[
                                LineSeries<Graph, String>(
                                  color: data.setListModel!
                                      .setResults![index].setProductDetail!.graphData!.priceChangePercent!
                                      .sign ==
                                      'decrease'
                                      ? Colors.red
                                      : Colors.green,
                                  dataSource: data.setListModel!
                                      .setResults![index].setProductDetail!.graphData!.graph!,
                                  xValueMapper: (Graph plot, _) =>
                                  plot.date,
                                  yValueMapper: (Graph plot, _) =>
                                  plot.floorPrice,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                )
                              ],
                              changePrice: data.setListModel!
                                  .setResults![index].setProductDetail!.graphData!.priceChangePercent!.changePrice,
                              pcpPercent: data.setListModel!
                                  .setResults![index].setProductDetail!.graphData!.priceChangePercent!.percent,
                              pcpSign: data.setListModel!
                                  .setResults![index].setProductDetail!.graphData!.priceChangePercent!.sign! ,
                            )
                        ),
                      )
                  )
              );
            },
          )
              : const LoadingExample(),
        )
            : const ColorLoader();
      }),
    );
  }


  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getWishList();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getWishList(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}