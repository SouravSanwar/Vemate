import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/Components/category_card.dart';
import 'package:ketemaa/features/vault/my_wishlist_collectibles_list.dart';
import 'package:ketemaa/features/vault/my_wishlist_comics_list.dart';
import 'package:provider/provider.dart';

class WishListDetails extends StatefulWidget {
  const WishListDetails({Key? key}) : super(key: key);

  @override
  State<WishListDetails> createState() => _WishListDetailsState();
}

class _WishListDetailsState extends State<WishListDetails> {
  GetData? getData;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getCollectibles();
    //getData!.getComics();
    super.initState();
  }

  int? currentIndex = 1;
  bool? collectibleSelected = true;
  bool? comicSelected = false;
  bool? brandSelected = false;
  TextEditingController searchController = TextEditingController();


  //For Filter

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(top: AppDimension.padding_8),
          child: Stack(
            children: [
              AppSpaces.spaces_height_20,
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
                              gradient: collectibleSelected == true
                                  ? AppColors.purpleGradient
                                  : const LinearGradient(
                                colors: [
                                  Color(0xff272E49),
                                  Color(0xff272E49),
                                ],
                              ),
                            ),
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
                              gradient: comicSelected == true
                                  ? AppColors.purpleGradient
                                  : const LinearGradient(
                                colors: [
                                  Color(0xff272E49),
                                  Color(0xff272E49),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  ///Body
                  Container(
                    child: collectibleSelected == true
                        ? const MyWishlistCollectiblesLists()
                        : (comicSelected == true
                        ? const MyWishlistComicsLists()
                        : Container()),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
