import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';

import 'package:ketemaa/graph/product_details.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class HomeVaultCard extends StatefulWidget {
  final VaultStatsModel? vaultStatsModel;

  const HomeVaultCard({Key? key, this.vaultStatsModel}) : super(key: key);

  @override
  State<HomeVaultCard> createState() => _HomeVaultCardState();
}

class _HomeVaultCardState extends State<HomeVaultCard> {
  double percent = 3.30;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * .03,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Vault Value",
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "MCP",
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: Get.width * .15,
                      height: Get.height * .03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient, // set border width
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Text(
                        '\$' +
                            widget.vaultStatsModel!.totalPriceChange.toString(),
                        textAlign: TextAlign.start,
                        style: Get.textTheme.bodyText2!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(""),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                              '24H',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),

                        width: Get.width * .15,
                        height: Get.height * .03,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * .03,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '\$' +
                          widget.vaultStatsModel!.totalVaultValue.toString(),
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '\$' + widget.vaultStatsModel!.mcp.toString(),
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.vaultStatsModel!.totalPercentChange! < 0.0)
                          //toRotateIcon
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Icon(
                              Icons.arrow_downward,
                              size: 18,
                              color: Colors.red,
                            ),
                          )
                        else
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Icon(
                              Icons.arrow_upward,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                        Text(
                          widget.vaultStatsModel!.totalPercentChange! < 0.0
                              ? widget.vaultStatsModel!.totalPercentChange!
                                  .toString()
                              : widget.vaultStatsModel!.totalPercentChange!
                                      .toString() +
                                  "%",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: widget.vaultStatsModel!.totalPercentChange! <
                                    0.0
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(""),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(""),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Get.width * .02,
                ),
                height: Get.height * .12,
                /*child: LineChart(
                  mainData(), // Optional
                  swapAnimationCurve: Curves.easeInOutBack, // Optional
                ),*/
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          )),
    );
  }
}
