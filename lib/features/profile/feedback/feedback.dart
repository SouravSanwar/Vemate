import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
class FeedbackScreen extends StatefulWidget {

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                15.0,
              ),
            ),
            gradient:AppColors.onBoardGradient ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              height: Get.height*.06,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                gradient: AppColors.onBoardBtnGradient
              ),
              child: Text("Feedback",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                    ),),

            ),

            SizedBox(height: Get.height*.05,),

            Text("Rate Your Experience",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                ),),
            SizedBox(height: Get.height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(icon: new Icon(Icons.star),
                  onPressed: ()=>setState((){
                    _myColorOne=Colors.orange;
                    _myColorTwo=Colors.grey;
                    _myColorThree=Colors.grey;
                    _myColorFour=Colors.grey;
                    _myColorFive=Colors.grey;
                  }),color: _myColorOne,),
                new IconButton(icon: new Icon(Icons.star),
                  onPressed: ()=>setState((){
                    _myColorOne=Colors.orange;
                    _myColorTwo=Colors.orange;
                    _myColorThree=Colors.grey;
                    _myColorFour=Colors.grey;
                    _myColorFive=Colors.grey;
                  }),color: _myColorTwo,),
                new IconButton(icon: new Icon(Icons.star), onPressed: ()=>setState((){
                  _myColorOne=Colors.orange;
                  _myColorTwo=Colors.orange;
                  _myColorThree=Colors.orange;
                  _myColorFour=Colors.grey;
                  _myColorFive=Colors.grey;
                }),color: _myColorThree,),
                new IconButton(icon: new Icon(Icons.star), onPressed: ()=>setState((){
                  _myColorOne=Colors.orange;
                  _myColorTwo=Colors.orange;
                  _myColorThree=Colors.orange;
                  _myColorFour=Colors.orange;
                  _myColorFive=Colors.grey;
                }),color: _myColorFour,),
                new IconButton(icon: new Icon(Icons.star), onPressed: ()=>setState((){
                  _myColorOne=Colors.orange;
                  _myColorTwo=Colors.orange;
                  _myColorThree=Colors.orange;
                  _myColorFour=Colors.orange;
                  _myColorFive=Colors.orange;
                }),color: _myColorFive,),
              ],

            ),

          ],
        ),

      ),
      contentPadding: const EdgeInsets.all(0.0),
    );

  }
}
