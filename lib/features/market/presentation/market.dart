import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
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
  int? currentIndex = 1;

  String collectibleRarity = "";
  String comicRarity = "";
  String? comicSearchText = '';
  String? collectibleSearchText = '';
  String? rarityValue;

  bool? collectibleSelected = true;
  bool? comicSelected = false;
  bool? brandSelected = false;
  bool? collectibleFilterOn = false;
  bool? comicFilterOn = false;
  bool? collectibleEnable = false;
  bool? comicEnable = false;

  int? collcetableMintValue;

  TextEditingController searchCollectible = TextEditingController();
  TextEditingController searchComic = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getCollectibles(
      keyword: collectibleSearchText,
      rarity: collectibleRarity,
    );
    getData!.getComics(
      keyword: comicSearchText,
      rarity: comicRarity,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(.1),
        automaticallyImplyLeading: false,
        title: Row(children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: currentIndex == 1
                  ? TextFormField(
                      controller: searchCollectible,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: collectibleSearchText!.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    searchCollectible.clear();
                                    collectibleSearchText = '';
                                    getData!.collectiblesModel = null;
                                    if (collectibleSearchText!.isNotEmpty) {
                                      getData!.getCollectibles(
                                        keyword: collectibleSearchText,
                                        rarity: collectibleRarity,
                                      );
                                    }
                                  });
                                },
                                child: const Icon(Icons.close),
                              )
                            : null,
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 13, right: 15),
                        hintText: "Search Collectible",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      onChanged: (text) {
                        text = searchCollectible.text;
                        setState(() {
                          collectibleSearchText = searchCollectible.text;

                          if (collectibleSearchText!.length > 2 ||
                              collectibleSearchText!.isEmpty) {
                            getData!.collectiblesModel = null;
                            getData!.getCollectibles(
                              keyword: collectibleSearchText,
                              rarity: collectibleRarity,
                              mint_number: 0,
                            );
                          }
                        });
                      },
                      onSaved: (text) {
                        /*text = searchController.text;
                            searchText = searchController.text != ''
                                ? '=${searchController.text}'
                                : '';
                            setState(() {
                              getData!.collectiblesModel = null;
                              getData!.getCollectibles(
                                  keyword: searchText);
                            });*/
                      },
                      autofocus: false,
                    )
                  : TextFormField(
                      controller: searchComic,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: comicSearchText!.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    comicSearchText = '';
                                    searchComic.clear();
                                    getData!.comicsModel = null;
                                    getData!.getComics(
                                      keyword: comicSearchText,
                                      rarity: comicRarity,
                                    );
                                  });
                                },
                                child: const Icon(Icons.close),
                              )
                            : null,
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 13, right: 15),
                        hintText: "Search Comics",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      onChanged: (text) {
                        text = searchComic.text;
                        setState(() {
                          comicSearchText = searchComic.text;

                          printInfo(info: 'Search Text: ' + searchComic.text);
                          if (comicSearchText!.length > 2) {
                            getData!.comicsModel = null;
                            getData!.getComics(
                              keyword: comicSearchText,
                              rarity: comicRarity,
                            );
                          }
                        });
                      },
                      onSaved: (text) {
                        /*text = searchComic.text;
                              searchText = searchComic.text != ''
                                  ? '=${searchComic.text}'
                                  : '';
                              setState(() {
                                getData!.comicsModel = null;
                                getData!.getComics(
                                    keyword: searchText);
                              });*/
                      },
                      autofocus: false,
                    ),
            ),
          ),
          brandSelected == false
              ? (currentIndex == 1
                  ? PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: AppColors.backgroundColor,
                      offset: const Offset(0, 40),
                      icon: Icon(
                        Icons.filter_list,
                        color: collectibleFilterOn == false
                            ? AppColors.grey
                            : AppColors.primaryColor,
                        size: 30,
                      ),
                      onSelected: (value) {
                        setState(() {
                          if (value == 1) {
                            collectibleRarity = 'Common';
                            collectibleFilterOn = true;
                          } else if (value == 2) {
                            collectibleRarity = 'Uncommon';
                            collectibleFilterOn = true;
                          } else if (value == 3) {
                            collectibleRarity = 'Rare';
                            collectibleFilterOn = true;
                          } else if (value == 4) {
                            collectibleRarity = 'Ultra Rare';
                            collectibleFilterOn = true;
                          } else if (value == 5) {
                            collectibleRarity = 'Secret Rare';
                            collectibleFilterOn = true;
                          } else if (value == 7) {
                            collcetableMintValue=0;
                            collectibleFilterOn = true;
                          } else if (value == 8) {
                            collcetableMintValue=1;
                            collectibleFilterOn = true;
                          } else {
                            collectibleRarity = '';
                            collectibleFilterOn = false;
                          }
                        });

                        if (collectibleRarity.isNotEmpty) {
                          getData!.collectiblesModel = null;
                          getData!.getCollectibles(
                              keyword: collectibleSearchText,
                              rarity: collectibleRarity);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 6,
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: collectibleRarity == ''
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            'Common',
                            style: TextStyle(
                              color: collectibleRarity == 'Common'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Uncommon',
                            style: TextStyle(
                              color: collectibleRarity == 'Uncommon'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text(
                            'Rare',
                            style: TextStyle(
                              color: collectibleRarity == 'Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: Text(
                            'Ultra Rare',
                            style: TextStyle(
                              color: collectibleRarity == 'Ultra Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 5,
                          child: Text(
                            'Secret Rare',
                            style: TextStyle(
                              color: collectibleRarity == 'Secret Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 7,
                          child: Text(
                            'Low Mint A',
                            style: TextStyle(
                              color: collectibleRarity == 'Low Mint A'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 8,
                          child: Text(
                            'Low Mint D',
                            style: TextStyle(
                              color: collectibleRarity == 'Low Mint D'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    )
                  : PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: AppColors.backgroundColor,
                      offset: const Offset(0, 40),
                      icon: Icon(
                        Icons.filter_list,
                        color: comicFilterOn == false
                            ? AppColors.grey
                            : AppColors.primaryColor,
                        size: 30,
                      ),
                      onSelected: (value) {
                        setState(() {
                          if (value == 1) {
                            comicRarity = 'Common';
                            comicFilterOn = true;
                          } else if (value == 2) {
                            comicRarity = 'Uncommon';
                            comicFilterOn = true;
                          } else if (value == 3) {
                            comicRarity = 'Rare';
                            comicFilterOn = true;
                          } else if (value == 4) {
                            comicRarity = 'Ultra Rare';
                            comicFilterOn = true;
                          } else if (value == 5) {
                            comicRarity = 'Secret Rare';
                            comicFilterOn = true;
                          } else {
                            comicRarity = '';
                            comicFilterOn = false;
                          }
                        });

                        if (comicRarity.isNotEmpty) {
                          getData!.comicsModel = null;
                          getData!.getComics(
                              keyword: comicSearchText, rarity: comicRarity);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 6,
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: comicRarity == ''
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            'Common',
                            style: TextStyle(
                              color: comicRarity == 'Common'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Uncommon',
                            style: TextStyle(
                              color: comicRarity == 'Uncommon'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text(
                            'Rare',
                            style: TextStyle(
                              color: comicRarity == 'Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: Text(
                            'Ultra Rare',
                            style: TextStyle(
                              color: comicRarity == 'Ultra Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 5,
                          child: Text(
                            'Secret Rare',
                            style: TextStyle(
                              color: comicRarity == 'Secret Rare'
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ))
              : Container(),
        ]),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
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
                    ? CollectiblesItemCard(
                        keyword: collectibleSearchText!,
                        rarity: collectibleRarity,
                      )
                    : ComicsItemCard(
                        keyword: comicSearchText!,
                        rarity: comicRarity,
                      )),

            /* (comicSelected == true
                          ? const ComicsItemCard()
                          : const BrandList()*/
          ],
        );
      }),
    );
  }
}
