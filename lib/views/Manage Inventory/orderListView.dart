import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/utilities/textStyles/textStyles.dart';
import 'package:bidbazaar_admin/views/Manage%20Inventory/orderStatusDetailView.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/commonOutlinedButton.dart';
import 'package:flutter/material.dart';

Widget orderListView(
    context,
    String orderSatus,
    List<ConfirmOrderModel> orderModelData,
    List<OrderShippingModel> orderShippingModelData,
    List<OrderFeedbackModel> orderFeedbackModelData) {
  // Check if there are any items with the specified order status
  final hasMatchingItems =
      orderShippingModelData.any((item) => item.orderStatus == orderSatus);

  // Display a message if there are no matching items
  if (!hasMatchingItems) {
    return Center(
      child: Text(
        orderSatus == "new"
            ? "New orders not exist"
            : orderSatus == "delivered"
                ? "Delivered orders not exist"
                : "Processing orders not exist",
        style: textStyleH2(Colors.grey),
      ),
    );
  }

  return ListView.builder(
    itemCount: orderShippingModelData.length,
    padding: const EdgeInsets.all(0),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      if (orderShippingModelData[index].orderStatus == orderSatus) {
        return Card(
          elevation: 4,
          child: SizedBox(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order No. ${orderShippingModelData[index].orderId}",
                        style: textStyleH2(blackColor),
                      ),
                      Text(
                        "${orderShippingModelData[index].orderConfirmationDate}",
                        style: textStyle300WeightLight(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tracking number: ",
                          style: textStyle300WeightLight()),
                      Text(
                        "${orderShippingModelData[index].trackingNumber}",
                        style: textStyleSimpleTitle(FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Quantity: ", style: textStyle300WeightLight()),
                          Text(
                            "${orderShippingModelData[index].itemsQuantity}",
                            style: textStyleSimpleTitle(FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Total Amount: ",
                              style: textStyle300WeightLight()),
                          Text(
                            "${orderShippingModelData[index].orderTotalPrice}",
                            style: textStyleSimpleTitle(FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderStatusDetailView(
                                orderModelData: orderModelData,
                                orderShippingModelData:
                                    orderShippingModelData[index],
                                orderFeedbackModelData: orderFeedbackModelData,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          child: commonOutlinedButton(
                              context, "Details", commonButtonColor),
                        ),
                      ),
                      Text(
                        orderSatus == "new"
                            ? "New"
                            : orderSatus == "delivered"
                                ? "Delivered"
                                : "Processing",
                        style: textStyleH3(
                          orderSatus == "new"
                              ? orangeButtonColor
                              : orderSatus == "delivered"
                                  ? Colors.green
                                  : Colors.yellow.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(); // Return an empty container for non-matching items
      }
    },
  );
}
