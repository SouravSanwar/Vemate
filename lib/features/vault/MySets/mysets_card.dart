import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/Test.dart';
import 'package:ketemaa/features/home/components/New_Item_card/new_item_container.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/vault/MySets/MySets_Individual_List.dart';
import 'package:ketemaa/features/vault/MySets/mysets_structure.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/Provider/getData.dart';
import '../../../core/models/SetListModel.dart';
import '../../market/presentation/Details/collectible_details.dart';

class MysetsCard extends StatefulWidget {
  const MysetsCard({
    Key? key,
  }) : super(key: key);

  @override
  State<MysetsCard> createState() => _MysetsCardState();
}

class _MysetsCardState extends State<MysetsCard> {
  double mysetHeight = Get.height * .296;
  double mysetWidth = Get.width * .45;
  GetData? getData;
  Color? color = Colors.green;
  String? rarity = "";

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    // TODO: implement initState
    getData!.getMySets(
      0,
      true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(
      builder: (context, data, child) {
        return data.mySetsModel != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: data.mySetsModel!.results!.length,
                itemBuilder: (BuildContext context, int index) {
                  data.mySetsModel!.results![index].productDetail!.rarity != null
                      ? rarity = data.mySetsModel!.results![index].productDetail!.rarity.toString()
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
                      right: index == data.mySetsModel!.results!.length - 1 ? 6 : 8.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => MySetsIndividualList(
                              productId: data.mySetsModel!.results![index].productDetail!.id,
                              productName: data.mySetsModel!.results![index].productDetail!.name,
                            ));
                        /*data.setListModel!.setResults![index].setProductDetail!
                      .type ==
                      1
                      ? Get.to(() => ComicDetails(
                    productId: data.setListModel!
                        .setResults![index].setProductDetail!.id!,
                  ))
                      : Get.to(() => CollectibleDetails(
                    productId: data.setListModel!
                        .setResults![index].setProductDetail!.id!,
                  ));*/
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
                                checkImage: data.mySetsModel!.results![index].productDetail!.image.toString(),
                                lowResUrl: data.mySetsModel!.results![index].productDetail!.image != null
                                    ? data.mySetsModel!.results![index].productDetail!.image!.lowResUrl.toString()
                                    : "",
                                scrappedImage: data.mySetsModel!.results![index].productDetail!.image != null
                                    ? data.mySetsModel!.results![index].productDetail!.image!.baseUrl.toString()
                                    : "",
                                name: data.mySetsModel!.results![index].productDetail!.name == null
                                    ? ""
                                    : data.mySetsModel!.results![index].productDetail!.name!,
                                edition: data.mySetsModel!.results![index].productDetail!.edition == null
                                    ? ""
                                    : data.mySetsModel!.results![index].productDetail!.edition!,
                                rarity: data.mySetsModel!.results![index].productDetail!.rarity == null
                                    ? ""
                                    : data.mySetsModel!.results![index].productDetail!.rarity!,
                                floorPrice: data.mySetsModel!.results![index].productDetail!.floorPrice == null
                                    ? ""
                                    : data.mySetsModel!.results![index].productDetail!.floorPrice!,
                                pcpPercent: data.mySetsModel!.results![index].statsDetail == null
                                    ? 0.0
                                    : data.mySetsModel!.results![index].statsDetail!.changePercent!,
                                pcpSign: data.mySetsModel!.results![index].statsDetail == null
                                    ? ""
                                    : data.mySetsModel!.results![index].statsDetail!.sign!,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffD15EED),
                                    Color(0xff8D5FED),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  data.mySetsModel!.results![index].statsDetail != null
                                      ? data.mySetsModel!.results![index].statsDetail!.totalItem.toString()
                                      : '',
                                  style: TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      /*Container(
                  width: Get.width * .37,
                  decoration: BoxDecoration(
                    gradient: AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: data.setListModel!.setResults![index]
                      .setProductDetail!.image ==
                      null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.setListModel!.setResults![index]
                            .setProductDetail!.name
                            .toString()[0]
                            .toUpperCase(),
                        style: TextStyle(
                            color: AppColors.backgroundColor,
                            //fontFamily: 'Inter',
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                      NewItemContainer(
                        name: data.setListModel!.setResults![index]
                            .setProductDetail!.name.toString(),
                        series: <ChartSeries<Graph, String>>[
                          LineSeries<Graph, String>(
                            color: data.setListModel!.setResults![index]
                                .setProductDetail!.graphData!.priceChangePercent!
                                .sign ==
                                'decrease'
                                ? Colors.red
                                : Colors.green,
                            dataSource: data.setListModel!.setResults![index]
                                .setProductDetail!.graphData!.graph!,
                            xValueMapper: (Graph plot, _) => plot.date,
                            yValueMapper: (Graph plot, _) =>
                            plot.floorPrice,
                            xAxisName: 'Duration',
                            yAxisName: 'Total',
                          )
                        ],
                        floorPrice:
                        data.setListModel!.setResults![index]
                            .setProductDetail!.floorPrice.toString(),
                        pcpPercent:
                        data.setListModel!.setResults![index]
                            .setProductDetail!.graphData!.priceChangePercent!.percent,
                        pcpSign: data.setListModel!.setResults![index]
                            .setProductDetail!.graphData!.priceChangePercent!.sign
                            .toString(),
                      )
                    ],
                  )
                      : CachedNetworkImage(
                    imageUrl: data.setListModel!.setResults![index]
                        .setProductDetail!.image!.low_res_url == null
                        ? data.setListModel!.setResults![index]
                        .setProductDetail!.image!.image_on_list
                        .toString()
                        : data.setListModel!.setResults![index]
                        .setProductDetail!.image!.low_res_url.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: NewItemContainer(
                          name: data.setListModel!.setResults![index]
                              .setProductDetail!.name.toString(),
                          series: <ChartSeries<Graph, String>>[
                            LineSeries<Graph, String>(
                              color: data.setListModel!.setResults![index]
                                  .setProductDetail!.graphData!.priceChangePercent!
                                  .sign ==
                                  'decrease'
                                  ? Colors.red
                                  : Colors.green,
                              dataSource: data.setListModel!.setResults![index]
                                  .setProductDetail!.graphData!.graph!,
                              xValueMapper: (Graph plot, _) => plot.date,
                              yValueMapper: (Graph plot, _) =>
                              plot.floorPrice,
                              xAxisName: 'Duration',
                              yAxisName: 'Total',
                            )
                          ],
                          floorPrice:
                          data.setListModel!.setResults![index]
                              .setProductDetail!.floorPrice.toString(),
                          pcpPercent: data.setListModel!.setResults![index]
                              .setProductDetail!.graphData!.priceChangePercent!.percent,
                          pcpSign: data.setListModel!.setResults![index]
                              .setProductDetail!.graphData!.priceChangePercent!.sign
                              .toString(),
                        )),
                  ),
                ),*/
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }
}
