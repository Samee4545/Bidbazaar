import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget commonOutlinedButton(context, String label, color) {
  return Container(
    height: 48,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: Colors.black.withOpacity(.9),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Center(
        child: Text(
      label,
      style: textStyleH2(color == commonButtonColor ? blackColor : whiteColor),
    )),
  );
}
