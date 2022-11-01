import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/model/MultiRowModel.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Date_Picker/date_picker.dart';
import 'Date_Picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';

class Multiform extends StatefulWidget {
  int? id;
  int? type;
   Multiform({Key? key,this.id,this.type}) : super(key: key);

  @override
  State<Multiform> createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  TextEditingController mintController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PostData? postData;
  GetData? getData;
  int offset = 0;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final GlobalKey _refreshkey = GlobalKey();


  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  List<MultiRowModel> addToListController = [
    MultiRowModel(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    )
  ];
  List<TextEditingController> storedMintController=[];
  List<TextEditingController> storedPriceController=[];

  @override
  void initState() {
    addToListController.length = 0;
    postData = Provider.of<PostData>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);
    getData!.getMAO(widget.type.toString(), widget.id.toString());
    super.initState();
  }
  Future<bool> _willPopCallback() async {
    Get.offAll(() => CollectibleDetails(
      productId: widget.id
    ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // mint_row.clear();
    // for (int i = 0; i < mint_info.length; i++) {
    //   mint_row.add(MintRow(
    //     mint_info: mint_info[i],
    //     deleteRow: () {
    //       onDelete(i);
    //     },
    //   ));
    // }
    return WillPopScope(
        onWillPop: _willPopCallback,
        child:

        Consumer<GetData>(builder: (context, data, child) {

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Container(
                height: addToListController.length * Get.height*.07 + (125 - (addToListController.length * 10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppSpaces.spaces_height_10,
                      Row(
                        children: [
                          AppSpaces.spaces_width_10,
                          Container(
                            height: Get.height*.065,
                            child: MintTextField(
                              width: Get.width * .65,
                              labelText: 'Enter Mint',
                              textType: TextInputType.number,
                              controller: mintController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter mint number';
                                }
                              },
                            ),
                          ),
                          AppSpaces.spaces_width_5,
                          AppSpaces.spaces_width_5,
                          Container(
                            alignment: Alignment.topCenter,
                            height: Get.height*.065,
                            child: InkWell(
                              child: Icon(
                                Icons.add,
                                size: 25,
                                color: AppColors.grey,
                              ),
                              onTap: () {

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    addToListController.add(
                                      MultiRowModel(
                                        TextEditingController(text: mintController.text),
                                        TextEditingController(),
                                        TextEditingController(
                                            text: DateTime.now().toIso8601String()
                                        ),
                                      ),
                                    );
                                  });
                                }
                                mintController.clear();
                              },
                            ),
                          )
                        ],
                      ),
                      AppSpaces.spaces_height_10,
                      data.maoModel! !=null
                      ? Container(
                        child: SmartRefresher(
                            key: _refreshkey,
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
                            child:  ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.maoModel!.results!.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                    storedMintController[index].text=data.maoModel!.results![index].mintNumber.toString();
                                    storedPriceController[index].text=data.maoModel!.results![index].ap.toString();
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppSpaces.spaces_width_5,
                                    MintTextField(
                                      width: Get.width * .21,
                                      labelText: 'Mint Number',
                                      textType: TextInputType.number,
                                      controller: storedMintController[index],
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "";
                                        }
                                      },
                                    ),
                                    AppSpaces.spaces_width_5,
                                    MintTextField(
                                      width: Get.width * .21,
                                      labelText: 'Price',
                                      textType: TextInputType.number,
                                      controller: storedPriceController[index],
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "";
                                        }
                                      },
                                    ),
                                    AppSpaces.spaces_width_5,
                                    Container(
                                      width: Get.width * .21,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.white.withOpacity(.7),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(data.maoModel!.results![index].ad!)
                                              ).toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white.withOpacity(.7),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              var datePicked = await DatePicker.showSimpleDatePicker(
                                                context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2015),
                                                lastDate: DateTime.now(),
                                                dateFormat: "dd-MM-yyyy",
                                                locale: DateTimePickerLocale.en_us,
                                                looping: true,
                                                backgroundColor: Color(0xff02072D),
                                                textColor: AppColors.white.withOpacity(.7),
                                              );
                                              setState(() {
                                                addToListController[index].dateTime!.text =
                                                    datePicked!.toIso8601String();
                                              });
                                            },
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: AppColors.white.withOpacity(.7),
                                              size: 17,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppSpaces.spaces_width_5,
                                    InkWell(
                                      child: Container(
                                          height: Get.height * .035,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.white.withOpacity(.7),
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          child: Icon(Icons.minimize,color: AppColors.textColor,size: 20,)
                                      ),
                                      onTap: () {
                                        if (addToListController.isNotEmpty) {
                                          setState(() {
                                            addToListController.removeAt(index);
                                          });
                                        }
                                        print(addToListController.length.toString());
                                      },
                                    )
                                  ],
                                );
                              },
                            )
                        ),
                      )
                      :Container(),

                      AppSpaces.spaces_height_10,
                      Container(
                        height: addToListController.length < 10 ?addToListController.length*(Get.height*.055)-(addToListController.length*5)
                            : (Get.height*.55-50),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addToListController.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppSpaces.spaces_width_5,
                                MintTextField(
                                  width: Get.width * .21,
                                  labelText: 'Mint Number',
                                  textType: TextInputType.number,
                                  controller: addToListController[index].mintNumber1!,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "";
                                    }
                                  },
                                ),
                                AppSpaces.spaces_width_5,
                                MintTextField(
                                  width: Get.width * .21,
                                  labelText: 'Price',
                                  textType: TextInputType.number,
                                  controller: addToListController[index].price!,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "";
                                    }
                                  },
                                ),
                                AppSpaces.spaces_width_5,
                                Container(
                                  width: Get.width * .21,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white.withOpacity(.7),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(addToListController[index].dateTime!.text)
                                          ).toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white.withOpacity(.7),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var datePicked = await DatePicker.showSimpleDatePicker(
                                            context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now(),
                                            dateFormat: "dd-MM-yyyy",
                                            locale: DateTimePickerLocale.en_us,
                                            looping: true,
                                            backgroundColor: Color(0xff02072D),
                                            textColor: AppColors.white.withOpacity(.7),
                                          );
                                          setState(() {
                                            addToListController[index].dateTime!.text =
                                                datePicked!.toIso8601String();
                                          });
                                        },
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: AppColors.white.withOpacity(.7),
                                          size: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AppSpaces.spaces_width_5,
                                InkWell(
                                  child: Container(
                                      height: Get.height * .035,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.white.withOpacity(.7),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(7.0),
                                      ),
                                      child: Icon(Icons.minimize,color: AppColors.textColor,size: 20,)
                                  ),
                                  onTap: () {
                                    if (addToListController.isNotEmpty) {
                                      setState(() {
                                        addToListController.removeAt(index);
                                      });
                                    }
                                    print(addToListController.length.toString());
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      addToListController.isNotEmpty
                          ? TextButton(
                        onPressed: () {
                          var body = {
                            "product": widget.id,
                            "type": widget.type,
                            "mints": [
                              for (int i = 0; i < addToListController.length; i++)
                                {
                                  "mint_number": addToListController[i].mintNumber1!.text,
                                  "ap": addToListController[i].price!.text,
                                  "ad": addToListController[i].dateTime!.text
                                }
                            ]
                          };

                          if (_formKey.currentState!.validate()) {

                            postData!.postMAO(context, body,requestHeadersWithToken,);
                          }

                          printInfo(info: body.toString()+ requestHeadersWithToken.toString());
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: AppColors.white.withOpacity(.7),
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                )
            )
          );
        })

    );
  }
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getNotification();
    getData!.getAlert();
    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getNotification(offset: offset);
    getData!.getAlert(offset: offset);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
