import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/models/SearchComicsModel.dart';

class SearchComicsPage extends StatefulWidget {
  const SearchComicsPage({Key? key}) : super(key: key);

  @override
  _SearchComicsPageState createState() => _SearchComicsPageState();
}

class _SearchComicsPageState extends State<SearchComicsPage> {
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

  @override
  void init() {
    rarityValue = filterValue[0].toString().toLowerCase();
    getData!.searchComics(rarity: rarityValue!);

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
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 13, right: 15),
                      hintText: "Search Comics",
                      hintStyle: TextStyle(color: AppColors.textColor)),
                  onChanged: (text) {
                    text = searchController.text;
                    searchText = searchController.text != ''
                        ? searchController.text
                        : '';
                    setState(() {
                      getData!.searchComics(keyWord: searchText!);
                    });
                  },
                  autofocus: true,
                )
              : Text(filterValue[0] + " Comics",
                  style: TextStyle(fontSize: 22.sp)),
        ),
      ),
      body: Consumer<GetData>(builder: (content, data, child) {
        return SizedBox(
          child: data.searchComicsModel != null
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
                      itemCount: data.searchComicsModel!.results!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ComicDetails(
                                productId:
                                    data.searchComicsModel!.results![index].id,
                              ),
                            );
                          },
                          child: ProductListContainer(
                            is_listed_on_veve_market: data.comicsModel!
                                .results![index].is_listed_on_veve_market,
                            checkImage: data.searchComicsModel!
                                .results![index].image == null ? "" :data.searchComicsModel!
                                .results![index].image.toString(),
                            name: data.searchComicsModel!
                                .results![index].name == null ? "" : data.searchComicsModel!
                                .results![index].name!,
                            lowResUrl: data.searchComicsModel!
                                .results![index].image != null ? data.searchComicsModel!
                                .results![index].image!.low_res_url! :"",
                            scrappedImage:data.searchComicsModel!
                                .results![index].image != null ? data.searchComicsModel!
                                .results![index].image!.image_on_list
                                .toString() :"",
                            edition: data.searchComicsModel!
                                .results![index].edition == null ? "" : data.searchComicsModel!
                                .results![index].edition!,
                            brand: data.searchComicsModel!
                                .results![index].series == null ? "" :data.searchComicsModel!
                                .results![index].series
                                .toString(),

                            brandName: data.searchComicsModel!
                                .results![index].series == null ? "" : data.searchComicsModel!
                                .results![index].series!,
                            rarity: data.searchComicsModel!
                                .results![index].rarity ==null ? "" :data.searchComicsModel!
                                .results![index].rarity!,
                            floorPrice: data.searchComicsModel!
                                .results![index].floorPrice == null ? "" :data.searchComicsModel!
                                .results![index].floorPrice!,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) =>
                                    ShowAlertBox(
                                      results: data.searchCollectiblesModel!.results![index],
                                      origin: 'search_collectible',
                                    ),
                              );
                            },
                            isAlert: data.searchComicsModel!
                                .results![index].isProductAlert!,

                            series: <ChartSeries<Graph, String>>[
                              LineSeries<Graph, String>(
                                color: data.searchComicsModel!
                                    .results![index].graphData!
                                    .priceChangePercent!
                                    .sign ==
                                    'decrease'
                                    ? Colors.red
                                    : Colors.green,
                                dataSource: data.searchComicsModel!
                                    .results![index].graphData!.graph!,
                                xValueMapper: (Graph plot, _) =>
                                plot.date,
                                yValueMapper: (Graph plot, _) =>
                                plot.floorPrice,
                                xAxisName: 'Duration',
                                yAxisName: 'Total',
                              )
                            ],
                            changePrice: data.searchComicsModel!.results![index].graphData!.priceChangePercent!.changePrice,
                            pcpPercent: data.searchComicsModel!.results![index].graphData!.priceChangePercent!.percent,
                            pcpSign: data.searchComicsModel!.results![index].graphData!.priceChangePercent!.sign! ,
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
      getData!.searchComics(rarity: 'common');
    } else if (uncommon == true) {
      getData!.searchComics(rarity: 'uncommon');
    } else if (rare == true) {
      getData!.searchComics(rarity: 'rare');
    } else if (ultraRare == true) {
      getData!.searchComics(rarity: 'ultra rare');
    } else if (secretRare == true) {
      getData!.searchComics(rarity: 'secret rare');
    } else {
      getData!.searchComics(keyWord: searchText!);
    }

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    if (common == true) {
      getData!.searchComics(rarity: 'common', offset: offset);
    } else if (uncommon == true) {
      getData!.searchComics(rarity: 'uncommon', offset: offset);
    } else if (rare == true) {
      getData!.searchComics(rarity: 'rare', offset: offset);
    } else if (ultraRare == true) {
      getData!.searchComics(rarity: 'ultra rare', offset: offset);
    } else if (secretRare == true) {
      getData!.searchComics(rarity: 'secret rare', offset: offset);
    } else {
      getData!.searchComics(offset: offset);
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
