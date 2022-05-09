import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BackPreviousScreen extends StatelessWidget{
  const BackPreviousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .03),
              alignment: Alignment.topLeft,
              child:InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              )
    );
  }

}