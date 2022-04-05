import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/SearchCollectiblesModel.dart';

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
  int page = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshkey = GlobalKey();

  String? searchText;

  TextEditingController searchController = TextEditingController();
  GetData? getData;

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
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
        backgroundColor: AppColors.lightBackgroundColor,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: searchController,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 13, right: 15),
                hintText: "Search Collectible",
                hintStyle: TextStyle(color: Colors.white),


            ),
            onChanged: (text) {
              text = searchController.text;
              searchText =
                  searchController.text != '' ? searchController.text : '';
              setState(() {
                getData!.searchCollectibles(searchText);
              });
            },
            autofocus: true,
          ),
        ),
      ),
      body: Consumer<GetData>(builder: (content, data, child) {
        return Container(
          height: _height! * .9,
          width: _width,
          padding: const EdgeInsets.only(bottom: 10),
          child: data.searchCollectiblesModel != null
              ? ListView.builder(
                  itemCount: data.searchCollectiblesModel!.results!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => CollectibleDetails(
                            productId:
                            data.searchCollectiblesModel!.results![index].id,
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xff454F70))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data.searchCollectiblesModel!
                                        .results![index].name
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
                                  flex: 11,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  textAlign: TextAlign.start,
                                                  style: Get
                                                      .textTheme.bodyText2!
                                                      .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                data.searchCollectiblesModel!
                                                    .results![index].edition
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: Get.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10),
                                              )),
                                        ],
                                      ),
                                      AppSpaces.spaces_height_10,
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              data.searchCollectiblesModel!
                                                  .results![index].brand
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 10),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              data.searchCollectiblesModel!
                                                  .results![index].rarity
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
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
                                            flex: 5,
                                            child: Text(
                                              r"$" +
                                                  data
                                                      .searchCollectiblesModel!
                                                      .results![index]
                                                      .floorPrice
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.greyWhite
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 11),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
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
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Get.height * .05,
                                        child: SfCartesianChart(
                                          plotAreaBorderWidth: 0,
                                          primaryXAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            labelIntersectAction:
                                                AxisLabelIntersectAction.hide,
                                            labelRotation: 270,
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 7,
                                          ),
                                          primaryYAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            labelIntersectAction:
                                                AxisLabelIntersectAction.hide,
                                            labelRotation: 0,
                                            labelAlignment:
                                                LabelAlignment.start,
                                            maximumLabels: 10,
                                          ),
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <ChartSeries<Graph, String>>[
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
                                              xValueMapper: (Graph plot, _) =>
                                                  plot.hour,
                                              yValueMapper: (Graph plot, _) =>
                                                  plot.total,
                                              xAxisName: 'Duration',
                                              yAxisName: 'Total',
                                            )
                                          ],
                                        ), /*LineChart(
                                        mainData(), // Optional
                                        swapAnimationCurve:
                                            Curves.linear, // Optional
                                      ),*/
                                      ),
                                      AppSpaces.spaces_height_10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$${data.searchCollectiblesModel!.results![index].cpp}',
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: AppColors.white
                                                          .withOpacity(0.9),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11),
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
                                                              : Colors.green,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 10),
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
                  })
              : const LoadingExample(),
        );
      }),
    );
  }
}
