import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/market_card_shimmer.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/app_assets/app_assets.dart';
import '../../profile/widgets/custom_text_field.dart';
import '../Components/category_card.dart';
import '../Components/collectibles_item_card.dart';
import '../Components/commics_item_card.dart';
import '../../home/components/name_row.dart';

class Market extends StatefulWidget {
  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  var fetchData;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    fetchData = Provider.of<GetData>(context, listen: false);

    fetchData.getCollectibles();
    fetchData.getComics();
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
      themeData: FilterListThemeData(context),
      listData: rarityList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
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
      /* appBar: AppBar(
        title: Text("Market"),
        backgroundColor: Colors.green,
        actions:<Widget> [
          AnimSearchBar(
            width: MediaQuery.of(context).size.width *.95,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
            rtl: true,
            animationDurationInMilli: 500,
            color: Colors.green,
          ),


        ],
      ),*/
      backgroundColor: Color(0xff272E49),
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(top: AppDimension.padding_16),
          child: Stack(
            //shrinkWrap: true,
            children: [
              AppSpaces.spaces_height_20,
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppDimension.padding_8,
                      right: AppDimension.padding_8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff2F3758),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Color(0xff455181),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff2F3758)),
                                    //  when the TextFormField in focused
                                  ),
                                  prefixIcon: InkWell(
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    child: Icon(
                                      Icons.filter_list,
                                      color: Color(0xff926FDF),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Search ',
                                  hintStyle: TextStyle(color: Colors.grey)),
                              onChanged: (string) {},
                            ),
                          ),
                        ),
                        /*  Expanded(
                          flex: 1,
                        child: GestureDetector(
                              onTap: (){
                                _openFilterDialog();
                              },

                            child: Image.asset(
                              'assets/media/icon/filter.png',
                              height: 25.0,
                              width: 15.0,
                              color: Colors.white,
                            ),
                        ),
                        ),*/
                      ],
                    ),
                  ),
                  AppSpaces.spaces_height_5,
                Padding(
                  padding:EdgeInsets.only(
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
                            gradient: comicSelected== true
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
                            currentIndex = 3;
                            setState(() {
                              brandSelected = true;
                              collectibleSelected = false;
                              comicSelected = false;
                            });
                          },
                          child: CategoryCard(
                              name: 'Brand',
                            gradient: brandSelected== true
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
                    ],
                  ),
                ),
                  AppSpaces.spaces_height_10,
                  Container(
                    child: collectibleSelected == true
                        ? SizedBox(
                            height: Get.height,
                            child: data.collectiblesModel != null
                                ? CollectiblesItemCard(
                                    list: data.collectiblesModel!.collectibles!
                                        .results,
                                  )
                                : const MarketCardShimmer(),
                          )
                        : (comicSelected == true
                            ? SizedBox(
                                height: Get.height,
                                child: data.comicsModel != null
                                    ? CommicsItemCard(
                                        list: data.comicsModel!.comics!.results,
                                        image: AppAsset.main_auth_image_3,
                                      )
                                    : const MarketCardShimmer(),
                              )
                            : Center(
                                child: Text('Brand'),
                              )),
                  )
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


