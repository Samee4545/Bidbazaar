import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customAppBarView(context, String title, bool showBackIcon) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        child: Container(
            height: MediaQuery.of(context).size.height / 6,
            color: Colors.orange),
      ),
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 6,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: "BriemHand",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      showBackIcon
          ? Positioned(
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
            )
          : const SizedBox()
    ],
  );
}
