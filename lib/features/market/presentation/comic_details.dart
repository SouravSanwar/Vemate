import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/models/ComicsModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/graph/graph_helper.dart';
import 'package:ketemaa/graph/test_graph.dart';
import 'package:provider/provider.dart';

class ComicDetails extends StatefulWidget {
  const ComicDetails({Key? key}) : super(key: key);

  @override
  _ComicDetailsState createState() => _ComicDetailsState();
}

class _ComicDetailsState extends State<ComicDetails> {
  Results results = Get.arguments;

  @override
  void initState() {
    super.initState();

    var fetchData = Provider.of<GetData>(context, listen: false);
    fetchData.getSingleProduct(results.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff272E49),
          elevation: 4,
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      child: GraphTest(
                        graphList: data.singleProductModel!.graph,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: GraphHelper(),
        ),
      );
    });
  }
}
