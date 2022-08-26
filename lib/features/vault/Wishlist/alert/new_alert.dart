import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';




class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key}) : super(key: key);

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  GetData? getData;
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    getData = Provider.of<GetData>(context, listen: false);
    // TODO: implement initState
    super.initState();
    sampleData.add( RadioModel(true, '24H'));
    sampleData.add( RadioModel(false, '7D'));
    sampleData.add(RadioModel(false, '30D'));
    sampleData.add(RadioModel(false, '60D'));
    sampleData.add(RadioModel(false, '1Y'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("ListItem"),
      ),
      body: GridView.builder(
        itemCount: sampleData.length,
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //highlightColor: Colors.red,
            splashColor: AppColors.backgroundColor,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                setState(() {
                  getData!.getVaultStats();
                });
              });
            },
            child: RadioItem(sampleData[index]),
          );
        },
      )
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  const RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .18,
      padding: const EdgeInsets.only(
          top: 0, bottom: 8, left: 6, right: 6),
     child: Center(
       child: Text(_item.buttonText,
           style: TextStyle(
               color:
               _item.isSelected ? Colors.white : Colors.black,
               //fontWeight: FontWeight.bold,
               fontSize: 18.0)),
     ),
     decoration: BoxDecoration(
       color: _item.isSelected
           ? Colors.blueAccent
           : Colors.transparent,
       border: Border.all(
           width: 1.0,
           color: _item.isSelected
               ? Colors.blueAccent
               : Colors.grey),
       borderRadius: const BorderRadius.all( Radius.circular(2.0)),
     ),
        );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}