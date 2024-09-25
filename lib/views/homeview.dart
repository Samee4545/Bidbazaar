import 'package:bidbazaar_admin/firebase/getOrdersData.dart';
import 'package:bidbazaar_admin/firebase/getOrdersFeedback.dart';
import 'package:bidbazaar_admin/firebase/getUserPersonalData.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar_admin/views/AnalyticViews/analysis_report.dart';
import 'package:bidbazaar_admin/views/Manage%20Inventory/inventoryListTilesView.dart';
import 'package:bidbazaar_admin/views/Manage%20Inventory/ordersListTileView.dart';
import 'package:bidbazaar_admin/views/UserViews/UsersList.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Users', 'icon': Icons.person},
    {'name': 'Analytic Reports', 'icon': Icons.bar_chart},
    {'name': 'Manage Inventory', 'icon': Icons.storage},
  ];

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
                customAppBarView(context, "Admin", false),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ProductCard(
                          productName: products[index]['name'],
                          icon: products[index]['icon'],
                          onTap: () {
                            // Handle product tap
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserListScreen(),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnalysisReportScreen()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InventoryListTilesView()),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final IconData icon;
  final Function()? onTap;

  const ProductCard({
    super.key,
    required this.productName,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
