import 'package:flutter/material.dart';

circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.green,
      ),
    ),
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