import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:ketemaa/graph/product_details.dart';
import 'package:ketemaa/graph/product_graph.dart';
import 'package:provider/provider.dart';

class CollectibleDetails extends StatefulWidget {
  final int? productId;

  const CollectibleDetails({Key? key, this.productId}) : super(key: key);

  @override
  _CollectibleDetailsState createState() => _CollectibleDetailsState();
}

class _CollectibleDetailsState extends State<CollectibleDetails> {
  GetData? getData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
    getData!.getSingleProduct(widget.productId);

    getData!.checkWishlist(widget.productId!);
    getData!.checkSetList(widget.productId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 1,
          title: Text(
            data.singleProductModel != null
                ? data.singleProductModel!.name.toString()
                : "",
            style: TextStyle(
                color: Colors.blueGrey.shade300,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: data.singleProductModel != null
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 100),
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: data.singleProductModel!.graph != null
                                    ? ProductGraph(
                                        graphList:
                                            data.singleProductModel!.graph,
                                        graphType:
                                            data.singleProductModel!.graphType,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 100),
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 10.0,
                              alignment: WrapAlignment.center,
                              children: <Widget>[
                                ///24 Hour
                                DesignHelper(
                                  onPressed: () {
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 0);
                                  },
                                  child: const Text(
                                    "24H",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                ///7 Days
                                DesignHelper(
                                  onPressed: () {
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 1);
                                  },
                                  child: const Text(
                                    "7D",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                ///30 Days
                                DesignHelper(
                                  onPressed: () {
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 2);
                                  },
                                  child: const Text(
                                    "30D",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                ///60 Days
                                DesignHelper(
                                  onPressed: () {
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 3);
                                  },
                                  child: const Text(
                                    "60D",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                ///1 Year
                                DesignHelper(
                                  onPressed: () {
                                    getData!.getSingleProduct(widget.productId,
                                        graphType: 4);
                                  },
                                  child: const Text(
                                    "1Y",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpaces.spaces_height_25,
                        ],
                      ),
                    )
                  ];
                },
                body: const ProductDetails(),
              )
            : const LoadingExample(),
      );
    });
  }
}
