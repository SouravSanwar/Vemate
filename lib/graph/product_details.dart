import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';

class ProductDetails extends StatefulWidget {
  final int? id;


  const ProductDetails({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GetData? getData;

  PostData? postData;
  bool isAddedVault=false;
  bool isAddedWishlist=false;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);

    postData = Provider.of<PostData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(
      builder: (context, data, child) {
        return Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child:
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListView(children: <Widget>[
                    SizedBox(
                      height: Get.height*.01,
                    ),
                    ItemDetailsHelper(
                      text: "Floor Price",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.floorPrice.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Edition",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.edition.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Name",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.name.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Drop Date",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.dropDate.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "List Price",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.listPrice.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Editions",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.editions.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Edition Type",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.editionType.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Season",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.season.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Rarity",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.rarity.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Brand",
                      text1: data.singleProductModel!.brand != null
                          ? data.singleProductModel!.brand!.name.toString()
                          : "",
                    ),
                    divider(),
                    ItemDetailsHelper(
                      text: "Series",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.series.toString()
                          : "",
                    ),
                  ]),
                ),
              ),

        );
      },
    );
  }
}
