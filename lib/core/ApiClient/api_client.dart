/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/utilities/urls/urls.dart';

class APIManager {
  var publicKey = 'pk_267624ff9adb23a3e0d054aa7ac4d5efde482e3e13016';
  var secretKey = 'sk_26762ffb0c571a9139d720e6dc0470fd9e126d01cbed4';
  var baseURL = 'https://gofood.com';



  Future getCategory() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Authorization': '$publicKey',
    };

    var client = http.Client();
    var categorymodel = null;

    try {
      var response = await client.get(Uri.parse(Urls.collectibles),
          headers: requestHeaders);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        categorymodel = Category.fromJson(jsonMap);
      }
    } catch (e) {
      print("Exception : $e");
      //return categorymodel;
    }
    return categorymodel;
  }

}*/
