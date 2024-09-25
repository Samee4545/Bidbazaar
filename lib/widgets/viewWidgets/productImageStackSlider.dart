import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget productImageStackSlider(context, String sellerName, String offerPrice) {
  return Stack(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
      ),
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        child: Container(
            height: MediaQuery.of(context).size.height / 2.12,
            color: Colors.orange),
      ),
      Positioned(
        top: 48,
        left: 16,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: ClipOval(
            child: Container(
              height: 44,
              width: 44,
              color: Colors.black.withOpacity(.6),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: MediaQuery.of(context).size.width / 11,
        left: MediaQuery.of(context).size.width / 11,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.22,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade300,
            border: Border.all(
              color: Colors.black.withOpacity(.9),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sellerName == ""
                  ? Text(
                      "View Bidding offers below",
                      style: textStyleSubTitle(Colors.black),
                    )
                  : Text(
                      "${sellerName}",
                      style: textStyleH2(Colors.black),
                    ),
              sellerName == ""
                  ? const Icon(Icons.arrow_downward_rounded)
                  : Text(
                      "${offerPrice}",
                      style: textStyleH2(blackColor),
                    )
            ],
          ),
        ),
      ),
    ],
  );
}
