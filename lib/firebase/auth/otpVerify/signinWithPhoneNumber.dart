import 'package:bidbazaar/dashboard/dashboardNavigationBar.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signInWithPhoneNumber(
    context, String verificationId, String otp) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    await _auth.signInWithCredential(credential).then(
      (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardNavigationBar(index: 0),
            ));
      },
    );
  } catch (e) {
    print('Invalid OTP. Please try again.');
    snackBar(context, 'Invalid OTP. Please try again.');
  }
}
