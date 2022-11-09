import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/models/SetListModel.dart';

class MysetsStack extends StatefulWidget {
  const MysetsStack({
    Key? key,
  }) : super(key: key);

  @override
  State<MysetsStack> createState() => _MysetsStackState();
}

class _MysetsStackState extends State<MysetsStack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Container(
          child: Stack(
              alignment: Alignment.center,
              children: _generateCards(data)));
    });
  }

  List<Widget> _generateCards(dynamic data) {
    List<Widget> cardList = [];

    for (int index = 0; index < 5; index++) {
      cardList.add(
        Positioned(
            top: index * 3 + 5,
            left: index * 3 + 5,
            child: Container(
              width: Get.width * .37,
              height: Get.height * .19,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.pinkAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.white)),
            )),
      );
    }
    return cardList;
  }
}
