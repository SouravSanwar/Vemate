import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ketemaa/main.dart';

class StatusBar extends StatefulWidget {


  const StatusBar({Key? key}) : super(key: key);

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(mode==0){
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark

        ));
      }
    });
    return Container();
  }
}
