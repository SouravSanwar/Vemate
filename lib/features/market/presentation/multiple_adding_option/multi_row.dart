
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_info.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_row.dart';
import 'package:ketemaa/features/market/presentation/multiple_adding_option/mint_textfield.dart';

class Multiform extends StatefulWidget {
  const Multiform({Key? key}) : super(key: key);

  @override
  State<Multiform> createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  List<MintInfo> mint_info =[];
  List<MintRow> mint_row =[];
  TextEditingController mintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mint_row.clear();
    for(int i=0;i<mint_info.length;i++){
      mint_row.add(MintRow(
        mint_info: mint_info[i],
          deleteRow: (){onDelete(i);},
      ));
    }

    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      child:Container(
        height: Get.height * .6,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpaces.spaces_height_20,
            Row(
              children: [
                AppSpaces.spaces_width_10,
                MintTextField(
                    width: Get.width*.65,
                    labelText: 'Enter Mint',
                    textType: TextInputType.number,
                    controller: mintController),
                AppSpaces.spaces_width_5,
                InkWell(
                  child: Icon(Icons.add,size: 25,color: AppColors.grey,),
                  onTap: onAddForm,
                )

              ],
            ),
            AppSpaces.spaces_height_20,
            mint_info == 0 ?

            Container()
                : Container(
              height: Get.height*.4,
                  child: ListView.builder(
              itemCount: mint_info.length,
              itemBuilder: (_,i)=>mint_row[i],
            ),
                ),

            /*floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: onAddForm,
            ),*/
          ],
        ),
      )




    );
  }

  void onDelete(int index){
    setState(() {

      mint_info.removeAt(index);
    });
  }
  void onAddForm(){
    setState(() {
      mint_info.add(MintInfo());

    });
  }

  void onSave(){
    mint_row.forEach((element) { element.isValid();});
  }
}
