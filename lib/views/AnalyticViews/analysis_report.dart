import 'package:bidbazaar_admin/firebase/getOrdersData.dart';
import 'package:bidbazaar_admin/firebase/getUserPersonalData.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rxdart/rxdart.dart';

class AnalysisReportScreen extends StatelessWidget {
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('users');
  final DatabaseReference _ordersRef =
      FirebaseDatabase.instance.reference().child('orders');

  AnalysisReportScreen({super.key});

  Stream<List<UserPersonalInfoModel>> getUserPersonalInfoFromDatabase() {
    return _usersRef.onValue.map((event) {
      List<UserPersonalInfoModel> users = [];
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) {
          users.add(UserPersonalInfoModel.fromMap(value));
        });
      }
      return users;
    });
  }

  Stream<List<OrderShippingModel>> getAllUsersShippingData() {
    return _ordersRef.onValue.map((event) {
      List<OrderShippingModel> allShippingDetails = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> usersOrders =
            event.snapshot.value as Map<dynamic, dynamic>;

        usersOrders.forEach((userId, userOrders) {
          if (userOrders != null) {
            Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
            orders.forEach((orderId, orderData) {
              if (orderData['shippingDetails'] != null) {
                allShippingDetails.add(
                    OrderShippingModel.fromMap(orderData['shippingDetails']));
              }
            });
          }
        });
      }
      return allShippingDetails;
    });
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
              customAppBarView(context, "Analytics", true),
              StreamBuilder<List<dynamic>>(
                stream: Rx.combineLatest2(
                  getAllUsersShippingData(),
                  getUserPersonalInfoFromDatabase(),
                  (List<OrderShippingModel> orders,
                      List<UserPersonalInfoModel> users) {
                    return [orders, users];
                  },
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerLoading();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final List<OrderShippingModel> orderData =
                        snapshot.data![0];
                    final List<UserPersonalInfoModel> userData =
                        snapshot.data![1];
                    int activeOrders = orderData.length;
                    int allUsers = userData.length;
                    DateTime now = DateTime.now();
                    String monthName = DateFormat.MMMM().format(now);
                    int newOrders = orderData
                        .where((order) => order.orderStatus == 'new')
                        .length;
                    int processingOrders = orderData
                        .where((order) => order.orderStatus == 'processing')
                        .length;
                    int deliveredOrders = orderData
                        .where((order) => order.orderStatus == 'delivered')
                        .length;

                    int usersInCurrentMonth = userData.where((user) {
                      DateTime? creationDate;
                      try {
                        creationDate = DateFormat('d/M/yyyy')
                            .parse(user.accountCreatedDate!);
                      } catch (e) {
                        return false; // Skip if date format is incorrect
                      }
                      return creationDate.month == now.month &&
                          creationDate.year == now.year;
                    }).length;

                    int buyerCount = userData
                        .where((user) =>
                            user.buyer == true && user.seller == false)
                        .length;
                    int sellerCount = userData
                        .where((user) =>
                            user.seller == true && user.buyer == false)
                        .length;
                    int bothCount = userData
                        .where(
                            (user) => user.buyer == true && user.seller == true)
                        .length;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('All orders:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(activeOrders.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('New orders:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(newOrders.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Processing orders:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(processingOrders.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Completed orders:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(deliveredOrders.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Users',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Number of Users in $monthName:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(usersInCurrentMonth.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Number of Users:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(allUsers.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Number of buyers:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(buyerCount.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Number of sellers:',
                                              style: TextStyle(fontSize: 16)),
                                          Text(sellerCount.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Multi Roles(buyer & seller):',
                                              style: TextStyle(fontSize: 16)),
                                          Text(bothCount.toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('No data found'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
            20,
            (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                )),
      ),
    );
  }
}
