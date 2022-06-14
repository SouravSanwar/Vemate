import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/graph/components/item_details_helper.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Container(
        child: ListView(children: <Widget>[
          ItemDetailsHelper(
            text: "Floor Price",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.floorPrice.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Owner",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.owner.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Edition",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.edition.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Name",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.name.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Drop Date",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.dropDate.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "List Price",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.listPrice.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Editions",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.editions.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Edition Type",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.editionType.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Season",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.season.toString()
                : "",
          ),
         SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Rarity",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.rarity.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Brand",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.brand.toString()
                : "",
          ),
          SizedBox(
            height: 0.5.h,
          ),
          ItemDetailsHelper(
            text: "Series",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.series.toString()
                : "",
          ),
        ]),
      );
    });
  }
}
