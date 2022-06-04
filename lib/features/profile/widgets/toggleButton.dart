import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
class ToggleButton extends StatefulWidget {

  const ToggleButton({Key? key}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  /*int? mode=prefs?.getInt('mode');*/
  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<AppColors>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(
                      () => ControllerPage());
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.only(left: 2, right: 2),
            duration: Duration(milliseconds: 100),
            height: 30.0,
            width: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: darkMode == true ? Colors.purple : Colors.grey,
            ),
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    top: 3.0,
                    left: darkMode  == true ? 30.0 : 0.0,
                    right: darkMode  == true ? 0.0 : 30.0,
                    child: InkWell(
                      onTap: () async {
                        prefs = await SharedPreferences.getInstance();
                        if(prefs?.getInt('mode')==1){
                          prefs!.setInt('mode', 0) ;
                          setState(() {
                            darkMode =true;
                          });
                        }
                        else if(prefs?.getInt('mode')==0){
                          prefs!.setInt('mode', 1) ;
                          setState(() {
                            darkMode =false;
                          });
                        }
                        else{
                          prefs!.setInt('mode', 0) ;
                          setState(() {
                            darkMode =true;
                          });
                        }
                        appStyleMode.switchMode();


                        print(prefs?.getInt('mode'));//eta soman 1/0 check kora lagbe

                      },
                      child:  Container(
                        alignment: darkMode  == true ?Alignment.centerLeft :Alignment.centerLeft ,
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                          child: Icon(darkMode == true ?Icons.dark_mode : Icons.light_mode )
                      ),

                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

