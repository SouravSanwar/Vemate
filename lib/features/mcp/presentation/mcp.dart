import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/mcp_card_shimmer.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/mcp/Components/category_card.dart';
import 'package:ketemaa/features/mcp/Components/collectibles_mcp_card.dart';
import 'package:ketemaa/features/mcp/Components/comics_mcp_card.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/app_assets/app_assets.dart';

class MCP extends StatefulWidget {
  const MCP({Key? key}) : super(key: key);

  @override
  State<MCP> createState() => _MCPState();
}

class _MCPState extends State<MCP> {
  var fetchData;

  @override
  void initState() {
    // TODO: implement initState
    fetchData = Provider.of<GetData>(context, listen: false);

    fetchData.getCollectibles();
    fetchData.getComics();
    super.initState();
  }

  int? currentIndex = 1;
  bool? collectibleSelected = true;
  bool? comicSelected = false;
  bool? brandSelected = false;

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      /*appBar: AppBar(
        //leading: null,
        // The search area here
        leading: Container(
          width: Get.width,
          height: Get.height * .35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text('AppBar'),
          ),
        ),
      ),*/
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(top: AppDimension.padding_16),
          child: Stack(
            //shrinkWrap: true,
            children: [
              AppSpaces.spaces_height_10,
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppDimension.padding_8,
                      right: AppDimension.padding_8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppDimension.primary_radius),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            //height: 100,
                            child: Padding(
                              padding: EdgeInsets.all(AppDimension.padding_8),
                              child: const Text(
                                'Search by Name or Brand',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpaces.spaces_height_10,
                  Container(
                    child: collectibleSelected == true
                        ? SizedBox(
                            height: Get.height,
                            child: data.collectiblesModel != null
                                ? CollectiblesMCPCard(
                                    list: data.collectiblesModel!.results,
                                  )
                                : const MCPCardShimmer(),
                          )
                        : (comicSelected == true
                            ? SizedBox(
                                height: Get.height,
                                child: data.comicsModel != null
                                    ? ComicsMcpCard(
                                        list: data.comicsModel!.results,
                                      )
                                    : const MCPCardShimmer(),
                              )
                            : Center(
                                child: Text('Brand'),
                              )),
                  )
                ],
              ),
              AppSpaces.spaces_height_10,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimension.padding_8),
                      topRight: Radius.circular(AppDimension.padding_8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            currentIndex = 1;
                            setState(() {
                              collectibleSelected = true;
                              comicSelected = false;
                              brandSelected = false;
                            });
                          },
                          child: CategoryCard(
                              name: 'Collectibles',
                              color: collectibleSelected == true
                                  ? Colors.green
                                  : Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            currentIndex = 2;
                            setState(() {
                              comicSelected = true;
                              brandSelected = false;
                              collectibleSelected = false;
                            });
                          },
                          child: CategoryCard(
                              name: 'Comics',
                              color: comicSelected == true
                                  ? Colors.green
                                  : Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            currentIndex = 3;
                            setState(() {
                              brandSelected = true;
                              collectibleSelected = false;
                              comicSelected = false;
                            });
                          },
                          child: CategoryCard(
                            name: 'Brand',
                            color: brandSelected == true
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
