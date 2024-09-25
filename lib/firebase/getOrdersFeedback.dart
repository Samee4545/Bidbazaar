import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<OrderFeedbackModel>> getAllOrdersFeedbackData() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders');
  List<OrderFeedbackModel> allShippingDetails = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> usersOrders = snapshot.value as Map<dynamic, dynamic>;

    usersOrders.forEach((userId, userOrders) {
      if (userOrders != null) {
        Map<dynamic, dynamic> orders = userOrders as Map<dynamic, dynamic>;
        orders.forEach((orderId, orderData) {
          if (orderData['feedbacks'] != null) {
            allShippingDetails
                .add(OrderFeedbackModel.fromMap(orderData['feedbacks']));
          }
        });
      }
    });
  }

  return allShippingDetails;
}
