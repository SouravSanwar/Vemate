import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:provider/provider.dart';

class CombinedVaultCard extends StatefulWidget {
  const CombinedVaultCard({Key? key}) : super(key: key);

  @override
  State<CombinedVaultCard> createState() => _CombinedVaultCardState();
}

class _CombinedVaultCardState extends State<CombinedVaultCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return data.vaultStatsModel != null
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: Get.height * .013),
              height: Get.height * .13,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: AppColors.combinedVaultCardGradient,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.03,bottom: Get.height * 0.03,left: Get.width * 0.05556,right: Get.width * 0.05556),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vault Value",
                          textAlign: TextAlign.start,
                          style: Get.textTheme.bodyText2!.copyWith(
                              color: AppColors.textColor.withOpacity(.7),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        Text(
                          '\$${data.vaultStatsModel!.totalPriceChange != null ? data.vaultStatsModel!.totalPriceChange!.toStringAsFixed(2) : ""}',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$' + data.vaultStatsModel!.totalVaultValue!.toStringAsFixed(2),
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
                              data.vaultStatsModel!.totalPercentChange! < 0.0
                                  ? data.vaultStatsModel!.totalPercentChange!.toStringAsFixed(2)
                                  : data.vaultStatsModel!.totalPercentChange!.toStringAsFixed(2) + "%",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: data.vaultStatsModel!.sign! == 'decrease' ? Colors.red : Colors.green,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                            data.vaultStatsModel!.sign! == 'decrease'
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
            )
          : const ColorLoader();
    });
  }
}
