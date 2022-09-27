import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback? onTap;
  const ToggleButton({Key? key,this.onTap,}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {


  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<AppColors>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            padding: EdgeInsets.only(left: 2, right: 2),
            duration: Duration(milliseconds: 100),
            height: 30.0.h,
            width: 60.0.w,
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
                  left: darkMode == true ? 30.0 : 0.0,
                  right: darkMode == true ? 0.0 : 30.0,
                  child: InkWell(
                    onTap: () async {
                      prefs = await SharedPreferences.getInstance();
                      if (mode == 1) {
                        setState(() {
                          prefs!.setInt('mode', 0);
                          darkMode = true;
                        });
                      } else if (mode == 0) {
                        setState(() {
                          prefs!.setInt('mode', 1);
                          darkMode = false;
                        });
                      } else {
                        setState(() {
                          prefs!.setInt('mode', 0);
                          darkMode = true;
                        });
                      }
                      appStyleMode.switchMode();

                    },
                    child: Container(
                      alignment: mode == 1
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      height: 15.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child:
                          Icon(mode == 1 ? Icons.dark_mode : Icons.light_mode),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
