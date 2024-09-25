import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderFeedbackView extends StatelessWidget {
  final int orderId;
  final List<OrderFeedbackModel> orderFeedbackModelData;
  const OrderFeedbackView(
      {super.key, required this.orderId, required this.orderFeedbackModelData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          customAppBarView(context, "Feedback", true),
          orderFeedbackModelData.isEmpty
              ? Text("No Feedback Exists")
              : Expanded(
                  child: ListView.builder(
                      itemCount: orderFeedbackModelData.length,
                      padding: const EdgeInsets.all(8),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return orderFeedbackModelData[index].orderId == orderId
                            ? Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 16, bottom: 8),
                                    child: Card(
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12,
                                            top: 12,
                                            bottom: 12,
                                            left: 24),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              orderFeedbackModelData[index]
                                                  .feedbackBy!,
                                              style: textStyleH2(Colors.black),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Text("Order No. ",
                                                    style:
                                                        textStyle300WeightLight()),
                                                Text(
                                                  orderFeedbackModelData[index]
                                                      .orderId
                                                      .toString(),
                                                  style:
                                                      textStyleH2(Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                      orderFeedbackModelData[
                                                              index]
                                                          .feedbackRating!
                                                          .toDouble(),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  itemSize: 20,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                  ),
                                                  ignoreGestures: true,
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                Text(
                                                    orderFeedbackModelData[
                                                            index]
                                                        .postedDate!,
                                                    style:
                                                        textStyle300WeightLight())
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(orderFeedbackModelData[index]
                                                .feedbackDes!)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: Container(
                                        height: 46,
                                        width: 46,
                                        child: CachedNetworkImage(
                                          imageUrl: orderFeedbackModelData[
                                                      index]
                                                  .userImage ??
                                              'https://plus.unsplash.com/premium_photo-1680378871613-bfacb34787f8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                                  )
                                ],
                              )
                            : SizedBox();
                      }),
                ),
        ],
      ),
    );
  }
}
