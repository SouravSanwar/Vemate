//For Items of graphn page
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/features/vault/MySets/separate_mysets_list.dart';
import 'package:ketemaa/features/vault/Wishlist/Separate_Vault_List/vault_collectibles_lists.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import 'package:intl/intl.dart';

class VaultCollectiblesCard extends StatefulWidget {
  final Collectible? data;

  const VaultCollectiblesCard({Key? key, this.data}) : super(key: key);

  @override
  State<VaultCollectiblesCard> createState() => _VaultCollectiblesCardState();
}

class _VaultCollectiblesCardState extends State<VaultCollectiblesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
                () => const SeparateMysetsList(title: "My Collectibles",type: 0,)
        );
      },
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: Get.height * .013),
        height: Get.height * .13,
        width: Get.width,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric( vertical: Get.height * 0.03),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Text(
                    "Collectibles Value",
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.textColor.withOpacity(.7),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),

                  Text(
                    '\$${widget.data!.changePrice != null ? widget.data!
                        .changePrice.toStringAsFixed(2) : "0.0"}',
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(

                    '\$' + widget.data!.totalCollectibleValue!.toString(),
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.textColor.withOpacity(.7),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data!.changePercent != null
                            ? widget.data!.changePercent.toStringAsFixed(2) + "%"
                            : "0.0" "%",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: widget.data!.sign == 'decrease'
                                ? Colors.red
                                : Colors.green,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                      widget.data!.sign! == 'decrease'
                          ? Icon(
                            Icons.arrow_downward,
                            size: 18,
                            color: Colors.red,
                          )
                          : Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: Colors.green,
                          ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
