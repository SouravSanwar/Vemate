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
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/MySets/individual_list_structure.dart';
import 'package:ketemaa/main.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/MySetsModel.dart';

class MySetsIndividualList extends StatefulWidget {
  int? productId;
  String? productName;

  MySetsIndividualList({Key? key, this.productId, this.productName}) : super(key: key);

  @override
  _MySetsIndividualListState createState() => _MySetsIndividualListState();
}

class _MySetsIndividualListState extends State<MySetsIndividualList> {
  double? _height, _width;
  bool? large;
  bool? medium;
  int page = 1;
  RefreshController refreshController = RefreshController(initialRefresh: false);

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
    getData!.getMySets1(0, widget.productId!, true, graph_data: true);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));
    await getData!.getMySets(0, true, graph_data: true).whenComplete(() => Navigator.of(context).pop());
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return Consumer<GetData>(builder: (content, data, child) {
      return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 1.0,
              titleSpacing: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              backgroundColor: AppColors.backgroundColor,
              title: data.mySetsModel != null
                  ? Container(
                      padding: const EdgeInsets.only(right: 75),
                      height: 25,
                      child: widget.productName!.length < 26
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
                              child: Text(
                                widget.productName!.toString(),
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    //fontFamily: 'Inter',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Marquee(
                              text: widget.productName!,
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  //fontFamily: 'Inter',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 200.0,
                              velocity: 50.0,
                              startPadding: 0.0,
                              showFadingOnlyWhenScrolling: false,
                              accelerationCurve: Curves.easeInBack,
                              pauseAfterRound: const Duration(seconds: 2),
                              //  decelerationDuration: Duration(microseconds: 100),
                              // decelerationCurve: Curves.easeOut,
                              // numberOfRounds: 1,
                            ),
                    )
                  : Container(),
              actions: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: AppColors.priceInfoColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          elevation: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'FP - ',
                                    ),
                                    Text(
                                      'Current Floor Price of the NFT',
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                AppSpaces.spaces_height_5,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'AP - ',
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Acquisition price of the NFT - this is the amount you spent to purchase the'
                                        ' NFT and it will be used as a reference point for the charts.'
                                        ' Please insert your acquisition price there.',
                                        maxLines: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                AppSpaces.spaces_height_5,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'PC - ',
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Price change - This displays the price change in the last 24 hours in % and \$',
                                        maxLines: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.info_outline),
                ),
                AppSpaces.spaces_width_5,
              ],
            ),
            body: Container(
              height: Get.height * .9,
              width: Get.width,
              padding: const EdgeInsets.only(bottom: 10),
              child: data.mySetsModel != null
                  ? (data.mySetsModel!.results!.isNotEmpty
                      ? ListView.builder(
                          itemCount: data.mySetsModel!.results!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.graphCard,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: SwipeActionCell(
                                  backgroundColor: Colors.transparent,
                                  key: ObjectKey(data.mySetsModel!.results![index]),
                                  trailingActions: <SwipeAction>[
                                    SwipeAction(
                                        title: "Delete",
                                        style: const TextStyle(fontSize: 14),
                                        performsFirstActionWithFullSwipe: true,
                                        icon: Icon(
                                          Icons.delete,
                                          color: AppColors.white,
                                        ),
                                        onTap: (CompletionHandler handler) async {
                                          var body = {};
                                          postData!
                                              .deleteMAO(
                                                data.mySetsModel!.results![index].id,
                                                context,
                                                body,
                                                requestHeadersWithToken,
                                              )
                                              .whenComplete(() => getData!.getMySets1(0, widget.productId!, true))
                                              .whenComplete(() => Navigator.of(context).pop());
                                        },
                                        color: Colors.red),
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      prefs!.setString('edition', data.mySetsModel!.results![index].edition.toString());
                                      prefs!.setString('ap', data.mySetsModel!.results![index].ap.toString());
                                      prefs!.setString('ad', data.mySetsModel!.results![index].ad.toString());
                                      data.mySetsModel!.results![index].productDetail!.type == 0
                                          ? Get.to(
                                              () => CollectibleDetails(
                                                productType: data.mySetsModel!.results![index].productDetail!.type!,
                                                productId: data.mySetsModel!.results![index].productDetail!.id!,
                                                fromVault: true,

                                                ///Need to mint Id for upgrade
                                                mintId: int.parse(data.mySetsModel!.results![index].id.toString()),
                                                edition: data.mySetsModel!.results![index].mintNumber.toString(),
                                                ap: data.mySetsModel!.results![index].ap,
                                                ad: data.mySetsModel!.results![index].ad ??
                                                    DateTime.now().toIso8601String(),
                                                index: index,
                                              ),
                                            )
                                          : Get.to(
                                              () => ComicDetails(
                                                productId: data.mySetsModel!.results![index].productDetail!.id!,
                                                fromVault: true,
                                                productType: data.mySetsModel!.results![index].productDetail!.type,
                                                mintId: int.parse(data.mySetsModel!.results![index].id.toString()),
                                                edition: data.mySetsModel!.results![index].mintNumber.toString(),
                                                ap: data.mySetsModel!.results![index].ap,
                                                ad: data.mySetsModel!.results![index].ad ??
                                                    DateTime.now().toIso8601String(),
                                                index: index,
                                              ),
                                            );
                                    },
                                    child: IndividualListStructure(
                                      checkImage: data.mySetsModel!.results![index].productDetail!.image == null
                                          ? ""
                                          : data.mySetsModel!.results![index].productDetail!.image.toString(),
                                      name: data.mySetsModel!.results![index].productDetail!.name == null
                                          ? ""
                                          : data.mySetsModel!.results![index].productDetail!.name!,
                                      lowResUrl: data.mySetsModel!.results![index].productDetail!.image != null
                                          ? data.mySetsModel!.results![index].productDetail!.image!.lowResUrl!
                                          : "",
                                      scrappedImage: data.mySetsModel!.results![index].productDetail!.image != null
                                          ? data.mySetsModel!.results![index].productDetail!.image!.baseUrl.toString()
                                          : "",
                                      edition: data.mySetsModel!.results![index].mintNumber == null
                                          ? ""
                                          : data.mySetsModel!.results![index].mintNumber.toString(),
                                      brand: data.mySetsModel!.results![index].productDetail!.brand == null
                                          ? ""
                                          : data.mySetsModel!.results![index].productDetail!.brand.toString(),
                                      rarity: data.mySetsModel!.results![index].productDetail!.rarity == null
                                          ? ""
                                          : data.mySetsModel!.results![index].productDetail!.rarity!,
                                      floorPrice: data.mySetsModel!.results![index].productDetail!.floorPrice == null
                                          ? ""
                                          : data.mySetsModel!.results![index].productDetail!.floorPrice!,
                                      series: data.mySetsModel!.results![index].statsDetail!.graph != null
                                          ? <ChartSeries<Graph, String>>[
                                              LineSeries<Graph, String>(
                                                color:
                                                    data.mySetsModel!.results![index].statsDetail!.sign! == 'decrease'
                                                        ? Colors.red
                                                        : Colors.green,
                                                dataSource: data.mySetsModel!.results![index].statsDetail!.graph!,
                                                xValueMapper: (Graph plot, _) => plot.date,
                                                yValueMapper: (Graph plot, _) => plot.floorPrice,
                                                xAxisName: 'Duration',
                                                yAxisName: 'Total',
                                              )
                                            ]
                                          : null,
                                      pcpPercent: data.mySetsModel!.results![index].statsDetail == null
                                          ? 0.0
                                          : data.mySetsModel!.results![index].statsDetail!.changePercent!,
                                      pcpSign: data.mySetsModel!.results![index].statsDetail == null
                                          ? ""
                                          : data.mySetsModel!.results![index].statsDetail!.sign!,
                                      changePrice: data.mySetsModel!.results![index].statsDetail == null
                                          ? 0.0
                                          : data.mySetsModel!.results![index].statsDetail!.priceChange!,
                                      ap: data.mySetsModel!.results![index].ap == null
                                          ? ""
                                          : data.mySetsModel!.results![index].ap.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : const NoDataCard(
                          title: 'List is empty!',
                        ))
                  : const ColorLoader(),
            )),
      );
    });
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
