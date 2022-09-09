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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: AppColors.graphCard,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: Get.height * .09,
                                        width: Get.height * .078,
                                        decoration: BoxDecoration(
                                            color: AppColors.graphCard,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:
                                                    AppColors.textBoxBgColor)),
                                        alignment: Alignment.center,
                                        child: data.searchCollectiblesModel!
                                                    .results![index].image ==
                                                null
                                            ? FirstLetterImage(
                                                firstLetter: data
                                                    .searchCollectiblesModel!
                                                    .results![index]
                                                    .name
                                                    .toString()[0]
                                                    .toUpperCase(),
                                                fontsize: 35,
                                              )
                                            : data
                                                        .searchCollectiblesModel!
                                                        .results![index]
                                                        .image!
                                                        .low_res_url ==
                                                    null
                                                ? VeVeLowImage(
                                                    imageUrl: data
                                                        .searchCollectiblesModel!
                                                        .results![index]
                                                        .image!
                                                        .image_on_list
                                                        .toString(),
                                                  )
                                                : VeVeLowImage(
                                                    imageUrl: data
                                                        .searchCollectiblesModel!
                                                        .results![index]
                                                        .image!
                                                        .low_res_url
                                                        .toString(),
                                                  )),
                                    AppSpaces.spaces_width_5,
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 5,
                                                  child: SizedBox(
                                                    height: Get.height * .02,
                                                    child: Text(
                                                      data.searchCollectiblesModel!
                                                          .results![index].name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Get
                                                          .textTheme.bodyText2!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textColor,
                                                              //fontFamily: 'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp),
                                                    ),
                                                  )),
                                              AppSpaces.spaces_width_2,
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    data.searchCollectiblesModel!
                                                        .results![index].edition
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor,
                                                            /*fontFamily:
                                                                    'Inter',*/
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 10.sp),
                                                  )),
                                            ],
                                          ),
                                          AppSpaces.spaces_height_10,
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  data
                                                              .searchCollectiblesModel!
                                                              .results![index]
                                                              .brand !=
                                                          null
                                                      ? data
                                                          .searchCollectiblesModel!
                                                          .results![index]
                                                          .brand!
                                                          .name
                                                          .toString()
                                                      : "",
                                                  textAlign: TextAlign.start,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textColor
                                                              .withOpacity(0.8),
                                                          //fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 10.sp),
                                                ),
                                              ),
                                              AppSpaces.spaces_width_2,
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  data.searchCollectiblesModel!
                                                      .results![index].rarity
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textColor
                                                              .withOpacity(0.8),
                                                          /*fontFamily: 'Inter',*/
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 10.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          AppSpaces.spaces_height_10,
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  r"$" +
                                                      data
                                                          .searchCollectiblesModel!
                                                          .results![index]
                                                          .floorPrice
                                                          .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textColor
                                                              .withOpacity(0.8),
                                                          //fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 11.sp),
                                                ),
                                              ),
                                              AppSpaces.spaces_width_2,
                                              const Expanded(
                                                flex: 3,
                                                child: Text(""),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.height * .05,
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              primaryXAxis: CategoryAxis(
                                                isVisible: false,
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 0),
                                                labelIntersectAction:
                                                    AxisLabelIntersectAction
                                                        .hide,
                                                labelRotation: 270,
                                                labelAlignment:
                                                    LabelAlignment.start,
                                                maximumLabels: 7,
                                              ),
                                              primaryYAxis: NumericAxis(
                                                numberFormat:
                                                    NumberFormat.compact(),
                                                isVisible: false,
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 0),
                                                labelIntersectAction:
                                                    AxisLabelIntersectAction
                                                        .hide,
                                                labelRotation: 0,
                                                labelAlignment:
                                                    LabelAlignment.start,
                                                maximumLabels: 10,
                                              ),
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                              series: <
                                                  ChartSeries<Graph, String>>[
                                                LineSeries<Graph, String>(
                                                  color: data
                                                              .searchCollectiblesModel!
                                                              .results![index]
                                                              .priceChangePercent!
                                                              .sign ==
                                                          'decrease'
                                                      ? Colors.red
                                                      : Colors.green,
                                                  dataSource: data
                                                      .searchCollectiblesModel!
                                                      .results![index]
                                                      .graph!,
                                                  xValueMapper:
                                                      (Graph plot, _) =>
                                                          plot.date,
                                                  yValueMapper:
                                                      (Graph plot, _) =>
                                                          plot.floorPrice,
                                                  xAxisName: 'Duration',
                                                  yAxisName: 'Total',
                                                )
                                              ],
                                            ),
                                          ),
                                          AppSpaces.spaces_height_10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '\$${data.searchCollectiblesModel!.results![index].priceChangePercent!.cp != null ? data.searchCollectiblesModel!.results![index].priceChangePercent!.cp!.toStringAsFixed(2) : ""}',
                                                  textAlign: TextAlign.start,
                                                  style: Get
                                                      .textTheme.bodyText1!
                                                      .copyWith(
                                                          color: AppColors.white
                                                              .withOpacity(0.9),
                                                          //fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      data
                                                          .searchCollectiblesModel!
                                                          .results![index]
                                                          .priceChangePercent!
                                                          .percent!
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: Get
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: data
                                                                          .searchCollectiblesModel!
                                                                          .results![
                                                                              index]
                                                                          .priceChangePercent!
                                                                          .sign ==
                                                                      'decrease'
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                              //fontFamily: 'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 10.sp),
                                                    ),
                                                    if (data
                                                            .searchCollectiblesModel!
                                                            .results![index]
                                                            .priceChangePercent!
                                                            .sign ==
                                                        'decrease')
                                                      const Icon(
                                                        Icons.arrow_downward,
                                                        color: Colors.red,
                                                        size: 12,
                                                      )
                                                    else
                                                      const Icon(
                                                        Icons.arrow_upward,
                                                        color: Colors.green,
                                                        size: 12,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
