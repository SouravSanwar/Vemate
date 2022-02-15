import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/features/home/data/models/all_category_model.dart';
import 'package:ketemaa/features/home/data/models/property_rent_model.dart';
import 'package:ketemaa/features/home/data/remotedatarepo/home_remote_repository.dart';
import 'package:ketemaa/features/home/data/repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find();

  final HomeRepository _homeRepository = HomeRemoteRepository();

  Rx<CategoryModel> categoryModel = CategoryModel().obs;

  Rx<PropertyRentModel> propertyRentModel = PropertyRentModel().obs;

  RxBool? descriptionExtended = false.obs;

  RxBool? amenitiesExtended = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  fetchHomeCategoryData() async {
    Either<QueryResult, Failure> _response = await _homeRepository.category();
    _response.fold((l) {
      //printInfo(info: " Success Data :: " + l.data.toString());
      try {
        categoryModel.value = CategoryModel.fromJson(l.data!);
      } on Exception catch (e) {
        Right(DataNotFound());
      }
    }, (r) => printInfo(info: r.toString()));
  }

  fetchRentPropertiesData(var city) async {
    Either<QueryResult, Failure> _response =
        await _homeRepository.propertyForRent(
      city: "$city",
    );
    _response.fold((l) {
      //printInfo(info: " Success Data :: " + l.data.toString());
      try {
        propertyRentModel.value = PropertyRentModel.fromJson(l.data!);
      } on Exception catch (e) {
        Right(DataNotFound());
      }
    }, (r) => printInfo(info: r.toString()));
  }
}
