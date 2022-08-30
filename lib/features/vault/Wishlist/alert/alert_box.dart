import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertFrequencyDropdown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTypeDropDown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_button.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/minFrequencyDropDown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/min_button.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/mintTypeDropdown.dart';
import 'package:ketemaa/main.dart';

import '../../../../core/models/WishListModel.dart';

class ShowAlertBox extends StatefulWidget {
  final Results? results;

  const ShowAlertBox({Key? key, this.results}) : super(key: key);

  @override
  _ShowAlertBoxState createState() => _ShowAlertBoxState();
}

class _ShowAlertBoxState extends State<ShowAlertBox> with SingleTickerProviderStateMixin{

  late TabController _tabController;




  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.only(
          top: 10.0,
        ),
        title:TabBar(
          tabs: const <Widget>[
            Tab(
              
              text: ("Mint"),
            ),
            Tab(
              text: ("Price"),
            ),
          ],
          controller: _tabController,
        ),
        content:Container(
          height: Get.height*.5,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        MintFrequencyDropDown(
                          results: widget.results,
                        ),
                        SizedBox(
                          height: 14.h,
                        ),

                        MintTypeDropDown(
                          results: widget.results,
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        MintButton(
                          results: widget.results,
                        ),
                      ],
                    ),
                  )),
              SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        AlertFrequencyDropDown(
                          results: widget.results,
                        ),
                        SizedBox(
                          height: 14.h,
                        ),

                        AlertTypeDropDown(
                          results: widget.results,
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        AlertButton(
                          results: widget.results,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),


        );
  }
}
