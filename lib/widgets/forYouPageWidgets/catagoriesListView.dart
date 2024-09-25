import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget catagoriesListView(BuildContext context, catagoriesModelData) {
  return Card(
    elevation: 4,
    child: Container(
      padding: const EdgeInsets.all(8),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Catagories", style: textStyleH3(Colors.black)),
              const Icon(Icons.arrow_forward_rounded)
            ],
          ),
          SizedBox(
            height: 100,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: catagoriesModelData.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60,
                    margin: index != 0
                        ? const EdgeInsets.symmetric(horizontal: 12)
                        : const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SpecificCatagoryView(
                          //                 catagoryName:
                          //                     catagoriesModelData[index].title!,
                          //                 forwardScreenStatus: "view",
                          //               )));
                          // },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              height: 60,
                              width: 60,
                              color: Colors.grey.shade300,
                              child: Icon(catagoriesModelData[index].icon),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            catagoriesModelData[index].title!,
                            maxLines: 1,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
