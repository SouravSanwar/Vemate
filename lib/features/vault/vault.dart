import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/CheckInternet/check_internet.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/dropdown.dart';
import 'package:ketemaa/features/vault/vaule_collectibles_card.dart';
import 'package:ketemaa/features/vault/vault_comics_card.dart';
import 'package:ketemaa/features/vault/Wishlist/my_wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utilities/shimmer/loading.dart';
import 'Component/no_data_card.dart';
import 'mysets_card.dart';
import 'Wishlist/mywishlist_card.dart';

class Vault extends StatefulWidget {
  const Vault({Key? key}) : super(key: key);

  @override
  State<Vault> createState() => _VaultState();
}

class _VaultState extends State<Vault> {
  double scrnHeight = Get.height;
  double scrnWidth = Get.width;

  GetData? getData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getSetList();
    getData!.getWishList();

    getData!.getVaultStats(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.vaultStatsModel != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: Get.width,
                      height: Get.height * .268,
                      decoration: BoxDecoration(
                        gradient: AppColors.cardGradient,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(40.0)),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: Get.width * .03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(children: [
                              Text(
                                "My Vault",
                                textAlign: TextAlign.start,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.sp),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              "Vault Value",
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: Text(""
                                                /*"MCP",
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),*/
                                                ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: Get.height * .03,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient:
                                                    AppColors.purpleGradient,
                                                // set border width
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ), // set rounded corner radius
                                              ),
                                              child: Text(
                                                '\$${data.vaultStatsModel!.totalPriceChange != null ? data.vaultStatsModel!.totalPriceChange!.toStringAsFixed(2) : ""}',
                                                textAlign: TextAlign.start,
                                                style: Get.textTheme.bodyText2!
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              '\$' +
                                                  data.vaultStatsModel!
                                                      .totalVaultValue!
                                                      .toStringAsFixed(2),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: Text(""
                                                /* '\$' +
                                                  data.vaultStatsModel!.mcp!
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),*/
                                                ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                data.vaultStatsModel!.sign! ==
                                                        'decrease'
                                                    ? const RotationTransition(
                                                        turns:
                                                            AlwaysStoppedAnimation(
                                                                45 / 360),
                                                        child: Icon(
                                                          Icons.arrow_downward,
                                                          size: 18,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    : const RotationTransition(
                                                        turns:
                                                            AlwaysStoppedAnimation(
                                                                45 / 360),
                                                        child: Icon(
                                                          Icons.arrow_upward,
                                                          size: 18,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                Text(
                                                  data.vaultStatsModel!
                                                              .totalPercentChange! <
                                                          0.0
                                                      ? data.vaultStatsModel!
                                                          .totalPercentChange!
                                                          .toStringAsFixed(2)
                                                      : data.vaultStatsModel!
                                                              .totalPercentChange!
                                                              .toStringAsFixed(
                                                                  2) +
                                                          "%",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color:
                                                          data.vaultStatsModel!
                                                                      .sign! ==
                                                                  'decrease'
                                                              ? Colors.red
                                                              : Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp),
                                                ),
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
                          SizedBox(
                            height: Get.height * .11,
                            child: SfCartesianChart(
                              margin: EdgeInsets.zero,
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                isVisible: false,
                                majorGridLines: const MajorGridLines(width: 0),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.hide,
                                labelRotation: 270,
                                labelAlignment: LabelAlignment.start,
                                maximumLabels: 7,
                              ),
                              primaryYAxis: CategoryAxis(
                                isVisible: false,
                                majorGridLines: const MajorGridLines(width: 0),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.hide,
                                labelRotation: 0,
                                labelAlignment: LabelAlignment.start,
                                maximumLabels: 10,
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <
                                  ChartSeries<VaultStatsModelGraph, String>>[
                                SplineAreaSeries<VaultStatsModelGraph, String>(
                                  color:
                                      data.vaultStatsModel!.sign! == 'decrease'
                                          ? Colors.red
                                          : Colors.green,
                                  gradient: AppColors.graphGradient,
                                  dataSource: data
                                      .vaultStatsModel!.vaultStatsModelGraph!,
                                  xValueMapper:
                                      (VaultStatsModelGraph plot, _) =>
                                          plot.hour,
                                  yValueMapper:
                                      (VaultStatsModelGraph plot, _) =>
                                          plot.total,
                                  xAxisName: 'Duration',
                                  yAxisName: 'Total',
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: false,
                                    angle: 270,
                                  ),
                                  splineType: SplineType.monotonic,
                                  cardinalSplineTension: 0.3,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Get.height * .27),
                      child: ListView(
                        children: [
                          ///My Collectibles
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width *
                                    .06), //apply padding to all four sides
                            child: Text(
                              "My Collectibles",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          VaultCollectiblesCard(
                            data: data.vaultStatsModel!.collectible,
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),

                          ///My Comics
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width *
                                    .06), //apply padding to all four sides
                            child: Text(
                              "My Comics",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          VaultComicsCard(
                            data: data.vaultStatsModel!.comic,
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),

                          ///My Vault
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width *
                                    .06), //apply padding to all four sides
                            child: Text(
                              "My Vault",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          data.setListModel != null
                              ? SizedBox(
                                  width: Get.width,
                                  height: Get.height * .22,
                                  child: data.setListModel!.count! > 0
                                      ? MysetsCard(
                                          list: data.setListModel!.setResults,
                                        )
                                      : const NoDataCard(
                                          title: 'Your Vault is empty!',
                                        ),
                                )
                              : const LoadingExample(),
                          SizedBox(
                            height: Get.height * .01,
                          ),

                          ///My Wishlist
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Get.width *
                                          .06), //apply padding to all four sides
                                  child: Text(
                                    "My Wishlist",
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const WishListPage());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width *
                                            .06), //apply padding to all four sides
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            width: Get.width,
                            height: Get.height * .22,
                            child: data.wishListModel!.results!.isNotEmpty
                                ? const MywishlistCard()
                                : const NoDataCard(
                                    title: 'Your Wishlist is empty!',
                                  ),
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: Get.height * .235,
                      left: Get.width * .62,
                      right: 0.0,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '24H',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                        width: Get.width * .125,
                        height: Get.width * .125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.purpleGradient,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const LoadingExample();
      }),
    );
  }
}
