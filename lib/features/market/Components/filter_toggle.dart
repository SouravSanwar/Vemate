import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class FilterToggleButton extends StatefulWidget {
  final VoidCallback? onTap;
  const FilterToggleButton({Key? key,this.onTap,}) : super(key: key);

  @override
  _FilterToggleButtonState createState() => _FilterToggleButtonState();
}

class _FilterToggleButtonState extends State<FilterToggleButton> {
  /*int? mode=prefs?.getInt('mode');*/
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
            height: 20.0.h,
            width: 40.0.w,
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
                  left: darkMode == true ? 20.0 : 0.0,
                  right: darkMode == true ? 0.0 : 20.0,
                  child: InkWell(
                    onTap: () async {

                    },
                    child: Container(
                      alignment: mode == 1
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      height: 10.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child:Container()
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
