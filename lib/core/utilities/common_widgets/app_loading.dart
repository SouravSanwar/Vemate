import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppDimension.loading_widget_size,
        width: AppDimension.loading_widget_size,
        decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimension.radious)),
            /*boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: AppDimension.spreadRadius,
                  blurRadius: AppDimension.blurRadius)
            ]*/),
        child: Padding(
          padding: EdgeInsets.all(AppDimension.padding_8),
          child: const LoadingIndicator(
            indicatorType: Indicator.lineSpinFadeLoader,
            strokeWidth: 0.1,
          ),
        ));
  }
}
