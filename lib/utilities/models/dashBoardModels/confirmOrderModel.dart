import 'package:flutter/material.dart';

class ConfirmOrderModel {
  String? productAdId;
  String? productTitle;
  String? image;
  int? unitPrice;
  int? unitQuantity;
  String? sellerId;
  int? orderID;
  String? sellerName;

  ConfirmOrderModel(
      {this.productAdId,
      this.productTitle,
      this.image,
      this.unitPrice,
      this.sellerId,
      this.sellerName,
      this.orderID,
      this.unitQuantity});

  Map<String, dynamic> toMap() {
    return {
      "productAdId": productAdId,
      "image": image,
      "productTitle": productTitle,
      "unitPrice": unitPrice,
      "sellerId": sellerId,
      "sellerName": sellerName,
      "orderID": orderID,
      "unitQuantity": unitQuantity
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "productAdId": productAdId,
      "image": image,
      "productTitle": productTitle,
      "unitPrice": unitPrice,
      "sellerId": sellerId,
      "sellerName": sellerName,
      "orderID": orderID,
      "unitQuantity": unitQuantity
    };
  }

  factory ConfirmOrderModel.fromMap(Map<dynamic, dynamic> map) {
    return ConfirmOrderModel(
        productAdId: map["productAdId"],
        image: map["image"],
        productTitle: map["productTitle"],
        unitPrice: map["unitPrice"],
        sellerId: map["sellerId"],
        sellerName: map["sellerName"],
        orderID: map["orderID"],
        unitQuantity: map["unitQuantity"]);
  }
}
