import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/home/notification/no_notification.dart';
import 'package:ketemaa/features/home/notification/system_notification_details.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/AlertModel.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({Key? key}) : super(key: key);

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList> with SingleTickerProviderStateMixin {
  GetData? getData;
  PostData? postData;
  int alertCheck = 0;
  int offset = 0;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final GlobalKey _refreshkey = GlobalKey();

  int? currentIndex = 1;
  bool? notificationSelected = true;
  bool? alarmSelected = false;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    // TODO: implement initState
    postData = Provider.of<PostData>(context, listen: false);

    getData = Provider.of<GetData>(context, listen: false);
    getData!.getAlert();

    getData!.getNotification();
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.to(() => ControllerPage(), transition: Transition.upToDown);
    // Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Consumer<GetData>(builder: (context, data, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 1.0,
              titleSpacing: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              backgroundColor: AppColors.backgroundColor,
              title: Text(
                notificationSelected == true ? 'Notifications' : "Alarms set",
                style: Get.textTheme.headline2!.copyWith(color: AppColors.textColor),
              ),
              actions: [
                notificationSelected == true
                    ? PopupMenuButton(
                        color: Colors.transparent,
                        itemBuilder: (ctx) => [
                          _buildPopupMenuItem('Mark all as Read'),
                        ],
                      )
                    : Container()
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            currentIndex = 1;
                            setState(() {
                              notificationSelected = true;
                              alarmSelected = false;
                            });
                          },
                          child: CategoryCard(
                            name: 'Notifications',
                            gradient: notificationSelected == true
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
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            currentIndex = 2;
                            setState(() {
                              notificationSelected = false;
                              alarmSelected = true;
                            });
                          },
                          child: CategoryCard(
                            name: 'Alarms Set',
                            gradient: alarmSelected == true
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
                  ],
                ),
              ),
            ),
            body: Container(
                child: notificationSelected == true
                    ? data.notificationListModel == null
                        ? const ColorLoader()
                        : SmartRefresher(
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
                            child: data.notificationListModel!.count == 0
                                ? NoNotification(
                                    title: "No notification to show",
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.notificationListModel!.results!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.graphCard,
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: SizedBox(
                                                width: Get.width,
                                                child: InkWell(
                                                    onTap: () async {
                                                      var body = {};

                                                      Map<String, String> requestHeadersWithToken = {
                                                        'Content-type': 'application/json',
                                                        'Accept': 'application/json',
                                                        'Authorization': 'token ${prefs!.getString('token')}',
                                                      };

                                                      if (int.parse(data.notificationListModel!.results![index].verb
                                                              .toString()) !=
                                                          7) {
                                                        if (data.notificationListModel!.results![index].target!.type ==
                                                            0) {
                                                          setState(() {
                                                            postData!
                                                                .notificationRead(
                                                                    context,
                                                                    data.notificationListModel!.results![index].id,
                                                                    requestHeadersWithToken)
                                                                .whenComplete(() => data.notificationListModel!
                                                                    .results![index].unread = false);
                                                          });
                                                          Get.to(() => CollectibleDetails(
                                                                productId: data
                                                                    .notificationListModel!.results![index].target!.id,
                                                                fromNotification: 1,
                                                              ));
                                                        } else {
                                                          setState(() {
                                                            postData!
                                                                .notificationRead(
                                                                    context,
                                                                    data.notificationListModel!.results![index].id,
                                                                    requestHeadersWithToken)
                                                                .whenComplete(() => data.notificationListModel!
                                                                    .results![index].unread = false);
                                                          });
                                                          Get.to(
                                                            () => ComicDetails(
                                                              productId: data
                                                                  .notificationListModel!.results![index].target!.id,
                                                              fromNotification: 1,
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        setState(() {
                                                          postData!
                                                              .notificationRead(
                                                                  context,
                                                                  data.notificationListModel!.results![index].id,
                                                                  requestHeadersWithToken)
                                                              .whenComplete(() => data.notificationListModel!
                                                                  .results![index].unread = false);
                                                        });
                                                        Get.to(() => SystemNotificationDetails(
                                                              title: data.notificationListModel!.results![index].title,
                                                              description: data
                                                                  .notificationListModel!.results![index].description,
                                                              link: data.notificationListModel!.results![index].link,
                                                            ));
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        ///dot icon
                                                        Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons.brightness_1,
                                                            size: 10,
                                                            color: data.notificationListModel!.results![index].unread ==
                                                                    true
                                                                ? const Color(0xffA473E6)
                                                                : Colors.transparent,
                                                          ),
                                                        ),

                                                        ///Image
                                                        Container(
                                                            height: Get.height * .09,
                                                            width: Get.height * .078,
                                                            decoration: BoxDecoration(
                                                                color: AppColors.primaryColor.withOpacity(.8),
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(color: AppColors.borderColor)),
                                                            alignment: Alignment.center,
                                                            child: data.notificationListModel!.results![index].target ==
                                                                    null
                                                                ? FirstLetterImage(
                                                                    firstLetter: data.notificationListModel!
                                                                        .results![index].description
                                                                        .toString()[0]
                                                                        .toUpperCase(),
                                                                    fontsize: 35,
                                                                  )
                                                                : data.notificationListModel!.results![index].target!
                                                                            .image!.low_res_url ==
                                                                        null
                                                                    ? VeVeLowImage(
                                                                        imageUrl: data
                                                                            .notificationListModel!
                                                                            .results![index]
                                                                            .target!
                                                                            .image!
                                                                            .image_on_list
                                                                            .toString(),
                                                                      )
                                                                    : VeVeLowImage(
                                                                        imageUrl: data.notificationListModel!
                                                                            .results![index].target!.image!.low_res_url
                                                                            .toString(),
                                                                      )),
                                                        SizedBox(
                                                          width: Get.width * .02,
                                                        ),

                                                        ///details
                                                        Expanded(
                                                          flex: 7,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                data.notificationListModel!.results![index].description
                                                                    .toString(),
                                                                textAlign: TextAlign.left,
                                                                maxLines: 3,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.textTheme.bodyText2!.copyWith(
                                                                    color: AppColors.textColor,
                                                                    //fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 12.sp),
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * .01,
                                                              ),
                                                              Text(
                                                                data.notificationListModel!.results![index].timesince
                                                                    .toString(),
                                                                textAlign: TextAlign.left,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.textTheme.bodyText2!.copyWith(
                                                                    color: AppColors.textColor.withOpacity(.7),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 10.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ))
                    : data.alertModel == null
                        ? const ColorLoader()
                        : SmartRefresher(
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
                            child: data.alertModel!.count! == 0
                                ? NoNotification(
                                    title: "No alarm to show",
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.alertModel!.results!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                                          child: Container(
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                color: AppColors.graphCard,
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: InkWell(
                                                  onTap: () {
                                                    data.alertModel!.results![index].productDetail!.type == 0
                                                        ? Get.to(
                                                            () => CollectibleDetails(
                                                              productId:
                                                                  data.alertModel!.results![index].productDetail!.id!,
                                                            ),
                                                          )
                                                        : Get.to(
                                                            () => ComicDetails(
                                                              productId:
                                                                  data.alertModel!.results![index].productDetail!.id!,
                                                            ),
                                                          );
                                                  },
                                                  child: ProductListContainer(
                                                    checkImage:
                                                        data.alertModel!.results![index].productDetail!.image == null
                                                            ? ""
                                                            : data.alertModel!.results![index].productDetail!.image
                                                                .toString(),
                                                    name: data.alertModel!.results![index].productDetail!.name == null
                                                        ? ""
                                                        : data.alertModel!.results![index].productDetail!.name!,
                                                    lowResUrl:
                                                        data.alertModel!.results![index].productDetail!.image != null
                                                            ? data.alertModel!.results![index].productDetail!.image!
                                                                .low_res_url!
                                                            : "",
                                                    scrappedImage:
                                                        data.alertModel!.results![index].productDetail!.image != null
                                                            ? data.alertModel!.results![index].productDetail!.image!
                                                                .image_on_list
                                                                .toString()
                                                            : "",
                                                    edition:
                                                        data.alertModel!.results![index].productDetail!.edition == null
                                                            ? ""
                                                            : data.alertModel!.results![index].productDetail!.edition!,
                                                    brand: data.alertModel!.results![index].productDetail!.brand == null
                                                        ? ""
                                                        : data.alertModel!.results![index].productDetail!.brand
                                                            .toString(),
                                                    brandName: data.alertModel!.results![index].productDetail!.brand ==
                                                            null
                                                        ? ""
                                                        : data.alertModel!.results![index].productDetail!.brand!.name!,
                                                    rarity:
                                                        data.alertModel!.results![index].productDetail!.rarity == null
                                                            ? ""
                                                            : data.alertModel!.results![index].productDetail!.rarity!,
                                                    floorPrice: data.alertModel!.results![index].productDetail!
                                                                .floorPrice ==
                                                            null
                                                        ? ""
                                                        : data.alertModel!.results![index].productDetail!.floorPrice!,
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (ctx) {
                                                            if (data.alertModel != null) {
                                                              return ShowAlertBox(
                                                                results:
                                                                    data.alertModel!.results![index].productDetail!,
                                                                origin: 'allalert',
                                                              );
                                                            } else {
                                                              return Container();
                                                            }
                                                          });
                                                    },
                                                    isAlert: true,
                                                    series: <ChartSeries<Graph, String>>[
                                                      LineSeries<Graph, String>(
                                                        color: data.alertModel!.results![index].productDetail!
                                                                    .graphData!.priceChangePercent!.sign ==
                                                                'decrease'
                                                            ? Colors.red
                                                            : Colors.green,
                                                        dataSource: data.alertModel!.results![index].productDetail!
                                                            .graphData!.graph!,
                                                        xValueMapper: (Graph plot, _) => plot.date,
                                                        yValueMapper: (Graph plot, _) => plot.floorPrice,
                                                        xAxisName: 'Duration',
                                                        yAxisName: 'Total',
                                                      )
                                                    ],
                                                    changePrice: data.alertModel!.results![index].productDetail!
                                                        .graphData!.priceChangePercent!.changePrice,
                                                    pcpPercent: data.alertModel!.results![index].productDetail!
                                                        .graphData!.priceChangePercent!.percent,
                                                    pcpSign: data.alertModel!.results![index].productDetail!.graphData!
                                                        .priceChangePercent!.sign!,
                                                  ))));
                                    },
                                  ))),
          );
        }));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getNotification();
    getData!.getAlert();
    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getNotification(offset: offset);
    getData!.getAlert(offset: offset);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
        child: InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LoadingDialogue(
                        message: "Please wait",
                      ));
              postData!
                  .notificationAllRead(context, requestHeadersWithToken)
                  .whenComplete(() => getData!.getNotification());

              await Future.delayed(Duration(seconds: 1));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              title,
              style: TextStyle(color: AppColors.white),
            )));
  }
}
