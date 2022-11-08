import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/My%20Vault/my_sets_lists.dart';
import 'package:ketemaa/features/vault/VaultCards/one_year_card.dart';
import 'package:ketemaa/features/vault/VaultCards/seven_day_card.dart';
import 'package:ketemaa/features/vault/VaultCards/sixty_day_card.dart';
import 'package:ketemaa/features/vault/VaultCards/thirty_day_card.dart';
import 'package:ketemaa/features/vault/VaultCollectibleCards/vault_collectible_card_1Y.dart';
import 'package:ketemaa/features/vault/VaultComicCards/vault_comic_card_1Y.dart';
import 'package:ketemaa/features/vault/VaultComicCards/vault_comic_card_30D.dart';
import 'package:ketemaa/features/vault/VaultComicCards/vault_comic_card_60D.dart';
import 'package:ketemaa/features/vault/VaultComicCards/vault_comic_card_7D.dart';
import 'package:ketemaa/features/vault/VaultCollectibleCards/vaule_collectibles_card.dart';
import 'package:ketemaa/features/vault/VaultCards/vault_card.dart';
import 'package:ketemaa/features/vault/VaultComicCards/vault_comics_card.dart';
import 'package:ketemaa/features/vault/Wishlist/my_wishlist_page.dart';
import 'package:provider/provider.dart';
import '../../../../core/utilities/shimmer/loading.dart';
import 'Component/no_data_card.dart';
import 'VaultCollectibleCards/vault_collectible_card_30D.dart';
import 'VaultCollectibleCards/vault_collectible_card_60D.dart';
import 'VaultCollectibleCards/vault_collectible_card_7D.dart';
import 'MySets/mysets_card.dart';
import 'Wishlist/mywishlist_card.dart';

class Vault extends StatefulWidget {
  const Vault({Key? key}) : super(key: key);

  @override
  State<Vault> createState() => _VaultState();
}

class _VaultState extends State<Vault> {
  GetData? getData;
  String? value = "24H";

  final items = ['24H', '7D', '30D', '60D', '1Y'];
  int vaultSelectDropDownIndex = 0;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
    getData!.getVaultStats();
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
                      height: Get.height * .275,
                      decoration: BoxDecoration(
                        color: AppColors.graphCard,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25.0)),
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
                          (vaultSelectDropDownIndex == 0)
                              ? (const VaultCard())
                              : (vaultSelectDropDownIndex == 1
                                  ? const VaultCard7D()
                                  : vaultSelectDropDownIndex == 2
                                      ? const VaultCard30D()
                                      : vaultSelectDropDownIndex == 3
                                          ? const VaultCard60D()
                                          : const VaultCard1Y()),
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
                                  color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                            ),
                          ),
                          vaultSelectDropDownIndex == 0
                              ? VaultCollectiblesCard(data: data.vaultStatsModel!.collectible)
                              : vaultSelectDropDownIndex == 1
                                  ? VaultCollectiblesCard7D(
                                      data: data.vaultStatsModel7D!.collectible,
                                    )
                                  : vaultSelectDropDownIndex == 2
                                      ? VaultCollectiblesCard30D(
                                          data: data.vaultStatsModel30D!.collectible,
                                        )
                                      : vaultSelectDropDownIndex == 3
                                          ? VaultCollectiblesCard60D(
                                              data: data.vaultStatsModel60D!.collectible,
                                            )
                                          : VaultCollectiblesCard1Y(
                                              data: data.vaultStatsModel1Y!.collectible,
                                            ),

                          ///My Comics
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "My Comics",
                              style: Get.textTheme.headline2!.copyWith(
                                color: AppColors.textColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          vaultSelectDropDownIndex == 0
                              ? VaultComicsCard(
                                  data: data.vaultStatsModel!.comic,
                                )
                              : vaultSelectDropDownIndex == 1
                                  ? VaultComicsCard7D(
                                      data: data.vaultStatsModel7D!.comic,
                                    )
                                  : vaultSelectDropDownIndex == 2
                                      ? VaultComicsCard30D(
                                          data: data.vaultStatsModel30D!.comic,
                                        )
                                      : vaultSelectDropDownIndex == 3
                                          ? VaultComicsCard60D(
                                              data: data.vaultStatsModel60D!.comic,
                                            )
                                          : VaultComicsCard1Y(
                                              data: data.vaultStatsModel1Y!.comic,
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
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
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
                                  height: Get.height * .31,
                                  child: data.setListModel!.setResults!.isNotEmpty
                                      ? const MysetsCard()
                                      : const NoDataCard(
                                          title: 'Your Vault is empty!',
                                        ),
                                )
                              : const LoadingExample(),

                          ///My Wishlist
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, top: Get.height * .0334, bottom: Get.height * .0167),
                              child: Text(
                                "My Wishlist",
                                style: Get.textTheme.headline2!.copyWith(
                                    color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                              ),
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                Get.to(() => const WishListPage());
                              },
                              child: data.wishListModel!.results!.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: Get.width * .06, top: Get.height * .0334, bottom: Get.height * .0167),
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
                                ?  Align(
                              alignment: Alignment.center,
                              child: MywishlistCard(),

                            )
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
                        child: dropDown(),
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
            : const ColorLoader();
      }),
    );
  }

  Widget dropDown() {
    return DropdownButton<String>(
      value: value,
      items: items.map(buildMenuItem).toList(),
      onChanged: (value) {
        setState(() {
          this.value = value;

          value == '24H'
              ? vaultSelectDropDownIndex = 0
              : value == '7D'
                  ? vaultSelectDropDownIndex = 1
                  : value == '30D'
                      ? vaultSelectDropDownIndex = 2
                      : value == '60D'
                          ? vaultSelectDropDownIndex = 3
                          : vaultSelectDropDownIndex = 4;

          // widget.isHome == true
          //     ? getData!.getHomeVault(graphType: vaultSelectDropDownIndex)
          //     : getData!.getVaultStats(graphType: vaultSelectDropDownIndex);
          printInfo(info: 'Value value: ' + value.toString());
        }); //get value when changed
      },
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 10,
      ),

      iconEnabledColor: Colors.white,
      //Icon color
      style: TextStyle(
          //te
          color: Colors.white,
          fontFamily: 'Inter', //Font color
          fontSize: 20.sp //font size on dropdown button
          ),
      dropdownColor: const Color(0xffA984E5),
      underline: Container(),
      //dropdown background color
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));
}
