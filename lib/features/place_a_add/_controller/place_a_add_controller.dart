import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/features/place_a_add/data/models/city_model.dart';
import 'package:ketemaa/features/place_a_add/data/remotedatarepo/place_add_remote_repository.dart';
import 'package:ketemaa/features/place_a_add/data/repository/place_add_repository.dart';

class PlaceAddController extends GetxController {
  static PlaceAddController to = Get.find();

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No Image');
    }
  }

  Rx<int> currentPage = 0.obs;

  RxInt cityCheckedIndex = 100000000000000000.obs;

  final PlaceAddRepository _placeAddRepository = PlaceAddRemoteRepository();

  List<String> bedrooms = ['1', '2', '3'];
  List<String> bathrooms = ['1', '2', '3'];
  List<String> furnished = ['Yes', 'No'];
  List<String> rentPaid = ['Yes', 'No'];
  List<String> propertyStatus = ['New', 'Used'];
  List<String> occupaacyStatus = ['OS-1', 'OS-2'];

  //Property Rent Form Text _controller
  TextEditingController propertyRentTitleFieldController =
      TextEditingController();
  TextEditingController propertyRent360FieldController =
      TextEditingController();
  TextEditingController propertyRentYoutubeFieldController =
      TextEditingController();
  TextEditingController propertyRentPhoneFieldController =
      TextEditingController();
  TextEditingController propertyRentPriceFieldController =
      TextEditingController();
  TextEditingController propertyRentDescriptionFieldController =
      TextEditingController();
  TextEditingController propertyRentSizeFieldController =
      TextEditingController();
  TextEditingController propertyRentBedroomFieldController =
      TextEditingController();
  TextEditingController propertyRentBathroomFieldController =
      TextEditingController();
  TextEditingController propertyRentRefIDFieldController =
      TextEditingController();
  TextEditingController propertyRentRERALandlordNameFieldController =
      TextEditingController();
  TextEditingController propertyRentDeedFieldController =
      TextEditingController();
  TextEditingController propertyRentPreRegFieldController =
      TextEditingController();
  TextEditingController propertyRentContactFieldController =
      TextEditingController();
  TextEditingController propertyRentNoticeFieldController =
      TextEditingController();
  TextEditingController propertyRentMaintainFeeFieldController =
      TextEditingController();
  TextEditingController propertyRentBuildingFieldController =
      TextEditingController();
  TextEditingController propertyRentNeighbourFieldController =
      TextEditingController();
  TextEditingController propertyRentFurnishedFieldController =
      TextEditingController();
  TextEditingController propertyRentRentPaidFieldController =
      TextEditingController();
  TextEditingController propertyRentPropertyStatusFieldController =
      TextEditingController();
  TextEditingController propertyRentOccupaacyStatusFieldController =
      TextEditingController();

  Rx onChangedValue = 0.obs;

  RxBool titleSubmitButton = false.obs;

  Rx<CityModel> cityModel = CityModel().obs;

  fetchCityData() async {
    Either<QueryResult, Failure> _response =
        await _placeAddRepository.placeAddCities();
    _response.fold((l) {
      //printInfo(info: " Success Data :: " + l.data.toString());
      try {
        cityModel.value = CityModel.fromJson(l.data!);
      } on Exception catch (e) {
        Right(DataNotFound());
      }
      /*printInfo(info:" Error Data :: "  + categoryModel.value.categories!.edges![0].node!.name.toString());*/
    }, (r) => printInfo(info: r.toString()));
  }
}
