import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AlertListPage extends StatefulWidget {
  const AlertListPage({Key? key}) : super(key: key);

  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
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

    getData!.getAlert();
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
        title: Text(
          'My Alerts',
          style: Get.textTheme.headline2!.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.alertModel != null
            ? SmartRefresher(
          key: _refreshkey,
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            color: AppColors.primaryColor,
          ),
          footer:  const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: data.alertModel!.results != null
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: data.alertModel!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: AppColors.cardGradient,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color:AppColors.borderColor)
                      ),
                      child: InkWell(
                        onTap: () {
                          data.alertModel!.results![index].type ==
                              0
                              ? Get.to(
                                () => CollectibleDetails(
                              productId: data.alertModel!
                                  .results![index].id!,
                            ),
                          )
                              : Get.to(
                                () => ComicDetails(
                              productId: data
                                  .alertModel!
                                  .results![index].id!,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: Get.height * .078,
                                width: Get.height * .078,
                                decoration: BoxDecoration(
                                    color: const Color(0xD3C89EF3),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(color: AppColors.borderColor),),
                                alignment: Alignment.center,
                                child: Text(
                                  data.alertModel!
                                      .results![index].name
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color:
                                      Colors.deepPurpleAccent,
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              AppSpaces.spaces_width_2,
                              Expanded(
                                flex: 7,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 4,
                                            child: SizedBox(
                                              height:
                                              Get.height * .02,
                                              child: Text(
                                                data.alertModel!
                                                    .results![index]
                                                    .name
                                                    .toString(),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                textAlign:
                                                TextAlign.start,
                                                style: Get.textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                    color: AppColors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    fontSize:
                                                    13.sp),
                                              ),
                                            )),
                                        AppSpaces.spaces_width_2,
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              data
                                                  .alertModel!
                                                  .results![index]
                                                  .priceType
                                                  .toString(),
                                              textAlign:
                                              TextAlign.start,
                                              style: Get.textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                  color:
                                                  AppColors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .w300,
                                                  fontSize: 10.sp),
                                            )),
                                      ],
                                    ),
                                    AppSpaces.spaces_height_10,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            data.alertModel!
                                                .results![
                                            index].type == 1
                                                ? data.alertModel!.results![index].value!= null
                                                ? data.alertModel!.results![index].value.toString()
                                                : ""


                                                : data.alertModel!.results![index].value!= null
                                                ? data.alertModel!.results![index].value.toString()
                                                : "",


                                            textAlign:
                                            TextAlign.start,
                                            style: Get.textTheme
                                                .bodyText1!
                                                .copyWith(
                                                color: AppColors
                                                    .greyWhite
                                                    .withOpacity(
                                                    0.8),
                                                fontWeight:
                                                FontWeight
                                                    .w900,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                        AppSpaces.spaces_width_2,
                                        /*Expanded(
                                          flex: 2,
                                          child: Text(
                                            data
                                                .wishListModel!
                                                .results![index]
                                                .productDetail!
                                                .rarity
                                                .toString(),
                                            textAlign:
                                            TextAlign.start,
                                            style: Get.textTheme
                                                .bodyText1!
                                                .copyWith(
                                                color: AppColors
                                                    .greyWhite
                                                    .withOpacity(
                                                    0.8),
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                fontSize: 10),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                    AppSpaces.spaces_height_10,
                                    Row(

                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            r"$" +
                                                data.alertModel!.results![index].frequency.toString(),
                                            textAlign:
                                            TextAlign.start,
                                            style: Get.textTheme
                                                .bodyText1!
                                                .copyWith(
                                                color: AppColors
                                                    .greyWhite
                                                    .withOpacity(
                                                    0.8),
                                                fontWeight:
                                                FontWeight
                                                    .w900,
                                                fontSize: 11.sp),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),


                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 9.0,
                    right: 10.0,
                    child: InkWell(
                      onTap: () {
                        postData!.deleteWishlist(
                          context,
                          data.wishListModel!.results![index].id,
                          requestHeadersWithToken,index
                        );
                        printInfo(info: 'On Tapped');
                      },
                      child:  Icon(
                        Icons.delete,
                        color: AppColors.white,
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

    getData!.getAlert();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getAlert();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}

