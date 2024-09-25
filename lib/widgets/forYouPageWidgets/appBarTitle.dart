import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget appBarTitle(
    context, appBarColorChange, screenScrolled, searchController) {
  return Row(
    children: [
      const Spacer(),
      screenScrolled
          ? SizedBox(
              width: MediaQuery.of(context).size.width / 1.9,
              child: TextField(
                maxLines: 1,
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  // Handle search query here
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("BidBazaar",
                  style: textStyleAppBarTitle(appBarColorChange)),
            ),
      const Spacer(),
      IconButton(
        onPressed: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const AddToCartView(),
        //       ));
        },
        icon: Icon(Icons.shopping_cart_rounded,
            color: appBarColorChange ? Colors.black : Colors.white),
      ),
    ],
  );
}
