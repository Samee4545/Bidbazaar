import 'package:flutter/material.dart';

Widget videoUploaderView(context) {
  return Stack(children: [
    Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(.9),
        ),
      ),
      child: const Center(child: Text("Display Video Thumbnail")),
    ),
  ]);
}
