import 'package:flutter/material.dart';

Widget inputTextField(
    context, IconData icon, String hintText, currentController) {
  return Container(
    height: 48,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.black.withOpacity(.9),
      ),
    ),
    child: TextField(
      style: TextStyle(color: Colors.black.withOpacity(.9)),
      controller: currentController,
      onChanged: (value) {
        currentController = value;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(.7),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black.withOpacity(.5),
        ),
      ),
    ),
  );
}
