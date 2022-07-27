import 'package:flutter/material.dart';

circularProgress(){
  return  Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 30,
        height: 30,
        child: Image.asset(
          'assets/media/icon/logo_v.png',
          fit: BoxFit.fill,
        ),
      ),
      // you can replace
      Container(
        width: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Colors.grey,

          ),
          strokeWidth: 0.7,
        ),
      )
    ],
  );

}

LinearProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
          Colors.red
      ),
    ),
  );

}