import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class RatingStars extends StatefulWidget {
  static int ratingValue=0;
  const RatingStars({Key? key}) : super(key: key);

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {

  var _myColorOne = AppColors.white;
  var _myColorTwo = AppColors.white;
  var _myColorThree = AppColors.white;
  var _myColorFour = AppColors.white;
  var _myColorFive = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.star,
            size: 35,
          ),
          onPressed: ()=>setState((){
            RatingStars.ratingValue=1;
            _myColorOne=const Color(0xFF18C5F2);
            _myColorTwo=AppColors.white;
            _myColorThree=AppColors.white;
            _myColorFour=AppColors.white;
            _myColorFive=AppColors.white;
          }),
          color: _myColorOne,),
        IconButton(
          icon: const Icon(
            Icons.star,
            size: 35,
          ),
          onPressed: ()=>setState((){
            RatingStars.ratingValue=2;
            _myColorOne=const Color(0xFF18C5F2);
            _myColorTwo=const Color(0xFF18C5F2);
            _myColorThree=AppColors.white;
            _myColorFour=AppColors.white;
            _myColorFive=AppColors.white;
          }),color: _myColorTwo,),
        IconButton(
          icon: const Icon(
            Icons.star,
            size: 35,
          ),
          onPressed: ()=>setState((){
            RatingStars.ratingValue=3;
            _myColorOne=const Color(0xFF18C5F2);
            _myColorTwo=const Color(0xFF18C5F2);
            _myColorThree=const Color(0xFF18C5F2);
            _myColorFour=AppColors.white;
            _myColorFive=AppColors.white;
          }),color: _myColorThree,),
        IconButton(
          icon: const Icon(
            Icons.star,
            size: 35,
          ),
          onPressed: ()=>setState((){
            RatingStars.ratingValue=4;
            _myColorOne=const Color(0xFF18C5F2);
            _myColorTwo=const Color(0xFF18C5F2);
            _myColorThree=const Color(0xFF18C5F2);
            _myColorFour=const Color(0xFF18C5F2);
            _myColorFive=AppColors.white;
          }),color: _myColorFour,),
        IconButton(
          icon: const Icon(
            Icons.star,
            size: 35,
          ),
          onPressed: ()=>setState((){
            RatingStars.ratingValue=5;
            _myColorOne=const Color(0xFF18C5F2);
            _myColorTwo=const Color(0xFF18C5F2);
            _myColorThree=const Color(0xFF18C5F2);
            _myColorFour=const Color(0xFF18C5F2);
            _myColorFive=const Color(0xFF18C5F2);
          }),color: _myColorFive,),
      ],

    );
  }
}
