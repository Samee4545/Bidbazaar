import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget productTitleDesView(context, bool quantity) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Iphone 14 pro max, Condition 10/10 With cheap rate",
            maxLines: 2,
            style: textStyleH3(Colors.black),
          ),
          quantity ? const SizedBox(height: 16) : const SizedBox(),
          quantity
              ? Row(
                  children: [
                    Text(
                      "Required Quantity: ",
                      style: textStyleSimpleTitle(FontWeight.w700),
                    ),
                    Text("12", style: textStyleH3(Colors.black))
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 12),
          Text(
              "Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/10 Iphone 14 pro max, Condition 10/1",
              maxLines: 10,
              style: textStyleSimpleTitle(FontWeight.w400)),
        ],
      ),
    ),
  );
}
