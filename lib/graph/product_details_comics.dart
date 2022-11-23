import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';
import 'designhelper.dart';
import 'package:intl/intl.dart';

import 'product_details_collectibles.dart';



class ProductDetailsComics extends StatefulWidget {
  final int? id;
  final bool? fromVault;
  final int? mintId;

  ProductDetailsComics({Key? key, this.id, this.fromVault = false, this.mintId}) : super(key: key);

  @override
  State<ProductDetailsComics> createState() => _ProductDetailsComicsState();
}

class _ProductDetailsComicsState extends State<ProductDetailsComics> {
  GetData? getData;

  PostData? postData;

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
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListView(children: <Widget>[
              SizedBox(
                height: Get.height*.01,
              ),
              widget.fromVault == true
                  ? Column(
                children: [
                  ItemDetailsHelper(
                    text: "Edition",
                    text1: detailsEdition,
                    fromVault: true,
                    topRadius: true,
                  ),
                  divider(),
                  ItemDetailsHelper(
                    text: "Acquisition Price",
                    text1: detailsAp,
                    fromVault: true,
                  ),
                  divider(),
                  ItemDetailsHelper(
                    text: "Acquisition Date",
                    text1: DateFormat('MMMM dd, yyyy').format(DateTime.parse(detailsAd.toString())),
                    fromVault: true,
                  ),
                  divider(),
                ],
              )
                  : Container(),
              ItemDetailsHelper(
                text: "Floor Price",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.floorPrice.toString()
                    : "",
                topRadius: widget.fromVault == true ?false:true,
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
                text: "Owner",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.owner.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Cover Variant",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.coverVariant.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Cover Artitst",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.coverArtist.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Publisher",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.publisher.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Series",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.series.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Issue",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.issue.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Pages",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.pages.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Start Year",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.startYear.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Writers",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.writers.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Artists",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.artists.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Characters",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.characters.toString()
                    : "",
              ),
              divider(),
              ItemDetailsHelper(
                text: "Editions",
                text1: data.singleProductModel != null
                    ? data.singleProductModel!.editions.toString()
                    : "",
                bottomRadius: true,
              ),
            ]),
          ),
        );
      },
    );
  }
}

