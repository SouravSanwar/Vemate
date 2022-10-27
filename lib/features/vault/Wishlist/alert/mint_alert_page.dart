import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import 'alertTextfield.dart';

int? frequencyIndex1;
int? TypeIndex1;
int? edition;

class MintAlertPage extends StatefulWidget {
  var results;
  String? origin;

  MintAlertPage({Key? key, this.results, this.origin}) : super(key: key);

  @override
  State<MintAlertPage> createState() => _MintAlertPageState();
}

class _MintAlertPageState extends State<MintAlertPage> {
  PostData? postData;
  TextEditingController valueController = TextEditingController(text: '1');
  TextEditingController mintController1 = TextEditingController(text: '1');
  TextEditingController mintController2 = TextEditingController();
  int value = 0;
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  bool? mintAlert = false;
  int j = 0;
  Column? textColumn;
  Column? rangeColumn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  String? frequencyValue = 'Once';
  var frequencyItems = [
    'Once',
    'Once a day',
    'Always',
  ];

  String? priceTypeValue = 'Is';
  var items = [
    'Is',
    'Below',
    'Above',
    'Between',
  ];

  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);
    mintController2.text= widget.results!.editions.toString();

    if (widget.results!.isProductAlert == true) {
      for (int i = 0; i < widget.results!.productAlertData!.length; i++) {
        if (widget.results!.productAlertData![i].type == 1) {
          setState(() {
            mintAlert = true;
            j = i;
          });
        }
      }
    }
    if (widget.results!.isProductAlert == true) {
      if (widget.results!.productAlertData![j].type == 1) {
        valueController.text = widget.results!.productAlertData![j].value.toInt().toString();
        mintController1.text = widget.results!.productAlertData![j].mintLow.toString();
        mintController2.text = widget.results!.productAlertData![j].mintUpper.toString();

        if (mintController1.text == "0.0") {
          mintController1.text = value.toString();
        }
        if (mintController2.text == "0.0") {
          mintController2.text = value.toString();
        }
        if (valueController.text == "0.0") {
          valueController.text = value.toString();
        }
      }
    }

    if (mintAlert == true) {
      frequencyValue = widget.results!.productAlertData![j].frequencyValue;

      priceTypeValue = widget.results!.productAlertData![j].typeValue;
    }

    frequencyValue == 'Once'
        ? frequencyIndex1 = 0
        : frequencyValue == 'Once a day'
            ? frequencyIndex1 = 1
            : frequencyIndex1 = 2;

    priceTypeValue == 'Below'
        ? TypeIndex1 = 4
        : priceTypeValue == 'Above'
            ? TypeIndex1 = 5
        : priceTypeValue == 'Between'
        ? TypeIndex1 = 6
            : TypeIndex1 = 8;

    edition = int.parse(widget.results!.editions.toString());
    print('object: ' + edition.toString());
    textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Value",
          style: TextStyle(fontSize: 18.0.sp, color: AppColors.textColor),
        ),
        SizedBox(
          height: 8.h,
        ),
        AlertTextField(
          height: Get.height * .03,
          controller: valueController,

        ),
      ],
    );
    rangeColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select range",
          style: TextStyle(fontSize: 18.0.sp, color: AppColors.white),
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Text(
              "From",
              style: TextStyle(fontSize: 16.0.sp, color: AppColors.white),
            ),
            AppSpaces.spaces_width_5,
            Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: AlertTextField(
                  height: Get.height * .03,
                  controller: mintController1,
                )),
            AppSpaces.spaces_width_5,
            Text(
              "To",
              style: TextStyle(fontSize: 16.0.sp, color: AppColors.white),
            ),
            AppSpaces.spaces_width_5,
            Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: AlertTextField(
                  height: Get.height * .03,
                  controller: mintController2,
                )),
          ],
        ),

      ],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 14.h,
          ),
          Text(
            "Frequency",
            style: TextStyle(fontSize: 18.0.sp, color: AppColors.textColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                  color: AppColors.textColor, // set border color
                  width: 1.w), // set border width
              borderRadius: const BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: frequencyValue,
              items: frequencyItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  frequencyValue = value;

                  frequencyValue == 'Once'
                      ? frequencyIndex1 = 0
                      : frequencyValue == 'Once a day'
                          ? frequencyIndex1 = 1
                          : frequencyIndex1 = 2;
                }); //get value when changed
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),

              iconEnabledColor: Colors.grey,
              //Icon color
              style: TextStyle(
                  //te
                  color: AppColors.grey,
                  fontFamily: 'Inter', //Font color
                  fontSize: 20.sp //font size on dropdown button
                  ),
              dropdownColor: AppColors.backgroundColor,
              underline: Container(),
              //dropdown background color
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Text(
            "Type",
            style: TextStyle(fontSize: 18.0.sp, color: AppColors.textColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                  color: AppColors.textColor, // set border color
                  width: 1.w), // set border width
              borderRadius: const BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: priceTypeValue,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  priceTypeValue = value;

                  value == 'Below'
                      ? TypeIndex1 = 4
                      : value == 'Above'
                          ? TypeIndex1 = 5
                      : value == 'Between'
                      ? TypeIndex1 = 6
                          : TypeIndex1 = 8;
                  print(TypeIndex1);
                }); //get value when changed
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),

              iconEnabledColor: Colors.grey,
              //Icon color
              style: TextStyle(
                  //te
                  color: AppColors.grey, //Font color
                  fontSize: 20.sp //font size on dropdown button
                  ),
              dropdownColor: AppColors.backgroundColor,
              underline: Container(),
              //dropdown background color
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          mintAlert == true
              ? (widget.results!.productAlertData![j].priceType == 6 && TypeIndex1 == 6
                  ? rangeColumn!
                  : widget.results!.productAlertData![j].priceType == 6 && TypeIndex1 != 6
                      ? textColumn!
                      : widget.results!.productAlertData![j].priceType != 6 && TypeIndex1 != 6
                          ? textColumn!
                          : rangeColumn!)
              : TypeIndex1 == 6
                  ? rangeColumn!
                  : textColumn!,

          SizedBox(
            height: 8.h,
          ),
          Text(
            "Maximum mint value is " + widget.results!.editions.toString()+ " for this product",
            style: TextStyle(fontSize: 10.0.sp, color: Colors.white,fontFamily: 'Inter'),
          ),
          SizedBox(
            height: 25.h,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    postData = Provider.of<PostData>(context, listen: false);
                    postData!.deleteAlert(context, widget.results!.productAlertData![j].id, requestHeadersWithToken,
                        widget.origin, widget.results!.id,from: 'mint').whenComplete(() => getData!.getAlert());
                  },
                  child: Text(
                    widget.results!.productAlertData != null && mintAlert == true ? 'Delete' : "",
                    style: TextStyle(fontSize: 16.0.sp, color: AppColors.grey),
                  ),
                ),
                AppSpaces.spaces_width_10,
                InkWell(
                  onTap: () async {
                    printInfo(
                        info: 'Info: ' + int.parse(mintController2.text.toString()).toString() + edition.toString());

                    if(TypeIndex1==6 && (mintController1.text == "" || mintController2.text =="")){
                        showResponse();
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.of(context).pop();
                    }
                    if(TypeIndex1 !=6 && valueController.text == ""){
                      showResponse();
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.of(context).pop();
                    }

                      if (int.parse(mintController2.text.toString()) > edition! || double.parse(valueController.text.toString()).toInt() > edition!  ) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => ResponseMessage(
                              icon: Icons.error,
                              color: Colors.purpleAccent,
                                  message: "Maximum mint number is " + edition.toString(),
                                ));
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.of(context).pop();
                      }
                       else {

                        if (int.parse(mintController1.text.toString())>int.parse(mintController2.text.toString())) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const ResponseMessage(
                                icon: Icons.error,
                                color: Colors.purpleAccent,
                                message: "The range must be from low to high",
                              ));
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.of(context).pop();
                        }
                        else{

                            postData = Provider.of<PostData>(context, listen: false);
                            var body = {
                              "product": widget.results!.id,
                              "type": 1,
                              "price_type": TypeIndex1,
                              "value": valueController.text != "" ? double.parse(valueController.text) : null,
                              "frequency": frequencyIndex1,
                              "mint_low": mintController1.text != "" ? double.parse(mintController1.text).toInt() : null,
                              "mint_upper": mintController2.text != "" ? double.parse(mintController2.text).toInt() : null,
                            };
                            postData!.createAlert(context, body, widget.origin!, widget.results!.id).whenComplete(() => getData!.getAlert());
                          }

                      }
                    },
                  child: Text(
                    widget.results!.productAlertData != null && mintAlert == true ? 'Update' : "Save",
                    style: TextStyle(fontSize: 16.0.sp, color: Colors.purpleAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));

  Future<void> showResponse() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const ResponseMessage(
          icon: Icons.error,
          color: Colors.purpleAccent,
          message: "Text field is empty",
        ));
  }


}
