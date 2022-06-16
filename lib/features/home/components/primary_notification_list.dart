import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/models/CollectiblesModel.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
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
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:index==0? 8 : 4.0,right:index==9? 8 : 4.0 ),
                child: InkWell(
                  onTap: () {
                    Get.to(
                          () => CollectibleDetails(
                        productId: widget.list![index].id,
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Icon(Icons.brightness_1,size: 10,color: Color(0xffA473E6),),
                        ),
                        SizedBox(width: Get.width*.02,),
                        Container(
                          height: Get.height * .078,
                          width: Get.height * .078,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.borderColor)),
                          alignment: Alignment.center,
                          child: Text(
                            "A",
                            style:  TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: Get.width*.02,),
                        Column(
                          children: [
                            Text(
                              "widget.list![index].name",
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
                              "! minutes ago",
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodyText2!.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                          ],
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
      ),
    );
  }
}
