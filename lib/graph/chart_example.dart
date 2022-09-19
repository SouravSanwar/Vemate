import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/product_details_collectibles.dart';
import 'package:provider/provider.dart';
import '../core/Provider/getData.dart';

class ChartExample extends StatefulWidget {
  int? id;

  ChartExample({Key? key, this.id}) : super(key: key);

  @override
  _ChartExampleState createState() => _ChartExampleState();
}

class _ChartExampleState extends State<ChartExample> {
  var collectible = Get.arguments;

  bool _isLoaded = false;
  int _currentIndex = 0;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var fetchData = Provider.of<GetData>(context, listen: false);
    fetchData.getSingleProduct(widget.id);

    // make _isLoaded true after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 4,
          title: Text(
            data.collectiblesModel != null
                ? data.collectiblesModel!.results![0].name.toString()
                : "",
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      /*child: LineChart(
                        mainData(),
                        swapAnimationDuration:
                            const Duration(milliseconds: 1000),
                        // Optional
                        swapAnimationCurve: Curves.bounceIn, // Optional
                      ),*/
                    ),
                  ),
                ),
              )
            ];
          },
          body: const ProductDetailsCollectibles(),
        ),
      );
    });
  }
}
