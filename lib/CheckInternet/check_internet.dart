import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool? checkInternet=true;

 getConnection() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    checkInternet=true;
    print("Mobile data connected");
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    checkInternet=true;
    print("Wifi connected");
  }
  else  {
    checkInternet=false;
    print("No Internet Connection");
    Get.snackbar(
      "No Internet",
      "Please check your internet connection",
      colorText: Colors.red,
      snackPosition: SnackPosition.BOTTOM,

    );
  }
}