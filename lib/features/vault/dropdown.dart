import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  final Color? color;
  final bool? isHome;

  const DropDown(this.color, this.isHome,{Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? value = "24H";

  final items = ['24H', '7D', '30D', '60D', '1Y'];

  int selectIndex = 0;

  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: items.map(buildMenuItem).toList(),
      onChanged: (value) {
        setState(() {
          this.value = value;

          value == '24H'
              ? selectIndex = 0
              : value == '7D'
                  ? selectIndex = 1
                  : value == '30D'
                      ? selectIndex = 2
                      : value == '60D'
                          ? selectIndex = 3
                          : selectIndex = 4;

          widget.isHome==true
              ?getData!.getHomeVault(graphType: selectIndex)
              :getData!.getVaultStats(graphType: selectIndex);

          printInfo(info: 'Value value: ' + value.toString());
          printInfo(info: 'Value value Index: ' + selectIndex.toString());
        }); //get value when changed
      },
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 10,
      ),

      iconEnabledColor: Colors.white,
      //Icon color
      style: TextStyle(
          //te
          color: Colors.white,
          fontFamily: 'Inter', //Font color
          fontSize: 20.sp //font size on dropdown button
          ),
      dropdownColor: widget.color,
      underline: Container(),
      //dropdown background color
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));
}
