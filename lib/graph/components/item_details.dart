import 'package:flutter/cupertino.dart';
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
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Owner",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.owner.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Edition",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.edition.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Name",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.name.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Drop Date",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.dropDate.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "List Price",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.listPrice.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Editions",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.editions.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Edition Type",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.editionType.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Season",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.season.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Rarity",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.rarity.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
          ),
          ItemDetailsHelper(
            text: "Brand",
            text1: data.singleProductModel != null
                ? data.singleProductModel!.brand.toString()
                : "",
          ),
          const SizedBox(
            height: 0.5,
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
