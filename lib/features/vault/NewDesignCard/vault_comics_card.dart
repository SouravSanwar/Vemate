import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/MySets/separate_mysets_list.dart';
import 'package:ketemaa/features/vault/Wishlist/Separate_Vault_List/vault_comics_lists.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utilities/app_colors/app_colors.dart';

class VaultComicsCard extends StatefulWidget {
  final Comic? data;

  const VaultComicsCard({Key? key, this.data}) : super(key: key);

  @override
  State<VaultComicsCard> createState() => _VaultComicsCardState();
}

class _VaultComicsCardState extends State<VaultComicsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
              () => const SeparateMysetsList(title: "My Comics",type: 1,)
        );
      },
      child: Container(
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
                    "Comics Value",
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.textColor.withOpacity(.7),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                  Text(

                    '\$' + widget.data!.totalComicValue!.toString(),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Text(
                      widget.data!.sign == 'decrease'
                          ?

                      '-\$${widget.data!.changePrice != null
                          ? widget.data!.changePrice.abs().toStringAsFixed(2)
                          : ""}'

                          :

                      '\$${widget.data!.changePrice != null
                          ? widget.data!.changePrice.toStringAsFixed(2)
                          : ""}',
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(

                          color: AppColors.textColor.withOpacity(.7),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
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
                          ? const Icon(
                        Icons.arrow_downward,
                        size: 18,
                        color: Colors.red,
                      )
                          : const Icon(
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
