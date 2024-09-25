import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


Future<String> checkCurrentUser(context) async {
  User? user = _auth.currentUser;
  if (user != null) {
    return user.uid.toString();
  }
  else {
    return "";
  }
}