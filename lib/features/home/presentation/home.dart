import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/features/vault/NewDesignCard/combined_vault_card.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../components/image_slider.dart';
import '../components/New_Item_card/vault_new_item_card.dart';

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

  PostData? postData;
  TextEditingController passwordController = TextEditingController();
  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    //getConnection();

    getData = Provider.of<GetData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return data.profileModel != null &&
              data.homeVaultModel != null &&
              data.newsModel != null &&
              data.notificationListModel != null
          ? Scaffold(
              backgroundColor: AppColors.backgroundColor,
              key: _scaffoldKey,
              // appBar: AppBar(
              //   backgroundColor: AppColors.backgroundColor,
              //   elevation: 0,
              //   leading: Padding(
              //     padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12, left: 12),
              //     child: InkWell(
              //       onTap: () {
              //         _scaffoldKey.currentState!.openDrawer();
              //       },
              //       child: Container(
              //         child: data.profileModel!.profileImage != null
              //             ? CircleAvatar(
              //                 radius: 20,
              //                 backgroundImage: NetworkImage(
              //                   Urls.mainUrl + data.profileModel!.profileImage!.mobile!.src.toString(),
              //                 ),
              //               )
              //             : const CircleAvatar(
              //                 radius: 20,
              //                 backgroundImage: AssetImage('assets/media/image/profile.png'),
              //               ),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           border: Border.all(
              //             color: AppColors.greyWhite,
              //             width: 1.0,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //   title: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             "Hi, ${data.profileModel!.nickname.toString()}",
              //             style: Get.textTheme.headline1!
              //                 .copyWith(color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(
              //           14.0,
              //         ),
              //         child: InkWell(
              //           focusColor: Colors.transparent,
              //           onTap: () async {
              //             Get.to(() => const AllNotificationList());
              //           },
              //           child: NotificationBadge(),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // drawer: const Drawer(elevation: 0, backgroundColor: Colors.transparent, child: HomeDrawer()),
              body: SafeArea(
                  minimum: EdgeInsets.only(top: Get.height * 0.0209),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ///News
                      Padding(
                        padding: const EdgeInsets.only(top: 11, bottom: 12, left: 15, right: 15),
                        child: Text(
                          'News',
                          textAlign: TextAlign.left,
                          style: Get.textTheme.headline2!
                              .copyWith(color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        ),
                      ),

                      ImageSlider(news: data.newsModel != null ? data.newsModel!.results : null),

                      ///My Vault
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 0, left: 15, right: 15),
                        child: Text(
                          'My Vault',
                          style: Get.textTheme.headline2!
                              .copyWith(color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                        child: const CombinedVaultCard(),
                      ),

                      ///Newest
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
                        child: Text(
                          'Latest Updates',
                          style: Get.textTheme.headline2!
                              .copyWith(color: AppColors.textColor, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      SizedBox(
                        height: Get.height * .22,
                        child: SizedBox(
                          width: Get.width,
                          child: data.collectiblesModel != null
                              ? VaultNewItemCard(
                                  list: data.collectiblesModel!.results,
                                )
                              : const ColorLoader(),
                        ),
                      ),
                    ],
                  )),
            )
          : ColorLoader();
    });
  }
}
