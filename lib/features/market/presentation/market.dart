import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/brand_list.dart';
import 'package:ketemaa/features/market/presentation/collectibles_search_page.dart';
import 'package:ketemaa/features/market/presentation/comic_search_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import '../Components/category_card.dart';
import '../Components/collectibles_item_card.dart';
import '../Components/commics_item_card.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  GetData? getData;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    print(prefs?.getInt('mode'));
    print("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*");
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getCollectibles();
    //getData!.getComics();
    super.initState();
  }

  var passValue = "";
  int? currentIndex = 1;
  bool? collectibleSelected = true;
  bool? comicSelected = false;
  bool? brandSelected = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        minimum: EdgeInsets.only(top: Get.height * 0.0209),
        child: Consumer<GetData>(builder: (context, data, child) {
          return Padding(
            padding: EdgeInsets.only(top: AppDimension.padding_8),
            child: Stack(
              children: [
                AppSpaces.spaces_height_20,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ///Search Bar
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * .025,
                        right: Get.width * .025,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          //gradient: gradient,
                          border: Border.all(
                            color: AppColors.textBoxBgColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                filterOn = false;
                              });
                              data.searchCollectiblesModel = null;
                              data.searchComicsModel = null;
                              currentIndex == 1
                                  ? Get.to(() => const SearchCollectiblePage())
                                  : (currentIndex == 2
                                      ? Get.to(() => const SearchComicsPage())
                                      : null);
                            },
                            focusColor: AppColors.backgroundColor,
                            child: SizedBox(
                              width: Get.width * .8,
                              child: Padding(
                                padding: EdgeInsets.all(AppDimension.padding_8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    AppSpaces.spaces_width_10,
                                    Text(
                                      'Search',
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        color: AppColors.grey,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          brandSelected == false
                              ? PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: AppColors.backgroundColor,
                                  offset: Offset(0,40),

                                  icon: Icon(
                                    Icons.filter_list,
                                    color: AppColors.grey,
                                    size: 30,
                                  ),
                                  onSelected: (value) {
                                    filterOn = true;
                                    if (value == 1) {
                                      passValue = 'Common';
                                    } else if (value == 2) {
                                      passValue = 'Uncommon';
                                    } else if (value == 3) {
                                      passValue = 'Rare';
                                    } else if (value == 4) {
                                      passValue = 'Ultra Rare';
                                    } else if (value == 5) {
                                      passValue = 'Secret Rare';
                                    }
                                    data.searchCollectiblesModel = null;
                                    currentIndex == 1
                                        ? Get.to(
                                            () => const SearchCollectiblePage(),
                                            arguments: [passValue])
                                        : (currentIndex == 2
                                            ? Get.to(
                                                () => const SearchComicsPage(),
                                                arguments: [passValue])
                                            : null);
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        'Common',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Text(
                                        'Uncommon',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: Text(
                                        'Rare',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 4,
                                      child: Text(
                                        'Ultra Rare',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 5,
                                      child: Text(
                                        'Secret Rare',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container()
                        ]),
                      ),
                    ),

                    ///Tab
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppDimension.padding_8,
                          right: AppDimension.padding_8,
                          top: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  currentIndex = 1;
                                  setState(() {
                                    collectibleSelected = true;
                                    comicSelected = false;
                                    brandSelected = false;
                                  });
                                },
                                child: CategoryCard(
                                  name: 'Collectibles',
                                  gradient: collectibleSelected == true
                                      ? AppColors.purpleGradient
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xff272E49),
                                            Color(0xff272E49),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  currentIndex = 2;
                                  setState(() {
                                    comicSelected = true;
                                    brandSelected = false;
                                    collectibleSelected = false;
                                  });
                                },
                                child: CategoryCard(
                                  name: 'Comics',
                                  gradient: comicSelected == true
                                      ? AppColors.purpleGradient
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xff272E49),
                                            Color(0xff272E49),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                          /*Expanded(
                            child: InkWell(
                              onTap: () {
                                currentIndex = 3;
                                setState(() {
                                  brandSelected = true;
                                  collectibleSelected = false;
                                  comicSelected = false;
                                });
                              },
                              child: CategoryCard(
                                name: 'Brand',
                                gradient: brandSelected == true
                                    ? AppColors.purpleGradient
                                    : const LinearGradient(
                                        colors: [
                                          Color(0xff272E49),
                                          Color(0xff272E49),
                                        ],
                                      ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),

                    ///Body
                    Container(
                        child: collectibleSelected == true
                            ? const CollectiblesItemCard()
                            : const ComicsItemCard()),

                    /* (comicSelected == true
                              ? const ComicsItemCard()
                              : const BrandList()*/
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
