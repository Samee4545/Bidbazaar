import 'package:flutter/material.dart';

class ProductsGridModel {
  String? productImagePath;
  int? biddingNumber;
  int? productQuantity;
  IconData? icon;
  String? productTitle;
  String? productDescription;
  bool? faviroteStatus;
  String? catagory;

  ProductsGridModel(
    {this.productImagePath,
    this.biddingNumber,
    this.productDescription,
    this.icon,
    this.productQuantity,
    this.productTitle,
    this.faviroteStatus,
    this.catagory}
  );
}
