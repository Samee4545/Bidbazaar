// import 'package:bidbazaar/dashboard/dashboardNavigationBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Future<void> signUpWithFacebook(BuildContext context) async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(result.accessToken!.token);
//     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => DashBoardNavigationBar()));
//   } catch (e) {
//     print('Error signing in with Facebook: $e');
//   }
// }
