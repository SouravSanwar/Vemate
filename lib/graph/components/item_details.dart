import 'package:flutter/cupertino.dart';
import 'package:ketemaa/graph/components/item_details_helper.dart';
import 'package:provider/provider.dart';

import '../../core/Provider/getData.dart';

class ItemDetails extends StatelessWidget {

  final String? text;
  final String? text1;

  ItemDetails({
    this.text,
    this.text1,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Container(
        child: ListView(

            children: <Widget>[
              ItemDetailsHelper(
                text: "Floor Price",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.floorPrice
                    .toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Owner",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.owner.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Edition",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.edition.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Name",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.name.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Drop Date",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.dropDate.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "List Price",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.listPrice.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Editions",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.editions.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Edition Type",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.editionType
                    .toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Season",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.season.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Rarity",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.rarity.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Brand",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.brand.toString()
                    : "",
              ),

              const SizedBox(height: 0.5,),

              ItemDetailsHelper(
                text: "Series",
                text1: data.singleCollectibleModel != null
                    ? data.singleCollectibleModel!.details!.series.toString()
                    : "",
              ),
            ]
        ),
      );
    }
    );
  }
}