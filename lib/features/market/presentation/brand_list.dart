import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/Provider/getData.dart';


class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refreshKey = GlobalKey();

  GetData? getData;

  @override
  void initState() {
    super.initState();
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return SizedBox(
        height: Get.height * .8,
        child: data.brandModel != null
            ? SmartRefresher(
                key: _refreshKey,
                controller: refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropMaterialHeader(
                  color: AppColors.primaryColor,
                ),
                footer: const ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                ),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: data.brandModel!.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            data.brandModel!.results![index].name.toString(),
                            style: TextStyle(fontFamily: 'Inter',),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : ColorLoader(),
      );
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getBrand();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getBrand(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
