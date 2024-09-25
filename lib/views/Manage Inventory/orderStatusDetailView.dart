import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/views/feedbacks/orderFeedbacksView.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/snackBar.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/commonOutlinedButton.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/deliverdItemsCardView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderStatusDetailView extends StatefulWidget {
  final List<ConfirmOrderModel> orderModelData;
  final OrderShippingModel orderShippingModelData;
  final List<OrderFeedbackModel> orderFeedbackModelData;
  const OrderStatusDetailView(
      {super.key,
      required this.orderModelData,
      required this.orderShippingModelData,
      required this.orderFeedbackModelData});

  @override
  State<OrderStatusDetailView> createState() => _OrderStatusDetailViewState();
}

class _OrderStatusDetailViewState extends State<OrderStatusDetailView> {
  List<String> orderStatuses = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    orderStatuses = [
      "Order Placed (${widget.orderShippingModelData.orderConfirmationDate})",
      "Order Shipped",
      "Out for Delivery",
      "Order Delivered",
    ];
    widget.orderShippingModelData.trackingStatus == ""
        ? currentStep = 0
        : widget.orderShippingModelData.trackingStatus == "processing"
            ? currentStep = 1
            : widget.orderShippingModelData.trackingStatus == "outOfDelivery"
                ? currentStep = 2
                : currentStep = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBarView(context, "Detail", true),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order No. ${widget.orderShippingModelData.orderId}",
                            style: textStyleH2(blackColor),
                          ),
                          Text(
                              widget.orderShippingModelData
                                  .orderConfirmationDate!,
                              style: textStyle300WeightLight())
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Tracking number: ",
                                  style: textStyle300WeightLight()),
                              Text(
                                widget.orderShippingModelData.trackingNumber!,
                                style: textStyleSimpleTitle(FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                              widget.orderShippingModelData.orderStatus == "new"
                                  ? "New"
                                  : widget.orderShippingModelData.orderStatus ==
                                          "processing"
                                      ? "Processing"
                                      : "Delivered",
                              style: textStyleH3(widget
                                          .orderShippingModelData.orderStatus ==
                                      "new"
                                  ? orangeButtonColor
                                  : widget.orderShippingModelData.orderStatus ==
                                          "processing"
                                      ? Colors.yellow.shade600
                                      : Colors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        "${widget.orderShippingModelData.itemsQuantity} items",
                        style: textStyleH2(blackColor),
                      ),
                    ),
                    SizedBox(height: 20),
                    orderItemsCardView(context, widget.orderModelData,
                        widget.orderShippingModelData),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 4),
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _LinePainter(
                                orderStatuses: orderStatuses,
                                currentStep: currentStep,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: orderStatuses.map((status) {
                              final index = orderStatuses.indexOf(status);
                              final isActive = index <= currentStep;
                              return InkWell(
                                onTap: () {
                                  if (index == 2) {
                                    widget.orderShippingModelData.orderStatus ==
                                            "processing"
                                        ? _showConfirmationDialog(
                                            context,
                                            widget
                                                .orderShippingModelData.buyerId
                                                .toString(),
                                            widget
                                                .orderShippingModelData.orderId
                                                .toString(),
                                            "outOfDelivery")
                                        : '';
                                  } else if (index == 3) {
                                    widget.orderShippingModelData.orderStatus ==
                                            "processing"
                                        ? _showConfirmationDialog(
                                            context,
                                            widget
                                                .orderShippingModelData.buyerId
                                                .toString(),
                                            widget
                                                .orderShippingModelData.orderId
                                                .toString(),
                                            "delivered")
                                        : '';
                                  }
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isActive
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        "Other Information",
                        style: textStyleH2(blackColor),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                            child: Text("Shipping Address: ",
                                style: textStyle300WeightLight()),
                          ),
                          Expanded(
                            child: Text(
                              widget.orderShippingModelData.apartment!,
                              maxLines: 2,
                              style: textStyleSimpleTitle(FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                            child: Text("Buyyer Email: ",
                                style: textStyle300WeightLight()),
                          ),
                          Expanded(
                            child: Text(
                              widget.orderShippingModelData.emailAddress!,
                              maxLines: 2,
                              style: textStyleSimpleTitle(FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                            child: Text("Contact Number: ",
                                style: textStyle300WeightLight()),
                          ),
                          Expanded(
                            child: Text(
                              widget.orderShippingModelData.phoneNumber!,
                              maxLines: 2,
                              style: textStyleSimpleTitle(FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                            child: Text("Total Amount: ",
                                style: textStyle300WeightLight()),
                          ),
                          Expanded(
                            child: Text(
                              widget.orderShippingModelData.orderTotalPrice!,
                              maxLines: 2,
                              style: textStyleSimpleTitle(FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    widget.orderShippingModelData.orderStatus == "delivered"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.06,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OrderFeedbackView(
                                                    orderId: widget
                                                        .orderShippingModelData
                                                        .orderId!,
                                                    orderFeedbackModelData: widget
                                                        .orderFeedbackModelData)));
                                      },
                                      child: commonOutlinedButton(context,
                                          "View Feedback", commonButtonColor),
                                    )),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 10)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<String> orderStatuses;
  final int currentStep;

  _LinePainter({
    required this.orderStatuses,
    required this.currentStep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    final firstCirclePosition =
        Offset(12, 12); // Adjust this based on your circle size
    final lastCirclePosition =
        Offset(12, 188); // Adjust this based on your circle size

    canvas.drawLine(firstCirclePosition, lastCirclePosition, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void _showConfirmationDialog(
    BuildContext context, String buyerId, String orderId, String status) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirmation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Are you sure you want to proceed?'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateStatus(buyerId, orderId, status);
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> updateStatus(String buyerId, String orderId, String status) async {
  try {
    EasyLoading.show();

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference
        .child('orders/$buyerId/${orderId}/shippingDetails')
        .update({"trackingStatus": status}).then((value) {
      databaseReference
          .child('orders/$buyerId/${orderId}/shippingDetails')
          .update({
        "orderStatus": status == "outOfDelivery" ? "processing" : status
      });
    });
    EasyLoading.dismiss();
  } catch (e) {
    print(e.toString());
    EasyLoading.dismiss();
  }
}
