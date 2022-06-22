import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
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

    rarityValue=filterValue[0].toString().toLowerCase();
    getData!.searchComics(rarity: rarityValue!);

    if(rarityValue=='common'){
      common=true;
    }
    else if(rarityValue=='uncommon'){
      uncommon=true;
    }
    else if(rarityValue=='rare'){
      rare=true;
    }
    else if(rarityValue=='ultra rare'){
      ultraRare=true;
    }
    else if(rarityValue=='secret rare'){
      secretRare=true;
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
                  decoration:  InputDecoration(
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
        return SmartRefresher(
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
          child: ListView(
            children: [
              Container(
                width: _width,
                padding: const EdgeInsets.only(bottom: 10),
                child: data.searchComicsModel != null
                    ? ListView.builder(
                        itemCount: data.searchComicsModel!.results!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => ComicDetails(
                                  productId: data
                                      .searchComicsModel!.results![index].id,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  gradient: AppColors.cardGradient,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: AppColors.borderColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: Get.height * .078,
                                        width: Get.height * .078,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:AppColors.borderColor)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          data.searchComicsModel!
                                              .results![index].name
                                              .toString()[0]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: AppColors
                                                  .backgroundColor,
                                              fontSize: 35.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
                                                    flex: 2,
                                                    child: SizedBox(
                                                      height: Get.height * .02,
                                                      child: Text(
                                                        data
                                                            .searchComicsModel!
                                                            .results![index]
                                                            .name
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13.sp),
                                                      ),
                                                    )),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      data
                                                          .searchComicsModel!
                                                          .results![index]
                                                          .edition
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Get
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 10.sp),
                                                    )),
                                              ],
                                            ),
                                            AppSpaces.spaces_height_10,
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    data.searchComicsModel!
                                                        .results![index].series
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 10.sp),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.searchComicsModel!
                                                        .results![index].rarity
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor
                                                                .withOpacity(
                                                                    0.8),
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
                                                  flex: 4,
                                                  child: Text(
                                                    r"$" +
                                                        data
                                                            .searchComicsModel!
                                                            .results![index]
                                                            .floorPrice
                                                            .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 11.sp),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                const Expanded(
                                                  flex: 2,
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
                                            Container(
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
                                                primaryYAxis: CategoryAxis(
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
                                                    TooltipBehavior(
                                                        enable: true),
                                                series: <
                                                    ChartSeries<Graph, String>>[
                                                  LineSeries<Graph, String>(
                                                    color: data
                                                                .searchComicsModel!
                                                                .results![index]
                                                                .priceChangePercent!
                                                                .sign ==
                                                            'decrease'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    dataSource: data
                                                        .searchComicsModel!
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
                                                    '\$${data.searchComicsModel!.results![index].priceChangePercent!.changePrice != null ? data.searchComicsModel!.results![index].priceChangePercent!.changePrice!.toStringAsFixed(2) : ""}',
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor
                                                                .withOpacity(
                                                                    0.9),
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
                                                            .searchComicsModel!
                                                            .results![index]
                                                            .priceChangePercent!
                                                            .percent!
                                                            .toStringAsFixed(2),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: Get.textTheme.bodyText1!.copyWith(
                                                            color: data
                                                                        .searchComicsModel!
                                                                        .results![
                                                                            index]
                                                                        .priceChangePercent!
                                                                        .sign ==
                                                                    'decrease'
                                                                ? Colors.red
                                                                : Colors.green,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 10.sp),
                                                      ),
                                                      if (data
                                                              .searchComicsModel!
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
                        })
                    : const LoadingExample(),
              ),
            ],
          ),
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
