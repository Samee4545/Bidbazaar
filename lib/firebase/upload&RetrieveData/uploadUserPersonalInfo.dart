import 'dart:io';

import 'package:bidbazaar/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/views/registrationLoginViews/emailLoginView.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

Future<void> signUpAndSaveDataInDB(
    BuildContext context,
    File selectedImage,
    String fullName,
    String userName,
    String userEmail,
    String userPassword) async {
  EasyLoading.show(status: 'Please wait...');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;

      await userCredential.user!.sendEmailVerification();

      SharedPrefrenceHelper().saveAccountCreatedStatus("yes");

      // Upload image to Firebase Storage
      String imagePath = 'profileImages/$uid.jpg';
      await _storage.ref().child(imagePath).putFile(selectedImage);

      // Get download URL for the image
      String imageUrl = await _storage.ref().child(imagePath).getDownloadURL();
      String formattedDate = DateFormat('d/M/yyyy').format(DateTime.now());

      UserPersonalInfoModel userPersonalInfoModel = UserPersonalInfoModel(
          profileImage: imageUrl,
          userFullName: fullName,
          userEmail: userEmail,
          userId: uid,
          userName: userName,
          userPassword: userPassword,
          accountCreatedDate: formattedDate,
          buyer: false,
          seller: false);

      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child('users/$uid');
      databaseReference.set(userPersonalInfoModel.toJson()).whenComplete(() {
        EasyLoading.dismiss();
        snackBar(context,
            "Bidbazaar's team send you email for verification pleas check it");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmailLoginInView(),
            ));
      });
    }
  } catch (e) {
    // Show an error message
    print("Failed to sign up: $e");
    snackBar(context, "Failed to sign up because: $e");
    EasyLoading.dismiss();
  }
}

Future<void> logoutAndCloseApp(BuildContext context) async {
  try {
    // Sign out the user
    await FirebaseAuth.instance.signOut();
    SharedPrefrenceHelper().saveUserId("null");

    // Close the app
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  } catch (e) {
    // Handle the error (e.g., show a snackbar or alert dialog)
    print("Error signing out: $e");
  }
}
