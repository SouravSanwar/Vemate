import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/CheckInternet/check_internet.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/My%20Vault/my_sets_lists.dart';
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
  GetData? getData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
   // getData!.getVaultStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.vaultStatsModel != null && data.setListModel != null && data.wishListModel != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: Get.width,
                      height: Get.height * .268,
                      decoration: BoxDecoration(
                        color: AppColors.graphCard,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(25.0)),
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
                                    fontFamily: 'Inter',
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
                                                      fontFamily: 'Inter',
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
                                                        //fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * .005,
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
                                                      //fontFamily: 'Inter',
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
                                                      fontFamily: 'Inter',
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
                                plotOffset: -8,
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
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "My Collectibles",
                              style: Get.textTheme.headline2!.copyWith(
                                  color: AppColors.textColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          VaultCollectiblesCard(
                            data: data.vaultStatsModel!.collectible,
                          ),

                          ///My Comics
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "My Comics",
                              style: Get.textTheme.headline2!.copyWith(
                                  color: AppColors.textColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          VaultComicsCard(
                            data: data.vaultStatsModel!.comic,
                          ),

                          ///My Vault
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  top: Get.height * .0334,
                                  bottom: Get.height * .0167,
                                ),
                                //apply padding to all four sides
                                child: Text(
                                  "My Vault",
                                  style: Get.textTheme.headline2!.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SetListPage());
                                },
                                child: data.setListModel!.setResults!.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: Get.width * .06,
                                            top: Get.height * .0334,
                                            bottom: Get.height * .0167),
                                        child: Text(
                                          "See All",
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              //fontFamily: 'Inter',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          data.setListModel != null
                              ? SizedBox(
                                  width: Get.width,
                                  height: Get.height * .22,
                                  child: data.setListModel!.count! > 0
                                      ? const MysetsCard()
                                      : const NoDataCard(
                                          title: 'Your Vault is empty!',
                                        ),
                                )
                              : const LoadingExample(),

                          ///My Wishlist
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15,
                                      top: Get.height * .0334,
                                      bottom: Get.height * .0167),
                                  child: Text(
                                    "My Wishlist",
                                    style: Get.textTheme.headline2!.copyWith(
                                        color: AppColors.textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const WishListPage());
                                  },
                                  child: data.wishListModel!.results!.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              right: Get.width * .06,
                                              top: Get.height * .0334,
                                              bottom: Get.height * .0167),
                                          child: Text(
                                            "See All",
                                            style: TextStyle(
                                                color: AppColors.textColor,
                                                //fontFamily: 'Inter',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Container(),
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
                        child:  DropDown(AppColors.backgroundColor,false),
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
            : ColorLoader();
      }),
    );
  }
}
