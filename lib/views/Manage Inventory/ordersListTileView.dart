import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/views/Manage%20Inventory/orderListView.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrdersListTileView extends StatelessWidget {
  final String orderStatus;
  List<ConfirmOrderModel> orderModelData;
  List<OrderShippingModel> orderShippingModelData;
  List<OrderFeedbackModel> orderFeedbackModelData;
  OrdersListTileView(
      {super.key,
      required this.orderStatus,
      required this.orderModelData,
      required this.orderShippingModelData,
      required this.orderFeedbackModelData});

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
              customAppBarView(
                  context,
                  orderStatus == "new"
                      ? "New Orders"
                      : orderStatus == "processing"
                          ? "Processing"
                          : "Delivered",
                  true),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: orderListView(context, orderStatus, orderModelData,
                      orderShippingModelData, orderFeedbackModelData))
            ],
          ),
        ),
      ),
    );
  }
}
