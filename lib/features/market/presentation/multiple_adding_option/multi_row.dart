import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/model/MultiRowModel.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_info.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_row.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';

class Multiform extends StatefulWidget {
  const Multiform({Key? key}) : super(key: key);

  @override
  State<Multiform> createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  List<MintInfo> mint_info = [];
  List<MintRow> mint_row = [];
  TextEditingController mintController = TextEditingController();

  List<MultiRowModel> addToListController = [
    MultiRowModel(
      TextEditingController(),
      TextEditingController(),
      DateTime(2022),
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
        height: addToListController.length * 50 + (125 - (addToListController.length * 10)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppSpaces.spaces_height_10,
            Row(
              children: [
                AppSpaces.spaces_width_10,
                MintTextField(
                    width: Get.width * .65,
                    labelText: 'Enter Mint',
                    textType: TextInputType.number,
                    controller: mintController),
                AppSpaces.spaces_width_5,
                InkWell(
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    printInfo(info: addToListController.length.toString());

                    setState(() {
                      addToListController.add(
                        MultiRowModel(
                          TextEditingController(text: mintController.text),
                          TextEditingController(),
                          DateTime(2022),
                        ),
                      );
                    });
                  },
                )
              ],
            ),
            AppSpaces.spaces_height_10,
            ListView.builder(
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
                        // onsaved: (value) => widget.mint_info!.mint_number = value as int?,
                        controller: addToListController[index].mintNumber1!),
                    AppSpaces.spaces_width_5,
                    MintTextField(
                        width: Get.width * .21,
                        labelText: 'Price',
                        textType: TextInputType.number,
                        // onsaved: (value) => widget.mint_info!.purchase_price = value as double?,
                        controller: addToListController[index].mintNumber2!),
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
                          Text(
                            addToListController[index].dateTime!.year.toString(),
                            style: TextStyle(
                              fontSize: 10,
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
                                backgroundColor: Color(0xff02072D),
                                textColor: AppColors.white.withOpacity(.7),
                              );
                              setState(() {
                                // textDate = datePicked;
                              });
                              final snackBar = SnackBar(content: Text("Date Picked $datePicked"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                      onTap: () {
                        if (addToListController.isNotEmpty) {
                          setState(() {
                            addToListController.removeAt(index);
                          });
                        }
                      },
                    )
                  ],
                );
              },
            ),
            addToListController.isNotEmpty
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
    );
  }

  void onDelete(int index) {
    setState(() {
      mint_info.removeAt(index);
    });
  }

  void onAddForm() {
    setState(() {
      mint_info.add(MintInfo());
    });
  }

  void onSave() {
    mint_row.forEach((element) {
      element.isValid();
    });
  }
}
