import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_info.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';
import '../../../../core/utilities/app_spaces/app_spaces.dart';

class MintRow extends StatefulWidget {
  MintInfo? mint_info;
  final state = _MintRowState();
  dynamic deleteRow;

  MintRow({Key? key, this.mint_info, this.deleteRow}) : super(key: key);

  @override
  State<MintRow> createState() => state;

  bool? isValid() => state.validate();
}

class _MintRowState extends State<MintRow> {
  TextEditingController mintController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final form = GlobalKey<FormState>();

  DateTime? textDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Form(
          key: form,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppSpaces.spaces_width_5,
              MintTextField(
                  width: Get.width * .21,
                  labelText: 'Mint Number',
                  textType: TextInputType.number,
                  onsaved: (value) => widget.mint_info!.mint_number = value as int?,
                  controller: mintController),
              AppSpaces.spaces_width_5,
              MintTextField(
                  width: Get.width * .21,
                  labelText: 'Mint Number',
                  textType: TextInputType.number,
                  onsaved: (value) => widget.mint_info!.purchase_price = value as double?,
                  controller: mintController),
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
                      textDate!.day.toString() + '-' + textDate!.month.toString() + '-' + textDate!.year.toString(),
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
                          textDate = datePicked;
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
                onTap: widget.deleteRow,
              )
            ],
          )),
    );
  }

  //form validation

  bool? validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}
