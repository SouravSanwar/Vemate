import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:provider/provider.dart';

import '../../../core/Provider/getData.dart';
import '../../../core/models/SingleCollectibleModel.dart';

class SingleCollectibleView extends StatefulWidget {
  int? id;

  SingleCollectibleView({Key? key, this.id}) : super(key: key);

  @override
  _SingleCollectibleViewState createState() => _SingleCollectibleViewState();
}

class _SingleCollectibleViewState extends State<SingleCollectibleView> {
  var collectible = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    var fetchData = Provider.of<GetData>(context, listen: false);
    fetchData.getSingleCollectible(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            data.singleCollectibleModel != null
                ? data.singleCollectibleModel!.details!.name.toString()
                : '...',
            style: Get.textTheme.headline1!
                .copyWith(color: AppColors.primaryColor),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.padding_8),
              child: const Icon(Icons.notification_add_outlined),
            ),
          ],
        ),
        body: ListView(),
      );
    });
  }
}
