import 'package:flutter/material.dart';

class OrderFeedbackModel {
  int? feedbackRating;
  String? feedbackDes;
  int? orderId;
  String? postedDate;
  String? feedbackBy;
  String? userImage;

  OrderFeedbackModel(
      {this.feedbackRating,
      this.orderId,
      this.feedbackDes,
      this.postedDate,
      this.userImage,
      this.feedbackBy});

  Map<String, dynamic> toMap() {
    return {
      "feedbackRating": feedbackRating,
      "orderId": orderId,
      "feedbackDes": feedbackDes,
      "postedDate": postedDate,
      "feedbackBy": feedbackBy,
      "userImage": userImage
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "feedbackRating": feedbackRating,
      "orderId": orderId,
      "feedbackDes": feedbackDes,
      "postedDate": postedDate,
      "feedbackBy": feedbackBy,
      "userImage": userImage
    };
  }

  factory OrderFeedbackModel.fromMap(Map<dynamic, dynamic> map) {
    return OrderFeedbackModel(
        feedbackRating: map["feedbackRating"],
        orderId: map["orderId"],
        feedbackDes: map["feedbackDes"],
        postedDate: map["postedDate"],
        userImage: map["userImage"],
        feedbackBy: map["feedbackBy"]);
  }
}
