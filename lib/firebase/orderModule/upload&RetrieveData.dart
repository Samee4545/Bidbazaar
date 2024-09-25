import 'package:bidbazaar/utilities/models/dashBoardModels/orderBookModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

addOrderConfirmDataInDB(BuildContext context, OrderBookModel orderDetail,
    OrderShippingModel shippingModel, String orderId) {
  try {
    EasyLoading.show(status: 'Please wait...');
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child('orders/$orderId');
    databaseReference.set(orderDetail.toJson()).then((_) {
      DatabaseReference productRef = FirebaseDatabase.instance
          .reference()
          .child('orders/$orderId/shippingDetails');
      productRef.set(shippingModel.toJson()).whenComplete(() {
        Navigator.pop(context);
      });
      EasyLoading.dismiss();
    }).catchError((error) {
      EasyLoading.dismiss();
      print("Error on uploading order details");
      print(error.toString());
    });
  } catch (e) {
    EasyLoading.dismiss();
    snackBar(context, e.toString());
  }
}
