import 'package:bidbazaar_admin/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<UploadedProductAdModel>> getProductsDataFromDatabase(
    String userId) async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('productAds');
  List<UploadedProductAdModel> products = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      UploadedProductAdModel product = UploadedProductAdModel.fromMap(value);
      if (product.userId == userId) {
        products.add(product);
      }
    });
  }

  return products;
}
