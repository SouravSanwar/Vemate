import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/models/SetListModel.dart';

class VaultComicsList extends StatefulWidget {
  const VaultComicsList({Key? key}) : super(key: key);

  @override
  _VaultComicsListState createState() => _VaultComicsListState();
}

class _VaultComicsListState extends State<VaultComicsList> {
  double? _height, _width;
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

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "My Comics",
          style: TextStyle(
              color: AppColors.textColor,
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
              ? ListView.builder(
                  itemCount: data.setListModel!.setResults!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    printInfo(
                        info: 'comic count: ' +
                            data.setListModel!.setResults![index]
                                .setProductDetail!.setComicCount
                                .toString());
                    return data.setListModel!.setResults![index]
                                .setProductDetail!.type ==
                            1
                        ? InkWell(
                            onTap: () {
                              data.setListModel!.setResults![index]
                                          .setProductDetail!.type ==
                                      0
                                  ? Get.to(() => () {})
                                  : Get.to(() => ComicDetails(
                                        productId: data
                                            .setListModel!
                                            .setResults![index]
                                            .setProductDetail!
                                            .id!,
                                      ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    gradient: AppColors.cardGradient,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: AppColors.borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: Get.height * .09,
                                        width: Get.height * .078,
                                        decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.borderColor)),
                                        alignment: Alignment.center,
                                        child: data
                                                    .setListModel!
                                                    .setResults![index]
                                                    .setProductDetail!
                                                    .image!
                                                    .image_on_list ==
                                                null
                                            ? Text(
                                                data
                                                    .setListModel!
                                                    .setResults![index]
                                                    .setProductDetail!
                                                    .name
                                                    .toString()[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: AppColors
                                                        .backgroundColor,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: data
                                                    .setListModel!
                                                    .setResults![index]
                                                    .setProductDetail!
                                                    .image!
                                                    .image_on_list!
                                                    .src
                                                    .toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: _loader,
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
                                                    flex: 4,
                                                    child: SizedBox(
                                                      height: Get.height * .02,
                                                      child: Text(
                                                        data
                                                            .setListModel!
                                                            .setResults![index]
                                                            .setProductDetail!
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
                                                                fontSize:
                                                                    13.sp),
                                                      ),
                                                    )),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      data
                                                          .setListModel!
                                                          .setResults![index]
                                                          .setProductDetail!
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
                                                    data
                                                                .setListModel!
                                                                .setResults![
                                                                    index]
                                                                .setProductDetail!
                                                                .type ==
                                                            1
                                                        ? data
                                                                    .setListModel!
                                                                    .setResults![
                                                                        index]
                                                                    .setProductDetail!
                                                                    .series !=
                                                                null
                                                            ? data
                                                                .setListModel!
                                                                .setResults![
                                                                    index]
                                                                .setProductDetail!
                                                                .series
                                                                .toString()
                                                            : ""
                                                        : data
                                                                    .setListModel!
                                                                    .setResults![
                                                                        index]
                                                                    .setProductDetail!
                                                                    .brand !=
                                                                null
                                                            ? data
                                                                .setListModel!
                                                                .setResults![
                                                                    index]
                                                                .setProductDetail!
                                                                .brand!
                                                                .name
                                                                .toString()
                                                            : "",
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 10.sp),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data
                                                        .setListModel!
                                                        .setResults![index]
                                                        .setProductDetail!
                                                        .rarity
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor,
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
                                                            .setListModel!
                                                            .setResults![index]
                                                            .setProductDetail!
                                                            .floorPrice
                                                            .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 11.sp),
                                                  ),
                                                ),
                                                AppSpaces.spaces_width_2,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '\$${data.setListModel!.setResults![index].setProductDetail!.priceChangePercent!.changePrice != null ? data.setListModel!.setResults![index].setProductDetail!.priceChangePercent!.changePrice!.toStringAsFixed(2) : ""}',
                                                    textAlign: TextAlign.start,
                                                    style: Get
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11.sp),
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
                                                                .setResults![
                                                                    index]
                                                                .setProductDetail!
                                                                .priceChangePercent!
                                                                .sign ==
                                                            'decrease'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    dataSource: data
                                                        .setListModel!
                                                        .setResults![index]
                                                        .setProductDetail!
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
                                                                .setResults![
                                                                    index]
                                                                .setProductDetail!
                                                                .priceChangePercent!
                                                                .percent!
                                                                .toString() +
                                                            "%",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: Get.textTheme.bodyText1!.copyWith(
                                                            color: data
                                                                        .setListModel!
                                                                        .setResults![
                                                                            index]
                                                                        .setProductDetail!
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
                                                              .setListModel!
                                                              .setResults![
                                                                  index]
                                                              .setProductDetail!
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
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                AppColors
                                                                    .backgroundColor,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                  20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            titlePadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            title: Text(""),
                                                            content: Text(
                                                              'Do you really want to delete this item?',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .textColor,
                                                                  fontSize: 15),
                                                            ),
                                                            actions: <Widget>[
                                                              CustomButtons(
                                                                width:
                                                                    Get.width *
                                                                        .2,
                                                                height:
                                                                    Get.height *
                                                                        .05,
                                                                onTap: () {
                                                                  postData!
                                                                      .deleteSetList(
                                                                    context,
                                                                    data
                                                                        .setListModel!
                                                                        .setResults![
                                                                            index]
                                                                        .id,
                                                                    requestHeadersWithToken,
                                                                  );
                                                                },
                                                                text: 'Yes'
                                                                    .toUpperCase(),
                                                                style: Get
                                                                    .textTheme
                                                                    .button!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .textColor),
                                                              ),
                                                              CustomButtons(
                                                                width:
                                                                    Get.width *
                                                                        .2,
                                                                height:
                                                                    Get.height *
                                                                        .05,
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                text: 'Close'
                                                                    .toUpperCase(),
                                                                style: Get
                                                                    .textTheme
                                                                    .button!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .textColor),
                                                              ),
                                                            ],
                                                          );
                                                        });
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
              : const NoDataCard(
                  title: 'Your Comics are empty!',
                ),
        );
      }),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return ImageIcon(
      AssetImage('assets/media/icon/logo v.png'),
      color: Color(0xFF3A5A98),
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
