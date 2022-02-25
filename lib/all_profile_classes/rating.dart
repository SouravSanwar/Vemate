import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';


class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  final _dialog = RatingDialog(
    // your app's name?
    title: Text('Rate Us On App Store'),
    // encourage your user to leave a high rating?
    message:
    Text('Select Number of Stars 1 - 5 to Rate This App'),
    // your app's logo?
    image: const FlutterLogo(size: 60),
    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        //go to app store
        StoreRedirect.redirect(androidAppId: 'shri.complete.fitness.gymtrainingapp',iOSAppId: 'com.example.rating');
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
