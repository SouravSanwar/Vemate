import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/components/name_row.dart';
import 'package:ketemaa/features/profile/presentation/profile.dart';
import 'package:provider/provider.dart';

import 'package:ketemaa/features/home/components/home_vault_card.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';
import 'package:provider/provider.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/shimmer/loading.dart';
import '../../market/Components/category_card.dart';
import '../components/image_slider.dart';
import '../components/vault_new_item_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = [
    "assets/media/slider/11.jpg",
    "assets/media/slider/12.jpg",
    "assets/media/slider/13.jpg",
  ];
  int? currentIndex = 1;
  bool? allSelected = true;
  bool? dropSelected = false;
  bool? setsSelected = false;
  bool? priceSelected = false;

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
    return Scaffold(
        backgroundColor: Color(0xff272E49),
        body: Consumer<GetData>(
          builder: (context, data, child) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                    //shrinkWrap: true,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Get.height * .06),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 5.0),
                                        child: SizedBox(
                                          height: Get.height * .04,
                                          width: Get.height * .04,
                                          child: Image.asset(
                                            'assets/media/icon/logo v.png',
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                    Text(
                                      "Hi, Andre",
                                      style: Get.textTheme.headline1!.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Container(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              .06,
                                      backgroundColor: Color(0xff272E49),
                                      backgroundImage: null,
                                      child: Shader(
                                        icon: const Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      ),

                                      // Icon(Icons.person,size: 100,)
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.greyWhite,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: AppDimension.padding_8,
                                right: AppDimension.padding_8,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: Get.height * .08,
                                      padding: EdgeInsets.all(10),
                                      child: TextField(
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xff2F3758),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: Color(0xff455181),
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff2F3758)),
                                              //  when the TextFormField in focused
                                            ),
                                            prefixIcon: const InkWell(
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                _openFilterDialog();
                                              },
                                              child: const Icon(
                                                Icons.filter_list,
                                                color: Color(0xff926FDF),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.all(10.0),
                                            hintText: 'Search ',
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                        onChanged: (string) {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: Get.height * .2),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              child: Text(
                                'News',
                                style: Get.textTheme.headline1!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            AppSpaces.spaces_height_10,
                            ImageSlider(),
                            AppSpaces.spaces_height_10,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 0, left: 15, right: 15),
                              child: Text(
                                'My Vault',
                                style: Get.textTheme.headline1!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            HomeVaultCard(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 0, left: 15, right: 15),
                              child: Text(
                                'Newest',
                                style: Get.textTheme.headline1!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      currentIndex = 1;
                                      setState(() {
                                        allSelected = true;
                                        dropSelected = false;
                                        setsSelected = false;
                                        priceSelected = false;
                                      });
                                    },
                                    child: CategoryCard(
                                      name: 'All',
                                      gradient: allSelected == true
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
                                        allSelected = false;
                                        dropSelected = true;
                                        setsSelected = false;
                                        priceSelected = false;
                                      });
                                    },
                                    child: CategoryCard(
                                      name: 'Drop',
                                      gradient: dropSelected == true
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
                                        allSelected = false;
                                        dropSelected = false;
                                        setsSelected = true;
                                        priceSelected = false;
                                      });
                                    },
                                    child: CategoryCard(
                                      name: 'Sets',
                                      gradient: setsSelected == true
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
                                      currentIndex = 4;
                                      setState(() {
                                        allSelected = false;
                                        dropSelected = false;
                                        setsSelected = false;
                                        priceSelected = true;
                                      });
                                    },
                                    child: CategoryCard(
                                      name: 'Price',
                                      gradient: priceSelected == true
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
                            Container(
                                height: Get.height * .22,
                                child: SizedBox(
                                  width: Get.width,
                                  child: data.collectiblesModel != null
                                      ? VaultNewItemCard(
                                          list: data.collectiblesModel!.results,
                                        )
                                      : LoadingExample(),
                                )),
                            SizedBox(
                              height: Get.height * .02,
                            ),
                          ],
                        ),
                      ),
                    ]));
          },
        ));
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
