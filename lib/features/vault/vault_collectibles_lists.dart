import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/models/SetListModel.dart';

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
  GetData? getData;
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
        title: Text(
          "My Collectibles",
          style: TextStyle(
              color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<GetData>(builder: (content, data, child) {
        return Container(
          height: _height! * .9,
          width: _width,
          padding: const EdgeInsets.only(bottom: 10),
          child: data.setListModel!.results!.length != null
              ? ListView.builder(
                  itemCount: data.setListModel!.results!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return data.setListModel!.results![index].productDetail!
                                .type ==
                            0
                        ? InkWell(
                            onTap: () {
                              /*Get.to(() => ChartExample(id: widget.list![index].id));*/

                              data.setListModel!.results![index].productDetail!
                                          .type ==
                                      1
                                  ? Get.to(() => () {})
                                  : Get.to(() => CollectibleDetails(
                                        productId: data.setListModel!
                                            .results![index].productDetail!.id!,
                                      ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  gradient: AppColors.cardGradient,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color:AppColors.borderColor),
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
                                            color: const Color(0xD3C89EF3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(color:AppColors.borderColor)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          data.setListModel!.results![index]
                                              .productDetail!.name
                                              .toString()[0]
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      AppSpaces.spaces_width_2,
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    flex: 4,
                                                    child: SizedBox(
                                                      height: Get.height * .02,
                                                      child: Text(
                                                        data
                                                            .setListModel!
                                                            .results![index]
                                                            .productDetail!
                                                            .name
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: Get.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: AppColors.textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13),
                                                      ),
                                                    )),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      data
                                                          .setListModel!
                                                          .results![index]
                                                          .productDetail!
                                                          .edition
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Get
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color: AppColors.textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 10),
                                                    )),
                                              ],
                                            ),
                                            AppSpaces.spaces_height_10,
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    data
                                                                .setListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .type ==
                                                            1
                                                        ? data
                                                                    .setListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .series !=
                                                                null
                                                            ? data
                                                                .setListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .series
                                                                .toString()
                                                            : ""
                                                        : data
                                                                    .setListModel!
                                                                    .results![
                                                                        index]
                                                                    .productDetail!
                                                                    .brand !=
                                                                null
                                                            ? data
                                                                .setListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .brand!
                                                                .name
                                                                .toString()
                                                            : "",
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors.textColor,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 10),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data
                                                        .setListModel!
                                                        .results![index]
                                                        .productDetail!
                                                        .rarity
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors.textColor,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 10),
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
                                                            .setListModel!
                                                            .results![index]
                                                            .productDetail!
                                                            .floorPrice
                                                            .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors.textColor,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 11),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '\$${data.setListModel!.results![index].productDetail!.priceChangePercent!.changePrice != null ? data.setListModel!.results![index].productDetail!.priceChangePercent!.changePrice!.toStringAsFixed(2) : ""}',
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors.textColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11),
                                                  ),
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
                                                                .setListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .priceChangePercent!
                                                                .sign ==
                                                            'decrease'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    dataSource: data
                                                        .setListModel!
                                                        .results![index]
                                                        .productDetail!
                                                        .graph!,
                                                    xValueMapper:
                                                        (Graph plot, _) =>
                                                            plot.hour,
                                                    yValueMapper:
                                                        (Graph plot, _) =>
                                                            plot.total,
                                                    xAxisName: 'Duration',
                                                    yAxisName: 'Total',
                                                  )
                                                ],
                                              ),
                                            ),
                                            AppSpaces.spaces_height_10,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        data
                                                                .setListModel!
                                                                .results![index]
                                                                .productDetail!
                                                                .priceChangePercent!
                                                                .percent!
                                                                .toString() +
                                                            "%",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: Get.textTheme.bodyText1!.copyWith(
                                                            color: data
                                                                        .setListModel!
                                                                        .results![
                                                                            index]
                                                                        .productDetail!
                                                                        .priceChangePercent!
                                                                        .sign ==
                                                                    'decrease'
                                                                ? Colors.red
                                                                : Colors.green,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 10),
                                                      ),
                                                      if (data
                                                              .setListModel!
                                                              .results![index]
                                                              .productDetail!
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
                                                InkWell(
                                                  onTap: () {
                                                    postData!.deleteSetList(
                                                      context,
                                                      data.setListModel!
                                                          .results![index].id,
                                                      requestHeadersWithToken,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    color: AppColors.textColor,
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
                          )
                        : Container();
                  })
              : const LoadingExample(),
        );
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
