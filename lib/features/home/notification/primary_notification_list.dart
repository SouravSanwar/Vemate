import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/models/NotificationListModel.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class PrimaryNotificationList extends StatefulWidget {
  List<Results>? list;



  PrimaryNotificationList({
    this.list,
  });

  @override
  State<PrimaryNotificationList> createState() => _PrimaryNotificationListState();
}

class _PrimaryNotificationListState extends State<PrimaryNotificationList> {
  PostData? postData;

  @override
  void initState() {
    postData = Provider.of<PostData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context,data,child){
      return Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child:widget.list !=null ? ListView.builder(
          shrinkWrap: true,
          itemCount: widget.list!.length >4 ? 4 : widget.list!.length,
          itemBuilder: (BuildContext context, int index) {
            return  Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:index==0? 8 : 4.0,right:index==9? 8 : 4.0 ),
                  child: InkWell(
                      onTap: () async {
                        var body = {};

                        Map<String, String> requestHeadersWithToken = {
                          'Content-type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'token ${prefs!.getString('token')}',
                        };
                        await postData!
                            .notificationRead(context, widget.list![index].target!.id,body, requestHeadersWithToken);


                        widget.list![index].target!.type ==
                                0
                                ? Get.to(
                                    () => CollectibleDetails(
                                  productId: widget.list![index].target!.id,
                                ))
                                : Get.to(
                                  () => ComicDetails(
                        productId: widget.list![index].target!.id,
                              ),
                            );

                      },
                      child: Container(
                        child: Row(
                          children: [
                            ///dot icon
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(Icons.brightness_1,size: 10,
                                  color: widget.list![index].unread == true
                                      ?Color(0xffA473E6)
                                      :AppColors.backgroundColor,),
                              ),
                            ),
                            SizedBox(width: Get.width*.02,),
                            ///Image
                            Container(
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor
                                      .withOpacity(.8),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.borderColor)),
                              alignment: Alignment.center,
                              child: Text(
                                widget.list![index].target!.name.toString()[0].toUpperCase(),
                                style:  TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: Get.width*.02,),
                            ///details
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.list![index].description.toString(),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    height: Get.height * .01,
                                  ),
                                  Text(
                                    widget.list![index].timesince.toString(),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.textColor.withOpacity(.7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      )
                  ),
                ),
                index !=3 ?Divider(): SizedBox(height: 10.h,)
              ],
            );
          },
        ): Container(),
      );
    });
  }
}
