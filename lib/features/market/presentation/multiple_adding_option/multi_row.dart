import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/model/MultiRowModel.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/date_picker.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/Date_Picker/i18n/date_picker_i18n.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';

class Multiform extends StatefulWidget {
  const Multiform({Key? key}) : super(key: key);

  @override
  State<Multiform> createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  TextEditingController mintController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? textDate = DateTime.now();

  List<MultiRowModel> addToListController = [
    MultiRowModel(
      TextEditingController(),
      TextEditingController(),
      DateTime.now(),
    )
  ];

  @override
  void initState() {
    addToListController.length = 0;
    super.initState();
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

    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      textType: TextInputType.datetime,
                      controller: mintController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter mint number';
                        }
                      },
                    ),
                  ),
                  AppSpaces.spaces_width_5,
                  Container(
                    height: Get.height*.065,
                    alignment: Alignment.topCenter,
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
                                DateTime(textDate!.year,textDate!.month,textDate!.day),
                              ),
                            );
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
              AppSpaces.spaces_height_15,
              Container(
                height: addToListController.length < 10 ?addToListController.length*(Get.height*.055)-(addToListController.length*5)
                                                       : (Get.height*.55-50),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: addToListController.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AppSpaces.spaces_height_5,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppSpaces.spaces_width_5,
                            MintTextField(
                                width: Get.width * .21,
                                labelText: 'Mint Number',
                                textType: TextInputType.number,
                                // onsaved: (value) => widget.mint_info!.mint_number = value as int?,
                                controller:
                                    addToListController[index].mintNumber1!),
                            AppSpaces.spaces_width_5,
                            MintTextField(
                                width: Get.width * .21,
                                labelText: 'Price',
                                textType: TextInputType.number,
                                // onsaved: (value) => widget.mint_info!.purchase_price = value as double?,
                                controller:
                                    addToListController[index].mintNumber2!),
                            AppSpaces.spaces_width_5,
                            Container(
                              width: Get.width * .23,
                              height: Get.height * .036,
                              padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
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
                                  Text(
                                    addToListController[index]
                                            .dateTime!
                                            .day
                                            .toString() +
                                        '-' +
                                        addToListController[index]
                                            .dateTime!
                                            .month
                                            .toString() +
                                        '-' +
                                        addToListController[index]
                                            .dateTime!
                                            .year
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white.withOpacity(.7),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var datePicked =
                                          await DatePicker.showSimpleDatePicker(
                                        context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2015),
                                        lastDate: DateTime.now(),
                                        dateFormat: "dd-MM-yyyy",
                                        locale: DateTimePickerLocale.en_us,
                                        looping: true,
                                        backgroundColor: Color(0xff02072D),
                                        textColor:
                                            AppColors.white.withOpacity(.7),
                                      );
                                      setState(() {
                                        textDate = datePicked;
                                        print(addToListController[index]
                                            .dateTime);
                                      });
                                      final snackBar = SnackBar(
                                          content:
                                              Text("Date Picked $datePicked"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
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
                        ),
                      ],
                    );
                  },
                ),
              ),
              AppSpaces.spaces_height_10,
              addToListController.length != 0
                  ? TextButton(
                      onPressed: () {
                        printInfo(info: addToListController.length.toString());
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
        ),
      ),
    );
  }
}
