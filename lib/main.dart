import 'package:bidbazaar_admin/views/homeview.dart';
import 'package:bidbazaar_admin/views/splashScreenView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:204022041701:android:a2d8d305a0f7a5cc204a8c',
      apiKey: 'AIzaSyAnOiCP3ZCs50wvEFlYkOIsNElyTGMksVI',
      messagingSenderId: '204022041701',
      projectId: 'bidbazaar-2e5fe',
      databaseURL: 'https://bidbazaar-2e5fe-default-rtdb.firebaseio.com/',
      storageBucket: 'gs://bidbazaar-2e5fe.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: SplashScreenView(),
    );
  }
}
