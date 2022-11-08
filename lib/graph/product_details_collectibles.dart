import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';

class ProductDetailsCollectibles extends StatefulWidget {
  final int? id;

  const ProductDetailsCollectibles({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetailsCollectibles> createState() => _ProductDetailsCollectiblesState();
}

class _ProductDetailsCollectiblesState extends State<ProductDetailsCollectibles> {
  GetData? getData;

  PostData? postData;
  bool isAddedVault = false;
  bool isAddedWishlist = false;

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
          padding: const EdgeInsets.only(left: 5, right: 8),
          child: Container(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: Get.height * .01,
                ),
                ItemDetailsHelper(
                  text: "Edition",
                  text1: data.vaultProductDetailsModel != null
                      ? data.vaultProductDetailsModel!.results![0].mintNumber.toString()
                      : "",
                  fromVault: true,
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Acquisition Price",
                  text1: data.vaultProductDetailsModel != null
                      ? data.vaultProductDetailsModel!.results![0].ap.toString()
                      : "",
                  fromVault: true,
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Acquisition Date",
                  text1: data.vaultProductDetailsModel != null
                      ? data.vaultProductDetailsModel!.results![0].ad.toString()
                      : "",
                  fromVault: true,
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Floor Price",
                  text1: data.singleProductModel != null ? data.singleProductModel!.floorPrice.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Edition",
                  text1: data.singleProductModel != null ? data.singleProductModel!.edition.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Owner",
                  text1: data.singleProductModel != null ? data.singleProductModel!.owner.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Name",
                  text1: data.singleProductModel != null ? data.singleProductModel!.name.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Drop Date",
                  text1: data.singleProductModel != null ? data.singleProductModel!.dropDate.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "List Price",
                  text1: data.singleProductModel != null ? data.singleProductModel!.listPrice.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Editions",
                  text1: data.singleProductModel != null ? data.singleProductModel!.editions.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Edition Type",
                  text1: data.singleProductModel != null ? data.singleProductModel!.editionType.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Season",
                  text1: data.singleProductModel != null ? data.singleProductModel!.season.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Rarity",
                  text1: data.singleProductModel != null ? data.singleProductModel!.rarity.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Brand",
                  text1: data.singleProductModel!.brand != null ? data.singleProductModel!.brand!.name.toString() : "",
                ),
                divider(),
                ItemDetailsHelper(
                  text: "Series",
                  text1: data.singleProductModel != null ? data.singleProductModel!.series.toString() : "",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
