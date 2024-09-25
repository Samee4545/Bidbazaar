import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget UsersReviewsListView(context) {
  return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 12, top: 12, bottom: 12, left: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "M Nouman Maqsood",
                        style: textStyleH2(Colors.black),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemSize: 20,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            ignoreGestures: true,
                            onRatingUpdate: (rating) {},
                          ),
                          Text("03-11-2023", style: textStyle300WeightLight())
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          "Reloaded 1 of 808 libraries in 1,189ms (compile: 84 ms, reload: 542 ms, reassemble: 425 ms).Reloaded 1 of 808 libraries in 905ms (compile: 37 ms, reload: 352 ms, reassemble: 371 ms).Reloaded 1 of 808 libraries in 2,699ms (compile: 1201 ms, reload: 691 ms, reassemble: 494 ms).Reloaded 1 of 808 libraries in 1,153ms (compile: 43 ms, reload: 513 ms, reassemble: 451 ms).Reloaded 1 of 808 libraries in 951ms (compile: 45 ms, reload: 372 ms, reassemble: 380 ms).Reloaded 1 of 808 libraries in 1,237ms (compile: 254 ms, reload: 387 ms, reassemble: 372 ms).")
                    ],
                  ),
                ),
              ),
            ),
            ClipOval(
                child: Image.asset(
              "assets/images/slider_images/ai.jpg",
              height: 46,
              width: 46,
              fit: BoxFit.cover,
            ))
          ],
        );
      });
}
