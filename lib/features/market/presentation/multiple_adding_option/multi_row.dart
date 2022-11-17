import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/model/MultiRowModel.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/models/MAOModel.dart';
import 'Date_Picker/date_picker.dart';
import 'Date_Picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';

class Multiform extends StatefulWidget {
  int? id;
  int? type;

  Multiform({Key? key, this.id, this.type}) : super(key: key);

  @override
  State<Multiform> createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  TextEditingController mintController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PostData? postData;
  GetData? getData;
  int offset = 0;

  RefreshController refreshController = RefreshController(initialRefresh: false);
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
  List<TextEditingController> storedMintController = [];
  List<TextEditingController> storedPriceController = [];
  List<TextEditingController> storedDateController = [];

  @override
  void initState() {
    addToListController.length = 0;
    postData = Provider.of<PostData>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);
    // getData!.maoModel = null;
    getData!.getMAO(widget.type.toString(), widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return data.maoModel != null
          ? Container(
              height: (data.maoModel!.results!.length + addToListController.length) < 8
                  ? (data.maoModel!.results!.length + addToListController.length) * (Get.height * .055) -
                      ((data.maoModel!.results!.length + addToListController.length) * 5) +
                  (addToListController.isNotEmpty ? 140 : 100)
                  //10 er beshi hole
                  : 490,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.backgroundColor),
              padding: EdgeInsets.zero,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppSpaces.spaces_height_20,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Get.height * .0667,
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
                        InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  // storedMintController.add(
                                  //   TextEditingController(
                                  //     text: mintController.text,
                                  //   ),
                                  // );
                                  // storedPriceController.add(
                                  //   TextEditingController(
                                  //     text: '',
                                  //   ),
                                  // );
                                  // storedDateController.add(
                                  //   TextEditingController(
                                  //     text: DateTime.now().toIso8601String(),
                                  //   ),
                                  // );
                                  //
                                  // data.maoModel!.results!.add(
                                  //   Results(
                                  //     id: data.maoModel!.results![data.maoModel!.results!.length - 1].id! + 1,
                                  //     type: 0,
                                  //     mintNumber: int.parse(mintController.text),
                                  //     ap: '',
                                  //     ad: data.maoModel!.results![0].ad,
                                  //     creationTime: data.maoModel!.results![0].creationTime,
                                  //     user: 17,
                                  //     product: widget.id,
                                  //   ),
                                  // );
                                  // printInfo(
                                  //     info: 'data.maoModel!.results![0]' +
                                  //         data.maoModel!.results![data.maoModel!.results!.length - 1].mintNumber.toString());

                                  addToListController.add(
                                    MultiRowModel(
                                      TextEditingController(text: mintController.text),
                                      TextEditingController(),
                                      TextEditingController(text: DateTime.now().toIso8601String()),
                                    ),
                                  );
                                });
                                mintController.clear();
                                FocusScope.of(context).requestFocus(FocusNode());
                              }
                            },
                            child: Container(
                          alignment: Alignment.center,
                          height: Get.height * .035,
                          width: Get.width * .12,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white.withOpacity(.3),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child:Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.grey,
                            ),


                        )
                        ),
                      ],
                    ),

                    Expanded(
                      child: SmartRefresher(
                          key: _refreshkey,
                          controller: refreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          header: WaterDropMaterialHeader(
                            color: AppColors.graphCard,
                          ),
                          footer: const ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                          ),
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: ListView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              /// new_row
                              Container(
                                // height: addToListController.length < 5
                                //     ? addToListController.length * (Get.height * .055) - (addToListController.length * 5)
                                //     : (Get.height * .275 - 35),
                                child: ListView.builder(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: addToListController.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppSpaces.spaces_width_5,

                                        //mint_number_new_row
                                        Expanded(
                                          flex: 10,
                                          child: MintTextField(
                                            labelText: 'Mint Number',
                                            textType: TextInputType.number,
                                            controller: addToListController[index].mintNumber1!,
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,

                                        //price_new_row
                                        Expanded(
                                          flex: 10,
                                          child: MintTextField(
                                            labelText: 'Price',
                                            textType: TextInputType.number,
                                            controller: addToListController[index].price!,
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,

                                        //datetime_new_row
                                        Expanded(
                                          flex: 11,
                                          child: Container(
                                            height: Get.height * .035,
                                            padding: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.white.withOpacity(.3),
                                                width: 1.5,
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    DateFormat('MMM dd,yyyy')
                                                        .format(
                                                            DateTime.parse(addToListController[index].dateTime!.text))
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.white.withOpacity(.7),
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
                                                        backgroundColor: const Color(0xff02072D),
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
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,

                                        //delete__new_row 8688A0
                                        Expanded(
                                          flex: 3,
                                          child: InkWell(
                                            child: Container(
                                                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColors.white.withOpacity(.4),
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                child: Icon(
                                                  Icons.clear,
                                                  color: AppColors.white.withOpacity(.4),
                                                  size: 17,
                                                )),
                                            onTap: () {
                                              if (addToListController.isNotEmpty) {
                                                setState(() {
                                                  addToListController.removeAt(index);
                                                });
                                              }
                                              print(Get.width.toString());
                                            },
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// StoredRow
                              Container(
                                // height: data.maoModel!.results!.length < 5
                                //     ? data.maoModel!.results!.length * (Get.height * .055) -
                                //         (data.maoModel!.results!.length * 5)
                                //     : (Get.height * .275),
                                child: ListView.builder(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.maoModel!.results!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    storedMintController.add(
                                      TextEditingController(
                                        text: data.maoModel!.results![index].mintNumber.toString(),
                                      ),
                                    );
                                    storedPriceController.add(
                                      TextEditingController(

                                        text: data.maoModel!.results![index].ap.toString(),
                                      ),
                                    );
                                    storedDateController.add(
                                      TextEditingController(
                                        text: data.maoModel!.results![index].ad.toString(),
                                      ),
                                    );
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppSpaces.spaces_width_5,
                                        Expanded(
                                          flex: 10,
                                          child: MintTextField(
                                            labelText: 'Mint Number',
                                            textType: TextInputType.number,
                                            controller: storedMintController[index],
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,
                                        Expanded(
                                          flex: 10,
                                          child: MintTextField(
                                            labelText: 'Price',
                                            textType: TextInputType.number,
                                            controller: storedPriceController[index],
                                          ),
                                        ),
                                        AppSpaces.spaces_width_5,
                                        //datetime_new_row
                                        Expanded(
                                          flex: 11,
                                          child: Container(
                                            height: Get.height * .035,
                                            padding: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.white.withOpacity(.3),
                                                width: 1.5,
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                                               child: InkWell(
                                                  onTap: () async {
                                                    var datePicked = await DatePicker.showSimpleDatePicker(
                                                      context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2015),
                                                      lastDate: DateTime.now(),
                                                      dateFormat: "MMM dd,yyyy",
                                                      locale: DateTimePickerLocale.en_us,
                                                      looping: true,
                                                      backgroundColor: const Color(0xff02072D),
                                                      textColor: AppColors.white.withOpacity(.7),
                                                    );
                                                    setState(() {
                                                      storedDateController[index].text =
                                                          datePicked!.toIso8601String();
                                                    });
                                                  },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    DateFormat('MMM dd,yyyy')
                                                        .format(DateTime.parse(storedDateController[index].text))
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.white.withOpacity(.7),
                                                    ),
                                                  ),

                                                  Icon(
                                                      Icons.calendar_month,
                                                      color: AppColors.white.withOpacity(.7),
                                                      size: 17,
                                                    ),

                                                ],
                                              ),
                                          )
                                            ),
                                          ),
                                        ),
                                        /*Expanded(
                                      flex: 7,
                                      child: Container(
                                        height: Get.height * .035,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.white.withOpacity(.7),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(storedDateController[index].text))
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
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
                                                    backgroundColor: const Color(0xff02072D),
                                                    textColor: AppColors.white.withOpacity(.7),
                                                  );
                                                  setState(() {
                                                    storedDateController[index].text = datePicked!.toIso8601String();
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
                                      ),
                                    ),*/
                                        AppSpaces.spaces_width_5,
                                        storedMintController[index].text !=
                                                    data.maoModel!.results![index].mintNumber.toString() ||
                                                storedPriceController[index].text !=
                                                    data.maoModel!.results![index].ap.toString() ||
                                                storedDateController[index].text !=
                                                    data.maoModel!.results![index].ad.toString()
                                            ? Expanded(
                                                flex: 3,
                                                child: InkWell(
                                                  child: Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors.white.withOpacity(.4),
                                                          width: 2,
                                                        ),
                                                        borderRadius: BorderRadius.circular(20.0),
                                                      ),
                                                      child: Icon(
                                                        Icons.upgrade,
                                                        color: AppColors.white.withOpacity(.4),
                                                        size: 17,
                                                      )),
                                                  onTap: () {
                                                    FocusScope.of(context).unfocus();

                                                    var body = {
                                                      "mint_number": storedMintController[index].text.isEmpty ? "0.0" : storedMintController[index].text,
                                                      "ap": storedPriceController[index].text.isEmpty ? "0.0" :storedPriceController[index].text,
                                                      "ad": storedDateController[index].text
                                                    };
                                                    postData!
                                                        .editMAO(
                                                          data.maoModel!.results![index].id,
                                                          context,
                                                          body,
                                                          requestHeadersWithToken,
                                                        )
                                                        .whenComplete(() => getData!
                                                            .getMAO(widget.type.toString(), widget.id.toString()))
                                                        .whenComplete(() => Navigator.of(context).pop())
                                                         .whenComplete(() => setState(() {
                                                      storedMintController[index].text = data.maoModel!.results![index].mintNumber.toString();
                                                      storedPriceController[index].text = data.maoModel!.results![index].ap.toString();
                                                      storedDateController[index].text = data.maoModel!.results![index].ad.toString();
                                                    }));

                                                  },
                                                ),
                                              )
                                            : Expanded(
                                                flex: 3,
                                                child: InkWell(
                                                  child: Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors.white.withOpacity(.4),
                                                          width: 2,
                                                        ),
                                                        borderRadius: BorderRadius.circular(20.0),
                                                      ),
                                                      child: Icon(
                                                        Icons.clear,
                                                        color: AppColors.white.withOpacity(.4),
                                                        size: 17,
                                                      )),
                                                  onTap: () {
                                                    var body = {};
                                                    postData!
                                                        .deleteMAO(
                                                          data.maoModel!.results![index].id,
                                                          context,
                                                          body,
                                                          requestHeadersWithToken,
                                                        )
                                                        .whenComplete(() => getData!
                                                            .getMAO(widget.type.toString(), widget.id.toString()))
                                                        .whenComplete(() => storedMintController.removeAt(index))
                                                        .whenComplete(() => storedPriceController.removeAt(index))
                                                        .whenComplete(() => storedDateController.removeAt(index))
                                                        .whenComplete(() => Navigator.of(context).pop());
                                                    /*setState(() {
                                                  for(int l=0; l<data.maoModel!.results!.length;l++)
                                                    {
                                                      storedMintController.em;
                                                      storedPriceController = [];
                                                      storedDateController = [];
                                                      storedMintController.add(
                                                        TextEditingController(
                                                          text: data.maoModel!.results![index].mintNumber.toString(),
                                                        ),
                                                      );
                                                      storedPriceController.add(
                                                        TextEditingController(
                                                          text: data.maoModel!.results![index].ap.toString(),
                                                        ),
                                                      );
                                                      storedDateController.add(
                                                        TextEditingController(
                                                          text: data.maoModel!.results![index].ad.toString(),
                                                        ),
                                                      );
                                                    }
                                                });*/
                                                    printInfo(
                                                        info: body.toString() + requestHeadersWithToken.toString());
                                                  },
                                                ),
                                              ),
                                        AppSpaces.spaces_width_5,
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: addToListController.isEmpty || data.maoModel!.results!.isEmpty ? 0 : 20,
                    ),
                    //Save Button
                    Container(
                      height: addToListController.isEmpty ? 0 : Get.height * .055,
                      alignment: Alignment.topCenter,
                      child: addToListController.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: Get.width * .33,
                                    height: Get.height * .04,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [],
                                    ),
                                    child: Container(
                                      width: Get.width * .33,
                                      height: Get.height * .04,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff02072D),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.textColor),
                                      ),
                                    ),
                                  ),
                                ),
                                AppSpaces.spaces_width_15,
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    mintController.text="Enter Mint";
                                    var body = {
                                      "product": widget.id,
                                      "type": widget.type,
                                      "mints": [
                                        for (int i = 0; i < addToListController.length; i++)
                                          {
                                            "mint_number": addToListController[i].mintNumber1!.text.isEmpty ?"0.0":addToListController[i].mintNumber1!.text,
                                            "ap": addToListController[i].price!.text.isEmpty ? "0.0":addToListController[i].price!.text,
                                            "ad": addToListController[i].dateTime!.text
                                          }
                                      ]
                                    };

                                    if (_formKey.currentState!.validate()) {
                                      postData!
                                          .postMAO(
                                            context,
                                            body,
                                            requestHeadersWithToken,
                                          )
                                          .whenComplete(
                                              () => getData!.getMAO(widget.type.toString(), widget.id.toString()))
                                          .whenComplete(() => Navigator.of(context).pop())
                                          .whenComplete(() => Navigator.of(context).pop());
                                    }
                                    addToListController.clear();

                                    printInfo(info: body.toString() + requestHeadersWithToken.toString());
                                  },
                                  child: Container(
                                    width: Get.width * .33,
                                    height: Get.height * .04,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.textColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            )
          : Container();
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getMAO(widget.type.toString(), widget.id.toString());
    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 10;

    getData!.getMAO(widget.type.toString(), widget.id.toString(), offset: offset);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
