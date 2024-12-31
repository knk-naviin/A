import 'package:a/Dashboard/Home.dart';
import 'package:a/Startup/startUpModule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authentication/otpInputScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  runApp(
    MaterialApp(
      home: user == null ? const OtpVerificationScreen() : const home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return startUp();
  }
}
