import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../core/models/WishListModel.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
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

    getData!.getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

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
              'My Wishlist',
              style: Get.textTheme.headline2!
                  .copyWith(fontFamily: 'Inter', color: AppColors.textColor),
            ),
          ],
        ),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.wishListModel != null
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
                child: data.wishListModel!.results != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.wishListModel!.results!.length,
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
                                        .wishListModel!
                                        .results![index]),
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
                                            alertCheck = 0;
                                            if (data
                                                .wishListModel!
                                                .results![index]
                                                .alertData !=
                                                null) {
                                              postData!.deleteAlert(
                                                context,
                                                data
                                                    .wishListModel!
                                                    .results![index]
                                                    .alertData!
                                                    .id,
                                                requestHeadersWithToken,
                                              );
                                              alertCheck = 1;
                                            }
                                            postData!.deleteWishlist(
                                                context,
                                                alertCheck,
                                                data.wishListModel!
                                                    .results![index].id,
                                                requestHeadersWithToken,
                                                check: 12)
                                                .whenComplete(() => Provider.of<GetData>(context,listen: false).getWishList());
                                          },
                                          color: Colors.red),

                                    ],
                                    child: InkWell(
                                        onTap: () {
                                          data.wishListModel!.results![index]
                                              .productDetail!.type ==
                                              0
                                              ? Get.to(
                                                () => CollectibleDetails(
                                              productId: data
                                                  .wishListModel!
                                                  .results![index]
                                                  .productDetail!
                                                  .id!,
                                            ),
                                          )
                                              : Get.to(
                                                () => ComicDetails(
                                              productId: data.wishListModel!.results![index].productDetail!
                                                  .id!,
                                            ),
                                          );
                                        },
                                        child: ProductListContainer(
                                          checkImage: data.wishListModel!.results![index].productDetail!.image == null ? ""
                                              :data.wishListModel!.results![index].productDetail!.image.toString(),
                                          name: data.wishListModel!.results![index].productDetail!.name == null ? ""
                                              : data.wishListModel!.results![index].productDetail!.name!,
                                          lowResUrl: data.wishListModel!.results![index].productDetail!.image != null
                                              ? data.wishListModel!.results![index].productDetail!.image!.low_res_url! :"",
                                          scrappedImage:data.wishListModel!.results![index].productDetail!.image != null ?
                                          data.wishListModel!.results![index].productDetail!.image!.image_on_list
                                              .toString() :"",
                                          edition: data.wishListModel!.results![index].productDetail!.edition == null ? ""
                                              : data.wishListModel!.results![index].productDetail!.edition!,
                                          brand: data.wishListModel!.results![index].productDetail!.brand == null ? ""
                                              :data.wishListModel!.results![index].productDetail!.brand
                                              .toString(),

                                          brandName: data.wishListModel!.results![index].productDetail!.brand == null ? ""
                                              : data.wishListModel!.results![index].productDetail!.brand!.name!,
                                          rarity: data.wishListModel!.results![index].productDetail!.rarity ==null ? ""
                                              :data.wishListModel!.results![index].productDetail!.rarity!,
                                          floorPrice: data.wishListModel!.results![index].productDetail!.floorPrice == null ? ""
                                              :data.wishListModel!.results![index].productDetail!.floorPrice!,
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  ShowAlertBox(
                                                    results: data.wishListModel!.results![index].productDetail!,
                                                  ),
                                            );
                                          },
                                          isAlert: data.wishListModel!.results![index].productDetail!.isProductAlert!,
                                          series: <ChartSeries<Graph, String>>[
                                            LineSeries<Graph, String>(
                                              color: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!
                                                  .sign ==
                                                  'decrease'
                                                  ? Colors.red
                                                  : Colors.green,
                                              dataSource: data.wishListModel!.results![index].productDetail!.graphData!.graph!,
                                              xValueMapper: (Graph plot, _) =>
                                              plot.date,
                                              yValueMapper: (Graph plot, _) =>
                                              plot.floorPrice,
                                              xAxisName: 'Duration',
                                              yAxisName: 'Total',
                                            )
                                          ],
                                          changePrice: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.changePrice,
                                          pcpPercent: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.percent,
                                          pcpSign: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign! ,
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
