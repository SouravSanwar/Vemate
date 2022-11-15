import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:ketemaa/features/vault/MySets/MySets_Individual_List.dart';
import 'package:ketemaa/features/vault/MySets/mysets_structure.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/Provider/getData.dart';




class MywishlistCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MywishlistCardState();
  }
}
//data.wishListModel!.results![index]
class MywishlistCardState extends State<MywishlistCard> {
  double mysetHeight = Get.height * .296;
  double mysetWidth = Get.width * .45;
  GetData? getData;
  Color? color = Colors.green;
  String? rarity = "";

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    // TODO: implement initState
    getData!.getMySets(0, true,);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(
      builder: (context, data, child) {
        return data.wishListModel != null
            ? ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: data.wishListModel!.results!.length,
          itemBuilder: (BuildContext context, int index) {
            data.wishListModel!.results![index].productDetail!.rarity != null
                ? rarity = data.wishListModel!.results![index].productDetail!.rarity.toString()
                : "";
            if (rarity == "Common") {
              color = Colors.green;
            } else if (rarity == "Uncommon") {
              color = Colors.purpleAccent;
            }
            if (rarity == "Rare") {
              color = Colors.blue;
            }
            if (rarity == "Ultra Rare") {
              color = Colors.orange;
            }
            if (rarity == "Secret Rare") {
              color = Colors.red;
            }
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 6 : 8.0,
                right: index == data.wishListModel!.results!.length - 1 ? 12 : 8.0,
              ),
              child: InkWell(
                onTap: () {
                  data.wishListModel!.results![index].productDetail!.type == 1
                      ? Get.to(() => ComicDetails(
                    productId: data.wishListModel!.results![index].productDetail!.id!,
                  ))
                      : Get.to(
                        () => CollectibleDetails(
                      productId: data.wishListModel!.results![index].productDetail!.id!,
                    ),
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: mysetWidth,
                      height: mysetHeight,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(color: color!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 2,
                      child: Container(
                        width: mysetWidth,
                        height: mysetHeight,
                        decoration: BoxDecoration(
                          color: Color(0xff282742),
                          border: Border.all(color: Color(0xff282742)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        width: mysetWidth,
                        height: mysetHeight,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: Color(0xff282742)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        width: mysetWidth,
                        height: mysetHeight,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: Color(0xff282742)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        width: mysetWidth,
                        height: mysetHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff282742),
                              color!,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MySetsStructure(
                          color: color!,
                          checkImage: data.wishListModel!.results![index].productDetail!.image.toString(),
                          lowResUrl: data.wishListModel!.results![index].productDetail!.image != null
                              ? data.wishListModel!.results![index].productDetail!.image!.low_res_url.toString()
                              : "",
                          scrappedImage: data.wishListModel!.results![index].productDetail!.image != null
                              ? data.wishListModel!.results![index].productDetail!.image!.base_url.toString()
                              : "",
                          name: data.wishListModel!.results![index].productDetail!.name == null
                              ? ""
                              : data.wishListModel!.results![index].productDetail!.name!,
                          edition: data.wishListModel!.results![index].productDetail!.edition == null
                              ? ""
                              : data.wishListModel!.results![index].productDetail!.edition!,
                          rarity: data.wishListModel!.results![index].productDetail!.rarity == null
                              ? ""
                              : data.wishListModel!.results![index].productDetail!.rarity!,
                          floorPrice: data.wishListModel!.results![index].productDetail!.floorPrice == null
                              ? ""
                              : data.wishListModel!.results![index].productDetail!.floorPrice!,
                          pcpPercent: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.percent,
                          pcpSign: data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign == null
                              ? ""
                              : data.wishListModel!.results![index].productDetail!.graphData!.priceChangePercent!.sign.toString(),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            );
          },
        )
            : Container();
      },
    );
  }
}