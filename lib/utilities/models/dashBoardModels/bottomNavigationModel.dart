import 'package:flutter/material.dart';

class BottomNavigationModel {
  String? title;
  dynamic? launchPage;
  IconData? icon;
  IconData? alternateIcon;
  Color? color;

  BottomNavigationModel(
      {this.title, this.launchPage, this.icon, this.alternateIcon, this.color});
}
