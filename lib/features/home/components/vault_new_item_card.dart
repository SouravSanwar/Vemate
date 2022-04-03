
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/graph/chart_example.dart';
import 'package:ketemaa/graph/product_details.dart';

import '../../../../core/models/CollectiblesModel.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class VaultNewItemCard extends StatefulWidget {
  List<Results>? list;


  VaultNewItemCard({
    this.list,
  });

  @override
  State<VaultNewItemCard> createState() => _VaultNewItemCardState();
}

class _VaultNewItemCardState extends State<VaultNewItemCard> {
  bool _isLoaded = false;
  String? firstHalf;

  @override
  void initState() {
    super.initState();

    // make _isLoaded true after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double percent = 3.30;


    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_8,
        right: AppDimension.padding_8,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.list!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
                onTap: () {
                  Get.to(() => ChartExample(id: widget.list![index].id));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: Get.width*.37,
                        height: Get.height*.22,
                        decoration: BoxDecoration(
                            gradient: AppColors.cardGradient,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff454F70))),
                        alignment: Alignment.topCenter,
                        child:Column(
                          children: [
                            Text(
                              widget.list![index].name
                                  .toString()[0]
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: Get.height*.08,),
                            BlurryContainer(
                              padding: const EdgeInsets.all(3.0),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                              bgColor: Colors.white,
                              width: Get.width*.37,
                              height: Get.height*.08,
                              blur: 2,
                              child: Column(
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:6,
                                        child:Container(
                                          height: Get.height*.02,
                                          child:Text(
                                            widget.list![index].name.toString().length >9
                                                ? widget.list![index].name.toString().substring(0,8)+"..."
                                                : widget.list![index].name.toString(),

                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex:4,
                                        child:Container(
                                          height: Get.height*.02,
                                          /*child: LineChart(
                                            mainData(),// Optional
                                            swapAnimationCurve:
                                            Curves.easeInOutQuad, // Optional
                                          ),*/
                                      ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*.01,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Expanded(

                                        child:Container(
                                          width: Get.width * .1,
                                          height: Get.height * .03,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: AppColors
                                                .purpleGradient, // set border width
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(
                                                    8.0)),
                                          ),
                                          child: Text(
                                            r"$" + percent.toString(),
                                            textAlign: TextAlign.start,
                                            style: Get.textTheme.bodyText2!.copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              percent < 0.0
                                                  ? percent.toString()
                                                  : "+" + percent.toString(),
                                              textAlign: TextAlign.end,
                                              style: Get.textTheme.bodyText1!.copyWith(
                                                  color: percent < 0.0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                            ),
                                            if (percent < 0.0)
                                              const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.red,
                                                size: 14,
                                              )
                                            else
                                              const Icon(
                                                Icons.arrow_upward,
                                                color: Colors.green,
                                                size: 14,
                                              )
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),

              ),

          );
        },
      ),
    );
  }
}
