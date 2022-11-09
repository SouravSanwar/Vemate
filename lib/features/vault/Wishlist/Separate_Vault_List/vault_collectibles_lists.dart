import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/models/SetListModel.dart';

class VaultCollectiblesLists extends StatefulWidget {
  const VaultCollectiblesLists({Key? key}) : super(key: key);

  @override
  _VaultCollectiblesListsState createState() => _VaultCollectiblesListsState();
}

class _VaultCollectiblesListsState extends State<VaultCollectiblesLists> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  int page = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  String? searchText;

  TextEditingController searchController = TextEditingController();
  double mysetHeight= Get.height*.115;
  double mysetWidth= Get.width*.95;
  GetData? getData;
  Color? color=Colors.green;
  String? rarity="";
  PostData? postData;
  int offset = 0;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    // TODO: implement initState
    getData!.getSetList('product__type=0');
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => ControllerPage(
              seletedItem: 2,
            ));
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          elevation: 1.0,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.grey),
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            "My Collectibles",
            style: TextStyle(
                color: AppColors.textColor,
                fontFamily: 'Inter',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<GetData>(builder: (content, data, child) {
          return Container(
            height: _height! * .9,
            width: _width,
            padding: const EdgeInsets.only(bottom: 10),
            child: data.setListModel != null
                ? (data.setListModel!.setResults!.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.setListModel!.setResults!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          data.setListModel!
                              .setResults![index].setProductDetail!.rarity !=null
                              ? rarity=data.setListModel!
                              .setResults![index].setProductDetail!.rarity.toString():"";
                          if(rarity=="Common"){
                            color=Colors.green;
                          }
                          else if(rarity=="Uncommon"){
                            color=Colors.purpleAccent;
                          }
                          if(rarity=="Rare"){
                            color=Colors.blue;
                          }
                          if(rarity=="Ultra Rare"){
                            color=Colors.orange;
                          }
                          if(rarity=="Secret Rare"){
                            color=Colors.red;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 10, left: 4, right: 4),
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
                              child:Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: mysetWidth,
                                    height: mysetHeight,
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      border: Border.all(color: color!),
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    left: 2,
                                    child: Container(
                                      width: mysetWidth,
                                      height: mysetHeight,
                                      decoration: BoxDecoration(
                                        color: Color(0xff282742),
                                        border: Border.all(color: Color(0xff282742)),
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    left: 4,
                                    child: Container(
                                      width: mysetWidth,
                                      height: mysetHeight,
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        border: Border.all(color: Color(0xff282742)),
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    child: Container(
                                      width: mysetWidth,
                                      height: mysetHeight,
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        border: Border.all(color: Color(0xff282742)),
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child:Container (
                                      width: mysetWidth,
                                      height: mysetHeight,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff17193C),
                                            Color(0xff313552),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                  ),
                                  /*Positioned(
                                    top: 16,
                                    right: 0,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffD15EED),
                                            Color(0xff8D5FED),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          data.mySetsModel!.results![index].statsDetail!.totalItem.toString(),
                                          style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          );
                        })
                    : const NoDataCard(
                        title: 'Your Collectibles are empty!',
                      ))
                : ColorLoader(),
          );
        }),
      ),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return const ImageIcon(
      AssetImage('assets/media/icon/logo_v.png'),
      color: Color(0xFF3A5A98),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    //getData!.getWishList();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    // getData!.getWishList(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
