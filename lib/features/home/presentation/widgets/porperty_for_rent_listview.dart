import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';
import 'package:ketemaa/features/home/data/models/property_rent_model.dart';
import 'package:ketemaa/features/home/presentation/widgets/popular_in_row.dart';
import 'package:ketemaa/features/home/presentation/widgets/residential_for_rent_card.dart';

class PropertyListView extends StatelessWidget {
  const PropertyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList<Edges> API_edge = HomeController
        .to.propertyRentModel.value.propertyRentAdvertises!.edges!.obs;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return API_edge[index].node!.category!.keyword.toString() ==
                  "post_residential_rent_ad"
              ? Column(
                  children: [
                    PopularInRow(
                      type: AppLanguageString.POPULAR_IN.tr,
                      popularIn:
                          API_edge[index].node!.category!.name.toString(),
                    ),
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.PROPERTY_DETAILS_PAGE);
                      },
                      child: ResidentialForRentCard(
                        categorykeyword:
                            API_edge[index].node!.category!.keyword.toString(),
                        subCategory: API_edge,
                      ),
                    ),
                  ],
                )
              : API_edge[index].node!.category!.keyword.toString() ==
                      "post_commercial_rent_ad"
                  ? Column(
                      children: [
                        PopularInRow(
                          type: AppLanguageString.POPULAR_IN.tr,
                          popularIn:
                              API_edge[index].node!.category!.name.toString(),
                        ),
                        InkWell(
                          onTap: (){
                            Get.toNamed(AppRoutes.PROPERTY_DETAILS_PAGE);
                          },
                          child: ResidentialForRentCard(
                            categorykeyword: API_edge[index]
                                .node!
                                .category!
                                .keyword
                                .toString(),
                            subCategory: API_edge,
                          ),
                        ),
                      ],
                    )
                  : API_edge[index].node!.category!.keyword.toString() ==
                          "post_rooms_rent_ad"
                      ? Column(
                          children: [
                            PopularInRow(
                              type: AppLanguageString.POPULAR_IN.tr,
                              popularIn: API_edge[index]
                                  .node!
                                  .category!
                                  .name
                                  .toString(),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.PROPERTY_DETAILS_PAGE);
                                /*Get.to(
                                  () => PropertyDetailsPage(),
                                );*/
                              },
                              child: ResidentialForRentCard(
                                categorykeyword: API_edge[index]
                                    .node!
                                    .category!
                                    .keyword
                                    .toString(),
                                subCategory: API_edge,
                              ),
                            ),
                          ],
                        )
                      : Container();
        });
  }
}
