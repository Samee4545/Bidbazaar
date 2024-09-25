
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/catagoriesModel.dart';
import 'package:flutter/material.dart';

List<CatagoriesModel> getCatagoriesModelData(context) {
  List<CatagoriesModel> catagoriesModelList = [];

  catagoriesModelList.add(CatagoriesModel(
      icon: Icons.phone_android_rounded, title: "Mobile Phones"));

  catagoriesModelList.add(
      CatagoriesModel(icon: Icons.directions_car_rounded, title: "Vechicles"));

  catagoriesModelList
      .add(CatagoriesModel(icon: Icons.pedal_bike_rounded, title: "Bikes"));

  catagoriesModelList
      .add(CatagoriesModel(icon: Icons.tv_rounded, title: "Electronics"));

  catagoriesModelList
      .add(CatagoriesModel(icon: Icons.bed_rounded, title: "Furnitures"));

  catagoriesModelList
      .add(CatagoriesModel(icon: Icons.menu_book_rounded, title: "Books"));

  return catagoriesModelList;
}
