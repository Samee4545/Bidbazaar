import 'dart:io';

import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/views/postDesiredProductView.dart';
import 'package:bidbazaar/views/settingView.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<bool> checkUserDataPresence(String uid) async {
  final ref = FirebaseDatabase.instance.ref('users/$uid');
  final snapshot = await ref.get();
  if (snapshot.exists) {
    return true; // User data exists
  } else {
    return false; // User data does not exist
  }
}

Future<bool> checkAndReturnUserPresence() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user == null) {
    // No user logged in
    return false;
  }
  return await checkUserDataPresence(user.uid);
}

Future<void> updateUserPersonalInfo(
    BuildContext context,
    String userId,
    String updatedFullName,
    String updatedUserName,
    File updatedUserProfile) async {
  try {
    EasyLoading.show(status: 'Please wait...');

    final FirebaseStorage _storage = FirebaseStorage.instance;

    // Upload image to Firebase Storage
    String imagePath = 'profileImages/$userId.jpg';
    await _storage.ref().child(imagePath).putFile(updatedUserProfile);

    // Get download URL for the image
    String imageUrl = await _storage.ref().child(imagePath).getDownloadURL();

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child('users/$userId');
    databaseReference.update({'profileImage': imageUrl});
    databaseReference.update({'userFullName': updatedFullName});
    databaseReference.update({'userName': updatedUserName});
    SharedPrefrenceHelper().saveDisplayName(updatedFullName.toString().trim());
    SharedPrefrenceHelper().saveUserName(updatedUserName.toString().trim());
    SharedPrefrenceHelper().saveUserPic(imageUrl.toString().trim());
    EasyLoading.dismiss();
  } catch (e) {
    EasyLoading.dismiss();
    snackBar(context, "Failed to updated data: $e");
  }
}
