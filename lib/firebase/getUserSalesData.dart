import 'package:bidbazaar_admin/utilities/models/dashBoardModels/currentUserOrdersPriceStatusModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

Future<List<CurrentUserOrdersPriceStatusModel>> getUserSalesData(
    String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');

  List<CurrentUserOrdersPriceStatusModel> ordersList = [];
  DataSnapshot snapshot = await _ref.get();

  if (snapshot.exists) {
    Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

    ordersMap.forEach((orderId, orderData) {
      if (orderData['userAmountStatus'] != null) {
        var userAmountStatus = orderData['userAmountStatus'];
        ordersList
            .add(CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus));
      }
    });
  }
  return ordersList;
}

Future<int> getUserSalesAmountData(String userId, int month, int year) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');

  List<CurrentUserOrdersPriceStatusModel> ordersList = [];
  DataSnapshot snapshot = await _ref.get();
  int monthlyAmount = 0;

  if (snapshot.exists) {
    Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

    ordersMap.forEach((orderId, orderData) {
      if (orderData['userAmountStatus'] != null) {
        var userAmountStatus = orderData['userAmountStatus'];
        var orderModel =
            CurrentUserOrdersPriceStatusModel.fromMap(userAmountStatus);

        if (orderModel.amountConfirmationDate != null) {
          DateTime confirmationDate =
              DateFormat('d/M/yyyy').parse(orderModel.amountConfirmationDate!);
          if (confirmationDate.month == month &&
              confirmationDate.year == year) {
            monthlyAmount += orderModel.orderAmount ?? 0;
          }
        }

        ordersList.add(orderModel);
      }
    });
  }

  return monthlyAmount;
}

Future<int> getUserActiveOrdersData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');

  int count = 0;
  DataSnapshot snapshot = await _ref.get();

  if (snapshot.exists) {
    Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

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
}

Future<int> getUserCompletedOrdersData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');

  int count = 0;
  DataSnapshot snapshot = await _ref.get();

  if (snapshot.exists) {
    Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

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
}

Future<List<int>> getUserPendingOrderAmounts(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');

  List<int> pendingOrderAmounts = [];
  DataSnapshot snapshot = await _ref.get();

  if (snapshot.exists) {
    Map<dynamic, dynamic> ordersMap = snapshot.value as Map<dynamic, dynamic>;

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
}
