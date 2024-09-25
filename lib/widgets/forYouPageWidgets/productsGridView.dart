import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/productGridModel.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:flutter/material.dart';

Widget productsGridView(context, List<ProductsGridModel> productListModelData) {
  return Card(
    elevation: 0,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Products", style: textStyleH3(Colors.black)),
                const Text("Customer Demand")
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productListModelData.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 305,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: InkWell(
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          Stack(children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Image.asset(
                                  productListModelData[index].productImagePath!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5)),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            productListModelData[index]
                                                .biddingNumber!
                                                .toString(),
                                            style: textStyleH2(blackColor)),
                                        Text("B",
                                            style: textStyleH2(blackColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                height: 32,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(24),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Qt. ",
                                          style: textStyleSimpleTitle(
                                              FontWeight.w400)),
                                      Text(
                                          productListModelData[index]
                                              .productQuantity!
                                              .toString(),
                                          style: textStyleH2(blackColor)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(productListModelData[index].productTitle!,
                                    maxLines: 1,
                                    style:
                                        textStyleSimpleTitle(FontWeight.w900)),
                                const SizedBox(height: 4),
                                Text(
                                    productListModelData[index]
                                        .productDescription!,
                                    maxLines: 2,
                                    style:
                                        textStyleSimpleTitle(FontWeight.w400)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50.0), // Circular border
                    ),
                    child: ClipOval(
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          productListModelData[index].icon,
                          color: productListModelData[index].faviroteStatus!
                              ? Colors.red
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ],
    ),
  );
}
