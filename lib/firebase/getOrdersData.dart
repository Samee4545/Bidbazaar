import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<ConfirmOrderModel>> getAllUsersOrderData() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders');
  List<ConfirmOrderModel> allUserOrders = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> usersOrders = snapshot.value as Map<dynamic, dynamic>;

    usersOrders.forEach((userId, userOrders) {
      if (userOrders != null) {
        Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
        orders.forEach((orderId, orderData) {
          if (orderData['products'] != null) {
            Map<dynamic, dynamic> products = orderData['products'];
            products.forEach((productId, productData) {
              allUserOrders.add(ConfirmOrderModel.fromMap(productData));
            });
          }
        });
      }
    });
  }

  return allUserOrders;
}

Future<List<OrderShippingModel>> getAllUsersShippingData() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders');
  List<OrderShippingModel> allShippingDetails = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> usersOrders = snapshot.value as Map<dynamic, dynamic>;

    usersOrders.forEach((userId, userOrders) {
      if (userOrders != null) {
        Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
        orders.forEach((orderId, orderData) {
          if (orderData['shippingDetails'] != null) {
            allShippingDetails
                .add(OrderShippingModel.fromMap(orderData['shippingDetails']));
          }
        });
      }
    });
  }

  return allShippingDetails;
}

Future<Map<String, int>> getAllOrderNumbers() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders');
  List<OrderShippingModel> allShippingDetails = [];

  int newCount = 0;
  int processingCount = 0;
  int deliveredCount = 0;

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> usersOrders = snapshot.value as Map<dynamic, dynamic>;

    usersOrders.forEach((userId, userOrders) {
      if (userOrders != null) {
        Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
        orders.forEach((orderId, orderData) {
          if (orderData['shippingDetails'] != null) {
            var shippingDetails =
                OrderShippingModel.fromMap(orderData['shippingDetails']);
            allShippingDetails.add(shippingDetails);
            if (orderData['shippingDetails']['orderStatus'] != null) {
              String orderStatus = orderData['shippingDetails']['orderStatus'];
              if (orderStatus == 'new') {
                newCount++;
              } else if (orderStatus == 'processing') {
                processingCount++;
              } else if (orderStatus == 'delivered') {
                deliveredCount++;
              }
            }
          }
        });
      }
    });
  }

  return {
    'new': newCount,
    'processing': processingCount,
    'delivered': deliveredCount,
  };
}
