import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/market/presentation/widgets/products_list_container.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/features/vault/Component/no_data_card.dart';
import 'package:ketemaa/features/vault/MySets/MySets_Individual_List.dart';
import 'package:ketemaa/features/vault/Wishlist/Separate_Vault_List/separate_vault_structure.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../core/models/MySetsModel.dart';

class SetListPage extends StatefulWidget {
  const SetListPage({Key? key}) : super(key: key);

  @override
  State<SetListPage> createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  double mysetHeight = Get.height * .115;
  double mysetWidth = Get.width * .95;
  GetData? getData;
  Color? color = Colors.green;
  String? rarity = "";
  PostData? postData;

  int alertCheck = 0;
  int offset = 0;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refreshkey = GlobalKey();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    postData = Provider.of<PostData>(context, listen: false);
    getData!.mySetsModel = null;
    getData!.getMySets(0, true, graph_data: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "My Vault",
          style:
              TextStyle(color: AppColors.textColor, fontFamily: 'Inter', fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<GetData>(builder: (content, data, child) {
        return Container(
          height: Get.height * .9,
          width: Get.width,
          padding: const EdgeInsets.only(bottom: 10),
          child: data.mySetsModel != null
              ? ListView.builder(
                  itemCount: data.mySetsModel!.results!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
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
                      padding: const EdgeInsets.only(top: 4, bottom: 10, left: 4, right: 4),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => MySetsIndividualList(
                                productId: data.mySetsModel!.results![index].productDetail!.id,
                                productName: data.mySetsModel!.results![index].productDetail!.name,
                              ));
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
                                        Color(0xff17193C),
                                        Color(0xff313552),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    color: AppColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SeparateVaultStructure(
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
                                    brand: data.mySetsModel!.results![index].productDetail!.brand == null
                                        ? ""
                                        : data.mySetsModel!.results![index].productDetail!.brand.toString(),
                                    series: <ChartSeries<Graph, String>>[
                                      LineSeries<Graph, String>(
                                        color: data.mySetsModel!.results![index].statsDetail!.sign! == 'decrease'
                                            ? Colors.red
                                            : Colors.green,
                                        dataSource: data.mySetsModel!.results![index].statsDetail!.graph!,
                                        xValueMapper: (Graph plot, _) => plot.date,
                                        yValueMapper: (Graph plot, _) => plot.floorPrice,
                                        xAxisName: 'Duration',
                                        yAxisName: 'Total',
                                      )
                                    ],
                                    changePrice: data.mySetsModel!.results![index].statsDetail!.priceChange,
                                    floorPrice: data.mySetsModel!.results![index].productDetail!.floorPrice == null
                                        ? ""
                                        : data.mySetsModel!.results![index].productDetail!.floorPrice!,
                                    pcpPercent: data.mySetsModel!.results![index].statsDetail!.changePercent == null
                                        ? 0.0
                                        : data.mySetsModel!.results![index].statsDetail!.changePercent!,
                                    pcpSign: data.mySetsModel!.results![index].statsDetail!.sign == null
                                        ? ""
                                        : data.mySetsModel!.results![index].statsDetail!.sign!,
                                  )),
                            ),
                            Positioned(
                              top: 10,
                              right: 5,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff492987),
                                      Color(0xff1C4C89),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff17193C),
                                        Color(0xff313552),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    data.mySetsModel!.results![index].statsDetail!.totalItem.toString(),
                                    style: TextStyle(
                                        color: AppColors.textColor, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : ColorLoader(),
        );
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getSetList('');

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getSetList('', offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
