import 'dart:async';
import 'dart:io';

import 'package:bidbazaar/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderItemFBModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/uploadBiddingProductAdModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final DatabaseReference database = FirebaseDatabase.instance.reference();
List<UploadedProductAdModel> productList = [];

void saveProductDataToDatabase(
    BuildContext context, UploadedProductAdModel product, String productId) {
  EasyLoading.show(status: 'PLease wait...');
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('productAds/$productId');
  databaseReference.set(product.toJson()).whenComplete(() {
    EasyLoading.dismiss();
    Navigator.pop(context);
  });
}

void saveBiddingProductDataToDatabase(
    BuildContext context,
    UploadedBiddingProductAdModel product,
    String productId,
    String uId,
    int existingBiddingNumber) {
  EasyLoading.show(status: 'Please wait...');
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('productAds/$productId');

  // Update only the name field for this user
  databaseReference.child('users/$uId').update({
    "userRole": "seller",
  }).then((value) {
    databaseReference.update({
      "biddingNumber": ++existingBiddingNumber,
    }).then((_) {
      DatabaseReference productRef = FirebaseDatabase.instance
          .reference()
          .child('productAds/$productId/bidding/$uId');
      productRef.set(product.toJson()).whenComplete(() {
        EasyLoading.dismiss();
        Navigator.pop(context);
      });
    });
    EasyLoading.dismiss();
  }).catchError((error) {
    EasyLoading.dismiss();
    print("Error on updating bidding number");
    print(error.toString());
  });
}

void saveProductFavoriteStatusToDatabase(String productId, bool newStatus) {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('productAds/$productId');
  databaseReference.update({'faviroteStatus': newStatus});
}

Future<List<UploadedProductAdModel>> getProductsDataFromDatabase() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('productAds');
  List<UploadedProductAdModel> products = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      products.add(UploadedProductAdModel.fromMap(value));
    });
  }

  return products;
}

// Future<double> calculateOverallRating(String userId) async {
//   final DatabaseReference _ref =
//       FirebaseDatabase.instance.reference().child('users/$userId/feedbacks');
//   List<OrderFeedbackModel> shippingDetails = [];

//   double totalRating = 0;
//   int feedbackCount = 0;

//   DataSnapshot snapshot = (await _ref.once()).snapshot;
//   if (snapshot.value != null) {
//     Map<dynamic, dynamic> orders = snapshot.value as Map<dynamic, dynamic>;

//     orders.forEach((orderId, value) {
//       if (value['feedbackRating'] != null &&
//           value['feedbackRating'].toString().isNotEmpty) {
//         totalRating += double.parse(value['feedbackRating'].toString());
//         feedbackCount++;
//       }
//     });
//   }

//   // Calculate the overall rating
//   double overallRating = feedbackCount > 0 ? totalRating / feedbackCount : 0;
//   return overallRating;
// }

Future<double> calculateOverallRating(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child("users/$userId/feedbacks");

  double totalRating = 0;
  int feedbackCount = 0;

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> feedbacks = snapshot.value as Map<dynamic, dynamic>;

    feedbacks.forEach((key, feedbackData) {
      // Traverse each child node under feedbacks
      if (feedbackData is Map<dynamic, dynamic>) {
        feedbackData.forEach((subKey, subValue) {
          // Check if feedbackRating is not null and is a valid number
          if (subValue['feedbackRating'] != null &&
              subValue['feedbackRating'].toString().isNotEmpty) {
            try {
              totalRating +=
                  double.parse(subValue['feedbackRating'].toString());
              feedbackCount++;
            } catch (e) {
              print("Error parsing feedbackRating: ${e.toString()}");
            }
          }
        });
      }
    });
  }

  // Calculate the overall rating
  double overallRating = feedbackCount > 0 ? totalRating / feedbackCount : 0;
  return overallRating;
}

Future<List<OrderFeedbackModel>> getCurrUserFeedbacks(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders/$userId');
  List<OrderFeedbackModel> shippingDetails = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> orders = snapshot.value as Map<dynamic, dynamic>;

    orders.forEach((orderId, orderData) {
      if (orderData['feedbacks'] != null) {
        shippingDetails.add(OrderFeedbackModel.fromMap(orderData['feedbacks']));
      }
    });
  }

  return shippingDetails;
}

Future<List<ConfirmOrderModel>> getCurrUserOrderData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders/$userId');
  List<ConfirmOrderModel> userOrders = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> orders = snapshot.value as Map<dynamic, dynamic>;

    orders.forEach((orderId, orderData) {
      if (orderData['products'] != null) {
        Map<dynamic, dynamic> products = orderData['products'];
        products.forEach((productId, productData) {
          userOrders.add(ConfirmOrderModel.fromMap(productData));
        });
      }
    });
  }

  return userOrders;
}

Future<List<OrderShippingModel>> getCurrUserShippingData(String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('orders/$userId');
  List<OrderShippingModel> shippingDetails = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> orders = snapshot.value as Map<dynamic, dynamic>;

    orders.forEach((orderId, orderData) {
      if (orderData['shippingDetails'] != null) {
        shippingDetails
            .add(OrderShippingModel.fromMap(orderData['shippingDetails']));
      }
    });
  }

  return shippingDetails;
}

Future<List<UploadedBiddingProductAdModel>> getBiddingProductsDataFromDatabase(
    String productId) async {
  final DatabaseReference _ref = FirebaseDatabase.instance
      .reference()
      .child('productAds/$productId/bidding');
  List<UploadedBiddingProductAdModel> products = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      products.add(UploadedBiddingProductAdModel.fromMap(value));
    });
  }

  return products;
}

Future<List<UploadedProductAdModel>> getFavoriteProductsFromDatabase() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('productAds');
  List<UploadedProductAdModel> favoriteProducts = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      UploadedProductAdModel product = UploadedProductAdModel.fromMap(value);
      if (product.faviroteStatus == true) {
        favoriteProducts.add(product);
      }
    });
  }

  return favoriteProducts;
}

Future<List<UploadedProductAdModel>> getFavoriteProductsFromDatabaseByCat(
    String catagory) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('productAds');
  List<UploadedProductAdModel> favoriteProducts = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      UploadedProductAdModel product = UploadedProductAdModel.fromMap(value);
      if (product.catagory == catagory) {
        if (product.faviroteStatus == true) {
          favoriteProducts.add(product);
        }
      }
    });
  }

  return favoriteProducts;
}

Future<List<UploadedProductAdModel>> getProductsFromDatabaseByCat(
    String catagory) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('productAds');
  List<UploadedProductAdModel> catProducts = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      UploadedProductAdModel product = UploadedProductAdModel.fromMap(value);
      if (product.catagory == catagory) {
        catProducts.add(product);
      }
    });
  }

  return catProducts;
}

Future<List<String>> uploadProductImages(
    List<File> imageFiles, String productId) async {
  List<String> imageUrls = [];

  for (int i = 0; i < imageFiles.length; i++) {
    File imageFile = imageFiles[i];
    String fileName = 'image_$i.jpg';
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('productImages/$productId/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
      print(
          "==============================================imageUploaded=================================");
    });
  }

  return imageUrls;
}

Future<List<String>> uploadBiddingProductImages(
    List<File> imageFiles, String productId, String userId) async {
  List<String> imageUrls = [];

  for (int i = 0; i < imageFiles.length; i++) {
    File imageFile = imageFiles[i];
    String fileName = 'image_$i.jpg';
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('productImages/$productId/biddingImages/$userId/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
      print(
          "==============================================imageUploaded=================================");
    });
  }

  return imageUrls;
}

Future<String> uploadProductVideo(File videoFile, String productId) async {
  String videoUrl = "";
  String videoFileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('productVideos/$productId/$videoFileName.mp4');

  UploadTask uploadTask = storageReference.putFile(videoFile);

  await uploadTask.whenComplete(() async {
    String downloadUrl = await storageReference.getDownloadURL();
    videoUrl = downloadUrl;
  });
  return videoUrl;
}

Future<String> uploadBiddingProductVideo(
    File videoFile, String productId, String userId) async {
  String videoUrl = "";
  String videoFileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference storageReference = FirebaseStorage.instance.ref().child(
      'productVideos/$productId/biddingVideo/$userId/$videoFileName.mp4');

  UploadTask uploadTask = storageReference.putFile(videoFile);

  await uploadTask.whenComplete(() async {
    String downloadUrl = await storageReference.getDownloadURL();
    videoUrl = downloadUrl;
  });
  return videoUrl;
}
