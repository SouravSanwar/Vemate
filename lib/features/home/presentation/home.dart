import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/profile/presentation/profile.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:ketemaa/core/models/NewsModel.dart';

import 'package:ketemaa/features/home/components/home_vault_card.dart';


import '../../../core/Provider/getData.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/shimmer/loading.dart';
import '../components/image_slider.dart';
import '../components/vault_new_item_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? allSelected = true;
  bool? dropSelected = false;
  bool? setsSelected = false;
  bool? priceSelected = false;

  GetData? getData;
  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };
  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getUserInfo(requestToken);

    getData!.getVaultStats();

    getData!.getCollectibles();

    getData!.getNews();

    super.initState();
  }

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
      backgroundColor: const Color(0xff272E49),
      body: Consumer<GetData>(
        builder: (context, data, child) {
          return data.profileModel != null &&
                  data.vaultStatsModel != null &&
                  data.newsModel != null
              ? SafeArea(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: SizedBox(
                                    height: Get.height * .06,
                                    width: Get.height * .06,
                                    child: Image.asset(
                                      'assets/media/icon/logo v.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              Text(
                                "Hi, ${data.profileModel!.nickname.toString()}",
                                style: Get.textTheme.headline1!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              15.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => const Profile()));
                              },
                              child: Container(
                                child: data.profileModel!.profileImage != null
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                          Urls.mainUrl +
                                              data.profileModel!.profileImage!
                                                  .mobile!.src
                                                  .toString(),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 15,
                                        backgroundImage: AssetImage(
                                            'assets/media/image/profile.png'),
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
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Text(
                          'News',
                          textAlign: TextAlign.left,
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      AppSpaces.spaces_height_10,
                      ImageSlider(
                        news: data.newsModel!.results!=null
                        ?data.newsModel!.results
                        :null
                      ),
                      AppSpaces.spaces_height_10,
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 15, right: 15),
                        child: Text(
                          'My Vault',
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      HomeVaultCard(
                        vaultStatsModel: data.vaultStatsModel,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        child: Text(
                          'Newest',
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.collectiblesModel != null
                              ? VaultNewItemCard(
                                  list: data.collectiblesModel!.results,
                                )
                              : const LoadingExample(),
                        ),
                      ),
                      AppSpaces.spaces_height_10,
                    ],
                  ),
                )
              :
            const LoadingExample();

        },
      ),
    );
  }
}

class Rarity {
  final String? name;

  Rarity({this.name});
}

List<Rarity> rarityList = [
  Rarity(name: "Rare"),
  Rarity(name: "Ultra-Rare"),
  Rarity(name: "Common"),
  Rarity(name: "Uncommon"),
];
