import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/graph/graph_helper_comics.dart';
import 'package:ketemaa/graph/product_graph.dart';
import 'package:provider/provider.dart';

class ComicDetails extends StatefulWidget {
  final int? productId;

  const ComicDetails({Key? key, this.productId}) : super(key: key);

  @override
  _ComicDetailsState createState() => _ComicDetailsState();
}

class _ComicDetailsState extends State<ComicDetails> {
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
                color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
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
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: FadeInUp(
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            child:data.singleProductModel!.graph != null ? ProductGraph(
                              graphList: data.singleProductModel!.graph,
                            ):Container(),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: GraphHelperComics(),
              )
            : LoadingExample(),
      );
    });
  }
}
