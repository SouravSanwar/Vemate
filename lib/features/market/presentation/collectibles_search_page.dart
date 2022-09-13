import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/SearchCollectiblesModel.dart';
import 'package:intl/intl.dart';

class SearchCollectiblePage extends StatefulWidget {
  const SearchCollectiblePage({Key? key}) : super(key: key);

  @override
  _SearchCollectiblePageState createState() => _SearchCollectiblePageState();
}

class _SearchCollectiblePageState extends State<SearchCollectiblePage> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshkey = GlobalKey();

  String? searchText;

  TextEditingController searchController = TextEditingController();
  GetData? getData;
  bool? common = false;
  bool? uncommon = false;
  bool? rare = false;
  bool? ultraRare = false;
  bool? secretRare = false;

  var filterValue = Get.arguments;
  String? rarityValue;

  //bool filterOn = false;

  @override
  void init() {
    rarityValue = filterValue[0].toString().toLowerCase();
    getData!.searchCollectibles(rarity: rarityValue!);

    if (rarityValue == 'common') {
      common = true;
    } else if (rarityValue == 'uncommon') {
      uncommon = true;
    } else if (rarityValue == 'rare') {
      rare = true;
    } else if (rarityValue == 'ultra rare') {
      ultraRare = true;
    } else if (rarityValue == 'secret rare') {
      secretRare = true;
    }

    print("Filter Value" + filterValue[0]);
  }

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    // TODO: implement initState
    if (filterOn == true) {
      init();
    }

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: filterOn == false
              ? TextFormField(
                  controller: searchController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 13, right: 15),
                    hintText: "Search Collectible",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  onChanged: (text) {
                    text = searchController.text;
                    searchText = searchController.text != ''
                        ? searchController.text
                        : '';
                    setState(() {
                      getData!.searchCollectibles(keyWord: searchText!);
                    });
                  },
                  autofocus: true,
                )
              : Text(
                  filterValue[0] + " Collectibles",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: 'Inter',
                  ),
                ),
        ),
      ),
      body: Consumer<GetData>(builder: (content, data, child) {
        return SizedBox(
          child: data.searchCollectiblesModel != null
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
                  child: ListView.builder(
                      itemCount: data.searchCollectiblesModel!.results!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => CollectibleDetails(
                                productId: data.searchCollectiblesModel!
                                    .results![index].id,
                              ),
                            );
                          },
                          child: ProductListContainer(
                            checkImage: data.searchCollectiblesModel!
                                .results![index].image == null ? "" :data.searchCollectiblesModel!
                                .results![index].image.toString(),
                            name: data.searchCollectiblesModel!
                                .results![index].name == null ? "" : data.searchCollectiblesModel!
                                .results![index].name!,
                            lowResUrl: data.searchCollectiblesModel!
                                .results![index].image != null ? data.searchCollectiblesModel!
                                .results![index].image!.low_res_url! :"",
                            scrappedImage:data.searchCollectiblesModel!
                                .results![index].image != null ? data.searchCollectiblesModel!
                                .results![index].image!.image_on_list
                                .toString() :"",
                            edition: data.searchCollectiblesModel!
                                .results![index].edition == null ? "" : data.searchCollectiblesModel!
                                .results![index].edition!,
                            brand: data.searchCollectiblesModel!
                                .results![index].brand == null ? "" : data.searchCollectiblesModel!
                                .results![index].brand
                                .toString(),

                            brandName: data.searchCollectiblesModel!
                                .results![index].brand == null ? "" : data.searchCollectiblesModel!
                                .results![index].brand!.name!,
                            rarity: data.searchCollectiblesModel!
                                .results![index].rarity ==null ? "" :data.searchCollectiblesModel!
                                .results![index].rarity!,
                            floorPrice: data.searchCollectiblesModel!
                                .results![index].floorPrice == null ? "" :data.searchCollectiblesModel!
                                .results![index].floorPrice!,
                            series: <ChartSeries<Graph, String>>[
                              LineSeries<Graph, String>(
                                color: data.searchCollectiblesModel!
                                    .results![index]
                                    .priceChangePercent!
                                    .sign ==
                                    'decrease'
                                    ? Colors.red
                                    : Colors.green,
                                dataSource: data.searchCollectiblesModel!
                                    .results![index].graph!,
                                xValueMapper: (Graph plot, _) =>
                                plot.date,
                                yValueMapper: (Graph plot, _) =>
                                plot.floorPrice,
                                xAxisName: 'Duration',
                                yAxisName: 'Total',
                              )
                            ],
                            changePrice: data.searchCollectiblesModel!.results![index].priceChangePercent!.cp,
                            pcpPercent: data.searchCollectiblesModel!.results![index].priceChangePercent!.percent,
                            pcpSign: data.searchCollectiblesModel!.results![index].priceChangePercent!.sign! ,
                          )
                        );
                      }))
              : ColorLoader(),
        );
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    if (common == true) {
      getData!.searchCollectibles(rarity: 'common');
    } else if (uncommon == true) {
      getData!.searchCollectibles(rarity: 'uncommon');
    } else if (rare == true) {
      getData!.searchCollectibles(rarity: 'rare');
    } else if (ultraRare == true) {
      getData!.searchCollectibles(rarity: 'ultra rare');
    } else if (secretRare == true) {
      getData!.searchCollectibles(rarity: 'secret rare');
    } else {
      getData!.searchCollectibles(keyWord: searchText!);
    }

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    if (common == true) {
      getData!.searchCollectibles(rarity: 'common', offset: offset);
    } else if (uncommon == true) {
      getData!.searchCollectibles(rarity: 'uncommon', offset: offset);
    } else if (rare == true) {
      getData!.searchCollectibles(rarity: 'rare', offset: offset);
    } else if (ultraRare == true) {
      getData!.searchCollectibles(rarity: 'ultra rare', offset: offset);
    } else if (secretRare == true) {
      getData!.searchCollectibles(rarity: 'secret rare', offset: offset);
    } else {
      getData!.searchCollectibles(offset: offset);
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
