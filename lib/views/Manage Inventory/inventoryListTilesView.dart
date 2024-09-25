import 'package:bidbazaar_admin/firebase/getOrdersData.dart';
import 'package:bidbazaar_admin/firebase/getOrdersFeedback.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/views/Manage%20Inventory/ordersListTileView.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class InventoryListTilesView extends StatefulWidget {
  const InventoryListTilesView({
    super.key,
  });

  @override
  State<InventoryListTilesView> createState() => _InventoryListTilesViewState();
}

class _InventoryListTilesViewState extends State<InventoryListTilesView> {
  List<ConfirmOrderModel> orderModelData = [];
  List<OrderShippingModel> orderShippingModelData = [];
  List<OrderFeedbackModel> orderFeedbackModelData = [];
  bool isDataLoaded = false;
  List<Map<String, dynamic>> orders = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    orders = [
      {
        'name': 'New Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'new'
      },
      {
        'name': 'Processing Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'processing'
      },
      {
        'name': 'Delivered Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'delivered'
      }
    ];
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      EasyLoading.show(status: "Loading...");
      List<ConfirmOrderModel> userOrders = await getAllUsersOrderData();
      List<OrderShippingModel> userOrdersShipping =
          await getAllUsersShippingData();
      List<OrderFeedbackModel> feedbacks = await getAllOrdersFeedbackData();
      if (mounted) {
        setState(() {
          orderModelData = userOrders;
          orderShippingModelData = userOrdersShipping;
          orderFeedbackModelData = feedbacks;
          isDataLoaded = true;
        });
      }
      EasyLoading.dismiss();
      setState(() {});
    } catch (e) {
      EasyLoading.dismiss();
      print("Error fetching products: $e");
      // Handle error appropriately, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            customAppBarView(context, "Orders", true),
            isDataLoaded
                ? Container(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: OrderNameCards(
                              productName: orders[index]['name'],
                              icon: orders[index]['icon'],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrdersListTileView(
                                        orderStatus: orders[index]
                                            ['orderStatus'],
                                        orderModelData: orderModelData,
                                        orderShippingModelData:
                                            orderShippingModelData,
                                        orderFeedbackModelData:
                                            orderFeedbackModelData),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ));
  }

  Future<void> _refreshData() async {
    try {
      List<ConfirmOrderModel> userOrders = await getAllUsersOrderData();
      List<OrderShippingModel> userOrdersShipping =
          await getAllUsersShippingData();
      List<OrderFeedbackModel> feedbacks = await getAllOrdersFeedbackData();
      if (mounted) {
        setState(() {
          orderModelData = userOrders;
          orderShippingModelData = userOrdersShipping;
          orderFeedbackModelData = feedbacks;
          isDataLoaded = true;
        });
      }
    } catch (e) {
      print("Error fetching products: $e");
      // Handle error appropriately, e.g., show a snackbar
    }
    await Future.delayed(Duration(seconds: 1));

    orders = [
      {
        'name': 'New Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'new'
      },
      {
        'name': 'Processing Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'processing'
      },
      {
        'name': 'Delivered Orders',
        'icon': Icons.insert_chart_outlined_rounded,
        'orderStatus': 'delivered'
      }
    ];

    setState(() {});
  }
}

class OrderNameCards extends StatelessWidget {
  final String productName;
  final IconData icon;
  final Function()? onTap;

  const OrderNameCards({
    required this.productName,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: whiteColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 6),
              Text(productName),
            ],
          ),
        ),
      ),
    );
  }
}
