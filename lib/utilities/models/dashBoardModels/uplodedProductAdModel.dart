import 'package:flutter/material.dart';

class UploadedProductAdModel {
  String? productAdId;
  String? productTitle;
  String? productDescription;
  List<String>? images;
  String? userId;

  UploadedProductAdModel(
      {this.productAdId,
      this.productTitle,
      this.productDescription,
      this.userId,
      this.images});

  Map<String, dynamic> toJson() {
    return {
      "productAdId": productAdId,
      "productTitle": productTitle,
      "productDescription": productDescription,
      "images": images,
      "userId": userId
    };
  }

  factory UploadedProductAdModel.fromMap(Map<dynamic, dynamic> map) {
    return UploadedProductAdModel(
        productAdId: map["productAdId"],
        productTitle: map["productTitle"],
        productDescription: map["productDescription"],
        userId: map["userId"],
        images: List<String>.from(map["images"]));
  }
}
