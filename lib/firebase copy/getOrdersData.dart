import 'package:bidbazaar/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:firebase_database/firebase_database.dart';

// Future<List<ConfirmOrderModel>> getAllUsersOrderData(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('orders');
//   List<ConfirmOrderModel> allUserOrders = [];

//   DataSnapshot snapshot = (await _ref.once()).snapshot;

//   if (snapshot.value != null) {
//     Map<dynamic, dynamic> usersOrders = snapshot.value as Map<dynamic, dynamic>;

//     usersOrders.forEach((userId, userOrders) {
//       if (userOrders != null) {
//         Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
//         orders.forEach((orderId, orderData) {
//           if (orderData['products'] != null) {
//             Map<dynamic, dynamic> products = orderData['products'];
//             products.forEach((productId, productData) {
//               if (productData['sellerId'] == userId) {
//                 allUserOrders.add(ConfirmOrderModel.fromMap(productData));
//               }
//             });
//           }
//         });
//       }
//     });
//   }

//   return allUserOrders;
// }

Future<List<ConfirmOrderModel>> getAllUsersOrderData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');
  List<ConfirmOrderModel> userShippingDetails = [];

  try {
    DataSnapshot snapshot = (await _ref.once()).snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> userOrders =
          snapshot.value as Map<dynamic, dynamic>;

      userOrders.forEach((orderId, orderData) {
        if (orderData != null && orderData['products'] != null) {
          Map<dynamic, dynamic> products =
              orderData['products'] as Map<dynamic, dynamic>;
          products.forEach((productId, productData) {
            userShippingDetails.add(ConfirmOrderModel.fromMap(productData));
          });
        }
      });
    } else {
      print("No orders found for user: $userId");
    }
  } catch (e) {
    print("Error fetching user shipping data: $e");
  }

  return userShippingDetails;
}

// Future<List<ConfirmOrderModel>> getAllUsersOrderData(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/orders');
//   List<ConfirmOrderModel> userShippingDetails = [];

//   DataSnapshot snapshot = (await _ref.once()).snapshot;
//   if (snapshot.value != null) {
//     Map<dynamic, dynamic> userOrders = snapshot.value as Map<dynamic, dynamic>;

//     userOrders.forEach((orderId, orderData) {
//       if (orderData != null && orderData['products'] != null) {
//         userShippingDetails
//             .add(ConfirmOrderModel.fromMap(orderData['products']));
//       }
//     });
//   }

//   return userShippingDetails;
// }

Future<List<OrderShippingModel>> getUserShippingData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users/$userId/orders');
  List<OrderShippingModel> userShippingDetails = [];

  try {
    DataSnapshot snapshot = (await _ref.once()).snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> userOrders =
          snapshot.value as Map<dynamic, dynamic>;

      userOrders.forEach((orderId, orderData) {
        if (orderData != null && orderData['shippingDetails'] != null) {
          Map<dynamic, dynamic> shippingDetails =
              orderData['shippingDetails'] as Map<dynamic, dynamic>;
          if (shippingDetails['orderStatus'] == 'new') {
            userShippingDetails
                .add(OrderShippingModel.fromMap(shippingDetails));
          }
        }
      });
    } else {
      print("No orders found for user: $userId");
    }
  } catch (e) {
    print("Error fetching user shipping data: $e");
  }

  return userShippingDetails;
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
