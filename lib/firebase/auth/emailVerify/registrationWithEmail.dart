import 'package:bidbazaar/dashboard/dashboardNavigationBar.dart';
import 'package:bidbazaar/firebase/upload&RetrieveData/retrieveUserPersonalInfo.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/widgets/commonWidgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> signInWithEmailPassword(
    BuildContext context, String email, String password) async {
  try {
    EasyLoading.show(status: 'Please wait...');
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential != null) {
      if (userCredential.user!.emailVerified) {
        EasyLoading.dismiss();

        UserPersonalInfoModel? userInfo = await getUserPersonalInfoFromDatabase(
            userCredential.user!.uid.toString().trim());
        if (userInfo != null) {
          SharedPrefrenceHelper()
              .saveDisplayName(userInfo.userFullName.toString().trim());
          SharedPrefrenceHelper()
              .saveUserName(userInfo.userName.toString().trim());
          SharedPrefrenceHelper()
              .saveUserEmail(userInfo.userEmail.toString().trim());
          SharedPrefrenceHelper()
              .saveUserId(userCredential.user!.uid.toString().trim());
          SharedPrefrenceHelper()
              .saveUserPic(userInfo.profileImage.toString().trim());
        }

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoardNavigationBar(
                      index: 0,
                    )));
      } else {
        EasyLoading.dismiss();
        snackBar(context, "PLease Verify your email before login");
      }
    } else {
      snackBar(context, "Email or password is wrong");
    }
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    snackBar(context, "Email or password is wrong");
  }
}

Future<void> passwordReset(BuildContext context, String userEmail) async {
  try {
    EasyLoading.show(status: 'PLease wait...');
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (userEmail == auth.currentUser!.email) {
      await auth.sendPasswordResetEmail(email: userEmail).whenComplete(() {
        snackBar(context, "Reset Password link sent to $userEmail");
      });
    } else {
      snackBar(context, "Your email is not registered with bidbazaar");
    }
    EasyLoading.dismiss();
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    snackBar(context, "Error for reset password: $e");
  }
}
