import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';
import 'designhelper.dart';



class ProductDetailsComics extends StatefulWidget {
  final int? id;

  const ProductDetailsComics({Key? key, this.id}) : super(key: key);

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
              ),
            ]),
          ),



        );
      },
    );
  }
}

