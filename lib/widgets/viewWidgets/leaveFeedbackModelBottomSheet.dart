import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/commonOutlinedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget leaveFeedbackModelBottomSheet(context) {
  return Container(
    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 24),
    height: 420,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "What is your rate?",
          style: textStyleH3(Colors.black),
        ),
        const SizedBox(height: 20),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.orange,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text("Please share your opinion about the product",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        const SizedBox(height: 20),
        const TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Your review...',
            border: OutlineInputBorder(),
          ),
        ),
        const Spacer(),
        const SizedBox(height: 20),
        commonOutlinedButton(context, "Send Feedback", commonButtonColor)
      ],
    ),
  );
}
