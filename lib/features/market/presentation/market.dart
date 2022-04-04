import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectibles_search_page.dart';
import 'package:ketemaa/features/market/presentation/comic_search_page.dart';
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
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getCollectibles();
    //getData!.getComics();
    super.initState();
  }

  int? currentIndex = 1;
  bool? collectibleSelected = true;
  bool? comicSelected = false;
  bool? brandSelected = false;
  TextEditingController searchController = TextEditingController();

  //For Filter
  List<Rarity>? selectedUserList = [];

  void _openFilterDialog() async {
    await FilterListDialog.display<Rarity>(
      context,
      hideSelectedTextCount: true,
      listData: rarityList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      backgroundColor: Colors.black45,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  //For Filter

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(top: AppDimension.padding_8),
          child: Stack(
            children: [
              AppSpaces.spaces_height_20,
              ListView(
                children: [
                  ///Search Bar
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppDimension.padding_8,
                      right: AppDimension.padding_8,
                    ),
                    child: InkWell(
                      onTap: () {
                        currentIndex == 1
                            ? Get.to(() => const SearchCollectiblePage())
                            : (currentIndex == 2
                                ? Get.to(() => const SearchComicsPage())
                                : null);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //gradient: gradient,
                          border: Border.all(
                            color: AppColors.lightBackgroundColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppDimension.padding_8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              AppSpaces.spaces_width_10,
                              Text(
                                'Search',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyText1!
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /*child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            //height: Get.height*.08,
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightBackgroundColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xff455181),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor),
                                    //  when the TextFormField in focused
                                  ),
                                  prefixIcon: InkWell(
                                    onTap: () {
                                      currentIndex == 1
                                          ? const SearchCollectiblePage()
                                          : null;
                                    },
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _openFilterDialog();
                                    },
                                    child: Icon(
                                      Icons.filter_list,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(5.0),
                                  hintText: 'Search ',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onChanged: (string) {},
                            ),
                          ),
                        ),
                      ],
                    ),*/
                  ),

                  ///Tab
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppDimension.padding_8,
                      right: AppDimension.padding_8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                        Expanded(
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
                        : (comicSelected == true
                            ? const ComicsItemCard()
                            : Container()),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Rarity {
  final String? name;

  Rarity({this.name});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<Rarity> rarityList = [
  Rarity(name: "Rare"),
  Rarity(name: "Ultra-Rare"),
  Rarity(name: "Common"),
  Rarity(name: "Uncommon"),
];
