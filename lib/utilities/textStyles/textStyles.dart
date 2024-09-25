import 'package:flutter/material.dart';

TextStyle textStyleH3(color) {
  return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: color);
}

TextStyle textStyleAppBarTitle(appBarColorChange) {
  return TextStyle(
    fontSize: 20,
    color: appBarColorChange ? Colors.black : Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyleEllipsis() {
  return const TextStyle(overflow: TextOverflow.ellipsis);
}

TextStyle textStyleH2(color) {
  return TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color);
}

TextStyle textStyleSimpleTitle(weight) {
  return TextStyle(
      color: Colors.black, fontWeight: weight, overflow: TextOverflow.ellipsis);
}

TextStyle textStyleBold(Color color) {
  return TextStyle(fontWeight: FontWeight.bold, color: color);
}

TextStyle textStyleColor(Color color) {
  return TextStyle(color: color);
}

TextStyle textStyle300Weight() {
  return const TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
}

TextStyle textStyle300WeightLight() {
  return const TextStyle(
    fontWeight: FontWeight.w300,
  );
}

TextStyle textStyleSubTitle(color) {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);
}
