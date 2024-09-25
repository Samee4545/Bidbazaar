
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/drawerModel.dart';
import 'package:flutter/material.dart';

List<DrawerModel> getDrawerModelData(context) {
  List<DrawerModel> drawerModelList = [];

  drawerModelList
      .add(DrawerModel(icon: Icon(Icons.home_rounded), title: "Home"));

  drawerModelList
      .add(DrawerModel(icon: Icon(Icons.category_sharp), title: "Catagories"));

  drawerModelList
      .add(DrawerModel(icon: Icon(Icons.favorite), title: "Favirote"));

  drawerModelList
      .add(DrawerModel(icon: Icon(Icons.chat_bubble_outline), title: "Chat"));

  drawerModelList
      .add(DrawerModel(icon: Icon(Icons.account_circle), title: "Account"));  

  drawerModelList.add(DrawerModel(icon: Icon(Icons.share), title: "Share APK"));

  return drawerModelList;
}
