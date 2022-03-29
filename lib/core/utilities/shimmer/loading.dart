import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingExample extends StatefulWidget {
  const LoadingExample({ Key? key }) : super(key: key);

  @override
  _LoadingExampleState createState() => _LoadingExampleState();
}

class _LoadingExampleState extends State<LoadingExample> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 100,
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulseSync,
              colors: [
                Color(0xff8760EE),
                Color(0xffA984E5),
                Color(0xffCA88E8),],
              strokeWidth: 2,
            ),
          ),


        ],
      ),
    );
  }
}
