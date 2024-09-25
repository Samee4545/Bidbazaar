import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/inputTextField.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/commonOutlinedButton.dart';
import 'package:flutter/material.dart';

Widget changePasswordModelBottomSheet(context) {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();

  return Container(
    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 24),
    height: 420,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Password Change",
              style: textStyleH3(Colors.black),
            ),
            const Icon(
              Icons.cancel,
              size: 28,
            )
          ],
        ),
        const SizedBox(height: 20),
        inputTextField(context, Icons.person_2_rounded, "Old Password",
            oldPasswordController),
        Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text("Forgot Password?"),
            )),
        const SizedBox(height: 20),
        inputTextField(context, Icons.date_range_rounded, "New Password",
            newPasswordController),
        const SizedBox(height: 40),
        inputTextField(context, Icons.date_range_rounded, "Repeat New Password",
            repeatNewPasswordController),
        const SizedBox(height: 40),
        commonOutlinedButton(context, "Save Password", commonButtonColor)
      ],
    ),
  );
}
