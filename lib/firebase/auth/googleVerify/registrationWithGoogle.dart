// import 'package:bidbazaar/dashboard/dashboardNavigationBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// Future<UserCredential?> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return null;

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final UserCredential? userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     if (userCredential != null) {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => DashBoardNavigationBar()));
//     }
//   } catch (e) {
//     print('Error signing in with Google: $e');
//   }
// }
