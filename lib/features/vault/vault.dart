import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/vault/vaule_collectibles_card.dart';
import 'package:ketemaa/features/vault/vault_comics_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/utilities/shimmer/loading.dart';
import 'mysets_card.dart';
import 'mywishlist_card.dart';

class Vault extends StatefulWidget {
  @override
  State<Vault> createState() => _VaultState();
}

class _VaultState extends State<Vault> {
  bool _isLoaded = false;
  double scrnHeight = Get.height;
  double scrnWidth = Get.width;

  String? selectedValue;

  GetData? getData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getSetList();
    getData!.getWishList();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    double percent = 3.30;
    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: const Color(0xff272E49),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.vaultStatsModel != null?  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: Get.width,
                    height: Get.height * .22,
                    decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(40.0)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.width * .15,
                        ),
                        Row(children: [
                          SizedBox(
                            width: Get.width * .05,
                          ),
                          Text(
                            "My Vault",
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodyText2!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22),
                          ),
                        ]),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * .05,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Vault Value",
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "MCP",
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: Get.width * .15,
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.purpleGradient,
                                            // set border width
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ), // set rounded corner radius
                                          ),
                                          child: Text(
                                            '\$' +
                                                data.vaultStatsModel!
                                                    .totalPriceChange!
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * .05,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          '\$' +
                                              data.vaultStatsModel!
                                                  .totalVaultValue!
                                                  .toString(),
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\$' +
                                              data.vaultStatsModel!.mcp!
                                                  .toString(),
                                          textAlign: TextAlign.start,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (data.vaultStatsModel!
                                                    .totalPercentChange! <
                                                0.0)
                                              //toRotateIcon
                                              const RotationTransition(
                                                turns: AlwaysStoppedAnimation(
                                                    45 / 360),
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  size: 18,
                                                  color: Colors.red,
                                                ),
                                              )
                                            else
                                              const RotationTransition(
                                                turns: AlwaysStoppedAnimation(
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
                                                      .toString()
                                                  : data.vaultStatsModel!
                                                          .totalPercentChange!
                                                          .toString() +
                                                      "%",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: data.vaultStatsModel!
                                                              .totalPercentChange! <
                                                          0.0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: const EdgeInsets.only(),
                                alignment: Alignment.centerLeft,
                                height: Get.height * .05,
                                child: Container(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: Get.height * .26),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Collectibles",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    VaultCollectiblesCard(
                      data: data.vaultStatsModel!.collectible,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Comics",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    VaultComicsCard(
                      data: data.vaultStatsModel!.comic,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Vault",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.setListModel != null
                              ? MysetsCard(
                                  list: data.setListModel!.results,
                                )
                              : const LoadingExample(),
                        )),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width *
                              .06), //apply padding to all four sides
                      child: const Text(
                        "My Wishlist",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.wishListModel != null
                              ? MywishlistCard(
                                  list: data.wishListModel!.results,
                                )
                              : const LoadingExample(),
                        )),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Get.height * .188,
                left: Get.width * .62,
                right: 0.0,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child:  const Text(
                        '24H',
                        style: TextStyle(
                          fontSize: 15,
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
        ): LoadingExample();
      }),
    );
  }
}
