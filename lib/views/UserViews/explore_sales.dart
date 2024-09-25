// import 'package:bidbazaar_admin/firebase/getOrdersData.dart';
// import 'package:bidbazaar_admin/firebase/getUserSalesData.dart';
// import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
// import 'package:bidbazaar_admin/utilities/models/dashBoardModels/currentUserOrdersPriceStatusModel.dart';
// import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';

// class ExploreEarningScreen extends StatefulWidget {
//   final String userId;
//   const ExploreEarningScreen({super.key, required this.userId});

//   @override
//   State<ExploreEarningScreen> createState() => _ExploreEarningScreenState();
// }

// class _ExploreEarningScreenState extends State<ExploreEarningScreen> {
//   List<CurrentUserOrdersPriceStatusModel> currentUserOrdersPriceStatusData = [];
//   String monthName = '';
//   int _futureMonthlyAmount = 0, activeOrdersCount = 0, completedOrdersCount = 0;
//   List<int> pendingOrdersAmount = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     DateTime now = DateTime.now();
//     int currentMonth = now.month;
//     monthName = DateFormat.MMMM().format(now);
//     _fetchRecord();
//   }

//   Future<List<CurrentUserOrdersPriceStatusModel>> getUserSalesData(
//     String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');

//   List<CurrentUserOrdersPriceStatusModel> ordersList = [];
//   DataSnapshot snapshot = await _ref.get();

//   if (snapshot.exists) {
//     Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

//     ordersMap.forEach((orderId, orderData) {
//       if (orderData['userAmountStatus'] != null) {
//         var userAmountStatus = orderData['userAmountStatus'];
//         ordersList
//             .add(CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus));
//       }
//     });
//   }
//   return ordersList;
// }

// Future<int> getUserSalesAmountData(String userId, int month, int year) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');

//   List<CurrentUserOrdersPriceStatusModel> ordersList = [];
//   DataSnapshot snapshot = await _ref.get();
//   int monthlyAmount = 0;

//   if (snapshot.exists) {
//     Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

//     ordersMap.forEach((orderId, orderData) {
//       if (orderData['userAmountStatus'] != null) {
//         var userAmountStatus = orderData['userAmountStatus'];
//         var orderModel =
//             CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus);

//         if (orderModel.amountConfirmationDate != null) {
//           DateTime confirmationDate =
//               DateFormat('d/M/yyyy').parse(orderModel.amountConfirmationDate!);
//           if (confirmationDate.month == month &&
//               confirmationDate.year == year) {
//             monthlyAmount += orderModel.orderAmount ?? 0;
//           }
//         }

//         ordersList.add(orderModel);
//       }
//     });
//   }

//   return monthlyAmount;
// }

// Future<int> getUserActiveOrdersData(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');

//   int count = 0;
//   DataSnapshot snapshot = await _ref.get();

//   if (snapshot.exists) {
//     Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

//     ordersMap.forEach((orderId, orderData) {
//       if (orderData['shippingDetails'] != null) {
//         var shippingDetails = orderData['shippingDetails'];
//         if (shippingDetails['orderStatus'] == 'new' ||
//             shippingDetails['orderStatus'] == 'processing') {
//           count++;
//         }
//       }
//     });
//   }
//   return count;
// }

// Future<int> getUserCompletedOrdersData(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');

//   int count = 0;
//   DataSnapshot snapshot = await _ref.get();

//   if (snapshot.exists) {
//     Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

//     ordersMap.forEach((orderId, orderData) {
//       if (orderData['shippingDetails'] != null) {
//         var shippingDetails = orderData['shippingDetails'];
//         if (shippingDetails['orderStatus'] == 'delivered') {
//           count++;
//         }
//       }
//     });
//   }
//   return count;
// }

// Future<List<int>> getUserPendingOrderAmounts(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');

//   List<int> pendingOrderAmounts = [];
//   DataSnapshot snapshot = await _ref.get();

//   if (snapshot.exists) {
//     Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

//     ordersMap.forEach((orderId, orderData) {
//       if (orderData['userAmountStatus'] != null) {
//         var userAmountStatus = orderData['userAmountStatus'];
//         CurrentUserOrdersPriceStatusModel model =
//             CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus);
//         if (model.amountPending == true && model.orderAmount != null) {
//           pendingOrderAmounts.add(model.orderAmount!);
//         }
//       }
//     });
//   }
//   return pendingOrderAmounts;
// }

//   Future<void> _fetchRecord() async {
//     try {
//       EasyLoading.show(status: "Loading...");
//       DateTime now = DateTime.now();
//       List<CurrentUserOrdersPriceStatusModel> userPriceStatusRecord =
//           await getUserSalesData(widget.userId);

//       int currentMonthlyAmount =
//           await getUserSalesAmountData(widget.userId, now.month, now.year);

//       int orderStatusCount = await getUserActiveOrdersData(widget.userId);
//       int completedOrdersNo = await getUserCompletedOrdersData(widget.userId);
//       List<int> pendingAmount = await getUserPendingOrderAmounts(widget.userId);
//       if (mounted) {
//         setState(() {
//           currentUserOrdersPriceStatusData = userPriceStatusRecord;
//           _futureMonthlyAmount = currentMonthlyAmount;
//           activeOrdersCount = orderStatusCount;
//           completedOrdersCount = completedOrdersNo;
//           pendingOrdersAmount = pendingAmount;
//         });
//       }
//       EasyLoading.dismiss();
//       setState(() {});
//     } catch (e) {
//       EasyLoading.dismiss();
//       print("Error fetching products: $e");
//       // Handle error appropriately, e.g., show a snackbar
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: NotificationListener<OverscrollIndicatorNotification>(
//         onNotification: (notification) {
//           notification.disallowIndicator();
//           return true;
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               customAppBarView(context, "Earnings", true),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Earnings',
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           "${currentUserOrdersPriceStatusData.fold(0, (sum, item) => sum + item.orderAmount!)} /-",
//                           style: TextStyle(
//                               fontSize: 36, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 20),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Earnings in $monthName:',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   _futureMonthlyAmount.toString(),
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             Divider(),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Pending Amount:',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "${pendingOrdersAmount.fold(0, (previous, current) => previous + current)}",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             Divider(), // Add a divider
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Avg. selling price:',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "${currentUserOrdersPriceStatusData.fold(0, (sum, item) => sum + item.orderAmount!) / currentUserOrdersPriceStatusData.length}",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             Divider(), // Add a divider
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Active orders:',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "${activeOrdersCount}",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             Divider(), // Add a divider
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Completed orders:',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "${completedOrdersCount}",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bidbazaar_admin/firebase/getOrdersData.dart';
import 'package:bidbazaar_admin/firebase/getUserSalesData.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/currentUserOrdersPriceStatusModel.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ExploreEarningScreen extends StatefulWidget {
  final String userId;
  const ExploreEarningScreen({super.key, required this.userId});

  @override
  State<ExploreEarningScreen> createState() => _ExploreEarningScreenState();
}

class _ExploreEarningScreenState extends State<ExploreEarningScreen> {
  String monthName = '';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    monthName = DateFormat.MMMM().format(now);
  }

  Stream<List<CurrentUserOrdersPriceStatusModel>> getUserSalesData(
      String userId) {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('users/$userId/orders');

    return _ref.onValue.map((event) {
      List<CurrentUserOrdersPriceStatusModel> ordersList = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        ordersMap.forEach((orderId, orderData) {
          if (orderData['userAmountStatus'] != null) {
            var userAmountStatus = orderData['userAmountStatus'];
            ordersList.add(
                CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus));
          }
        });
      }
      return ordersList;
    });
  }

  Stream<int> getUserSalesAmountData(String userId, int month, int year) {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('users/$userId/orders');

    return _ref.onValue.map((event) {
      int monthlyAmount = 0;
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        ordersMap.forEach((orderId, orderData) {
          if (orderData['userAmountStatus'] != null) {
            var userAmountStatus = orderData['userAmountStatus'];
            var orderModel =
                CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus);

            if (orderModel.amountConfirmationDate != null) {
              DateTime confirmationDate = DateFormat('d/M/yyyy')
                  .parse(orderModel.amountConfirmationDate!);
              if (confirmationDate.month == month &&
                  confirmationDate.year == year) {
                monthlyAmount += orderModel.orderAmount ?? 0;
              }
            }
          }
        });
      }
      return monthlyAmount;
    });
  }

  Stream<int> getUserActiveOrdersData(String userId) {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('users/$userId/orders');

    return _ref.onValue.map((event) {
      int count = 0;
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        ordersMap.forEach((orderId, orderData) {
          if (orderData['shippingDetails'] != null) {
            var shippingDetails = orderData['shippingDetails'];
            if (shippingDetails['orderStatus'] == 'new' ||
                shippingDetails['orderStatus'] == 'processing') {
              count++;
            }
          }
        });
      }
      return count;
    });
  }

  Stream<int> getUserCompletedOrdersData(String userId) {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('users/$userId/orders');

    return _ref.onValue.map((event) {
      int count = 0;
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        ordersMap.forEach((orderId, orderData) {
          if (orderData['shippingDetails'] != null) {
            var shippingDetails = orderData['shippingDetails'];
            if (shippingDetails['orderStatus'] == 'delivered') {
              count++;
            }
          }
        });
      }
      return count;
    });
  }

  Stream<List<int>> getUserPendingOrderAmounts(String userId) {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('users/$userId/orders');

    return _ref.onValue.map((event) {
      List<int> pendingOrderAmounts = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        ordersMap.forEach((orderId, orderData) {
          if (orderData['userAmountStatus'] != null) {
            var userAmountStatus = orderData['userAmountStatus'];
            CurrentUserOrdersPriceStatusModel model =
                CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus);
            if (model.amountPending == true && model.orderAmount != null) {
              pendingOrderAmounts.add(model.orderAmount!);
            }
          }
        });
      }
      return pendingOrderAmounts;
    });
  }

  Widget shimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
            5,
            (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                )),
      ),
    );
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customAppBarView(context, "Earnings", true),
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
                          'Earnings',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        StreamBuilder<List<CurrentUserOrdersPriceStatusModel>>(
                          stream: getUserSalesData(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return Text(
                                "${data.fold(0, (sum, item) => sum + item.orderAmount!)} /-",
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold),
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                        SizedBox(height: 20),
                        StreamBuilder<int>(
                          stream: getUserSalesAmountData(widget.userId,
                              DateTime.now().month, DateTime.now().year),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Earnings in $monthName:',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                        StreamBuilder<List<int>>(
                          stream: getUserPendingOrderAmounts(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pending Amount:',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${snapshot.data!.fold(0, (previous, current) => previous + current)}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                        StreamBuilder<List<CurrentUserOrdersPriceStatusModel>>(
                          stream: getUserSalesData(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Avg. selling price:',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${data.isEmpty ? 0 : data.fold(0, (sum, item) => sum + item.orderAmount!) ~/ data.length}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                        StreamBuilder<int>(
                          stream: getUserActiveOrdersData(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Active Orders:',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                        StreamBuilder<int>(
                          stream: getUserCompletedOrdersData(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerLoading();
                            }
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Completed Orders:',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            }
                            return Text("No data available");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
