import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/home/components/notification_badge.dart';
import 'package:ketemaa/features/home/notification/no_notification.dart';
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
    return Consumer<GetData>(builder: (context, data, child) {
      return data.profileModel != null &&
              data.vaultStatsModel != null &&
              data.newsModel != null &&
              data.notificationListModel != null
          ? Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: SafeArea(
                  minimum: EdgeInsets.only(top: Get.height * 0.0209),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 12, bottom: 15, left: 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => const Profile()));
                                  },
                                  child: Container(
                                    child:
                                        data.profileModel!.profileImage != null
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
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              14.0,
                            ),
                            child: InkWell(
                              onTap: () async {
                                data.notificationListModel!.results!.isEmpty
                                    ? Get.to(() => const NoNotification())
                                  : showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            const NotificationAlertBox(),
                                      );

                                /*if (data
                                    .notificationListModel!.results!.isEmpty) {
                                  await Future.delayed(const Duration(seconds: 1));
                                  Navigator.of(context).pop();
                                }*/
                              },
                              child: NotificationBadge(
                                notificationListModel:
                                    data.notificationListModel,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///News
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 11, bottom: 12, left: 15, right: 15),
                        child: Text(
                          'News',
                          textAlign: TextAlign.left,
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      ImageSlider(
                          news: data.newsModel != null
                              ? data.newsModel!.results
                              : null),

                      ///My Vault
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 0, left: 15, right: 15),
                        child: Text(
                          'My Vault',
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      HomeVaultCard(
                        vaultStatsModel: data.vaultStatsModel,
                      ),

                      ///Newest
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 15, right: 15),
                        child: Text(
                          'Newest',
                          style: Get.textTheme.headline2!.copyWith(
                              color: AppColors.textColor,
                              fontFamily: 'Inter',
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
                    ],
                  )),
            )
          : ColorLoader();
    });
  }
}
