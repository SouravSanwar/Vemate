import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class ReportStepCard extends StatefulWidget {
  final String? stepName;
  final VoidCallback? onTap;
  final bool? selected;

  const ReportStepCard({
    Key? key,
    this.stepName,
    this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  State<ReportStepCard> createState() => _ReportStepCardState();
}

class _ReportStepCardState extends State<ReportStepCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: widget.selected == true ?
             const LinearGradient(

               colors: [
                 Colors.transparent,
                 Colors.transparent,
               ],
            )
                : const LinearGradient(
              colors: [
                Color(0xff3E457B),
                Color(0xff3E457B),
              ],
            ),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: widget.selected == true ? Color(0xffA282F2) : Colors.transparent,)
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
            child: Text(
              widget.stepName.toString(),
              style: Get.textTheme.titleSmall!.copyWith(
                  color: widget.selected == true ? Colors.white : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
