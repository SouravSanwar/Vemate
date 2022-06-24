import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/home/notification/notification_alart.dart';
import 'package:ketemaa/features/profile/presentation/profile.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import 'package:ketemaa/features/home/components/home_vault_card.dart';

import '../../../core/Provider/getData.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/shimmer/loading.dart';
import '../components/image_slider.dart';
import '../components/vault_new_item_card.dart';
import 'package:badges/badges.dart';

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
  AppUpdate? appUpdate;

  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    // TODO: implement initState
    //getConnection();

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getNotification();

    getData!.getUserInfo();

    getData!.getVaultStats(0);

    getData!.getCollectibles();

    getData!.getNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 15),
        child: Consumer<GetData>(
          builder: (context, data, child) {
            return data.profileModel != null &&
                    data.vaultStatsModel != null &&
                    data.newsModel != null &&
                    data.notificationListModel != null
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
                                      child: data.profileModel!.profileImage !=
                                              null
                                          ? CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                Urls.mainUrl +
                                                    data
                                                        .profileModel!
                                                        .profileImage!
                                                        .mobile!
                                                        .src
                                                        .toString(),
                                              ),
                                            )
                                          : const CircleAvatar(
                                              radius: 20,
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
                                Text(
                                  "Hi, ${data.profileModel!.nickname.toString()}",
                                  style: Get.textTheme.headline1!.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                14.0,
                              ),
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => NotificationAlertBox(
                                              list: data.notificationListModel!
                                                  .results!,
                                            ));
                                  },
                                  child: Container(
                                    child: data.notificationListModel!
                                                .totalUnread ==
                                            0
                                        ? Icon(
                                            Icons.notifications_none,
                                            color: AppColors.textColor,
                                          )
                                        : Badge(
                                            position: BadgePosition.topEnd(
                                                top: 3, end: 6),
                                            badgeContent: Text(
                                              data.notificationListModel!
                                                  .totalUnread
                                                  .toString(),
                                              style: TextStyle(fontSize: 8),
                                            ),
                                            badgeColor: Colors.redAccent,
                                            child: Icon(
                                              Icons.notifications_none,
                                              color: AppColors.textColor,
                                            )),
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      border: Border.all(
                                          color: AppColors
                                              .grey, // set border color
                                          width: 1), // set border width
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              15.0)), // set rounded corner radius
                                    ),
                                  )),
                            ),
                          ],
                        ),

                        ///News
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            'News',
                            textAlign: TextAlign.left,
                            style: Get.textTheme.headline2!.copyWith(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        AppSpaces.spaces_height_10,
                        ImageSlider(
                            news: data.newsModel != null
                                ? data.newsModel!.results
                                : null),
                        AppSpaces.spaces_height_10,
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 0, left: 15, right: 15),
                          child: Text(
                            'My Vault',
                            style: Get.textTheme.headline2!.copyWith(
                                color: AppColors.textColor,
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
                                color: AppColors.textColor,
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
                : const LoadingExample();
          },
        ),
      ),
    );
  }
}
