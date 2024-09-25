// import 'package:bidbazaar/views/registrationLoginViews/otpVerificationView.dart';
// import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// FirebaseAuth _auth = FirebaseAuth.instance;
// String? _verificationId;

// Future<void> verifyPhoneNumber(context, String phoneNumber) async {
//   await _auth.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     timeout: const Duration(seconds: 60),
//     verificationCompleted: (PhoneAuthCredential credential) async {
//       await _auth.signInWithCredential(credential);
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       if (e.code == 'invalid-phone-number') {
//         print('The provided phone number is not valid.');
//       } else {
//         print('Verification failed: ${e.message}');
//       }
//     },
//     codeSent: (String verificationId, int? resendToken) {
//       _verificationId = verificationId;
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OTPVerificationView(
//                 phoneNumber: phoneNumber, verificationId: _verificationId!),
//           ));
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {
//       snackBar(context, "Code retrieval timed out. Please try again.");
//     },
//   );
// }
