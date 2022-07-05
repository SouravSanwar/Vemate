import 'package:flutter/material.dart';

import 'package:ketemaa/core/utilities/shimmer/progress_bar.dart';

class LoadingDialogue extends StatelessWidget {
  final String? message;

  const LoadingDialogue({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: AlertDialog(
          key: key,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              circularProgress(),
              const SizedBox(
                height: 10,
              ),
              Text(message! + " ...")
            ],
          ),
        ),
      ),
    );
  }
}
