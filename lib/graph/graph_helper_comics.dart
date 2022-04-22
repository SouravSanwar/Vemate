import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'components/item_details_helper.dart';
import 'designhelper.dart';

class gh {
  static bool c = true;
  static var aa = '0AM',
      bb = '2AM',
      cc = '4AM',
      dd = '6AM',
      ee = '8AM',
      ff = '10AM',
      gg = '12PM',
      hh = '2PM',
      ii = '4PM',
      jj = '6PM',
      kk = '8PM',
      ll = '10PM',
      mm = '2AM',
      nn = '4AM',
      oo = '6AM',
      pp = '8AM',
      qq = '10AM',
      rr = '12PM',
      ss = '2PM',
      tt = '4PM',
      uu = '6PM',
      vv = '8PM',
      ww = '10PM';
}

class GraphHelperComics extends StatefulWidget {
  final int? id;

  const GraphHelperComics({Key? key, this.id}) : super(key: key);

  @override
  State<GraphHelperComics> createState() => _GraphHelperComicsState();
}

class _GraphHelperComicsState extends State<GraphHelperComics> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  data.singleProductModel != null
                      ? data.singleProductModel!.name.toString() + "'s Details"
                      : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              AppSpaces.spaces_height_20,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5)),
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
                      text: "Cover Variant",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.coverVariant.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Cover Artitst",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.coverArtist.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Publisher",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.publisher.toString()
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
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Issue",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.issue.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Pages",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.pages.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Start Year",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.startYear.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Writers",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.writers.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Artists",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.artists.toString()
                          : "",
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    ItemDetailsHelper(
                      text: "Characters",
                      text1: data.singleProductModel != null
                          ? data.singleProductModel!.characters.toString()
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
                  ]),
                ),
              ),
              AppSpaces.spaces_height_20,

            ],
          ),
        );
      },
    );
  }
}
