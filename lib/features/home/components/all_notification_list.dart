import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertItems.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/WishListModel.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({Key? key}) : super(key: key);

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList> {
  GetData? getData;

  PostData? postData;

  int offset = 0;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refreshkey = GlobalKey();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);

    getData!.getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title:Text(
              'Notifications',
              style: Get.textTheme.headline2!.copyWith(color: AppColors.textColor),
            ),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.wishListModel != null
            ? SmartRefresher(
          key: _refreshkey,
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            color: AppColors.primaryColor,
          ),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: data.wishListModel!.results != null
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: data.wishListModel!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(

                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                    child: Container(
                      width: Get.width,

                      child: InkWell(
                        onTap: () {
                          data.wishListModel!.results![index]
                              .productDetail!.type ==
                              0
                              ? Get.to(
                                () => CollectibleDetails(
                              productId: data
                                  .wishListModel!
                                  .results![index]
                                  .productDetail!
                                  .id!,
                            ),
                          )
                              : Get.to(
                                () => ComicDetails(
                              productId: data
                                  .wishListModel!
                                  .results![index]
                                  .productDetail!
                                  .id!,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Row(

                                children: [
                                  Container(
                                    child: Icon(Icons.brightness_1,size: 10,color: Color(0xffA473E6),),
                                  ),
                                  SizedBox(width: Get.width*.02,),
                                  Container(
                                    height: Get.height * .07,
                                    width: Get.height * .07,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(.8),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.borderColor)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      data
                                          .wishListModel!
                                          .results![index]
                                          .productDetail!
                                          .name
                                          .toString()[0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color:AppColors.backgroundColor,
                                          fontSize: 35.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: Get.width*.02,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          data
                                              .wishListModel!
                                              .results![index]
                                              .productDetail!
                                              .name
                                              .toString(),
                                          textAlign:
                                          TextAlign.start,
                                          style: Get.textTheme
                                              .bodyText2!
                                              .copyWith(
                                              color: AppColors
                                                  .textColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize:
                                              13.sp),
                                        ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      Text(
                                              "52 minutes ago",
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              textAlign:
                                              TextAlign.start,
                                              style: Get.textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                  color: AppColors
                                                      .grey,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  fontSize:
                                                  10.sp),
                                            ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            index !=data.wishListModel!.results!.length-1 ?Divider(): SizedBox(height: 10.h,),
                          ],
                        )
                      ),
                    ),
                  ),


                ],
              );
            },
          )
              : const LoadingExample(),
        )
            : const LoadingExample();
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getWishList();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getWishList(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}




