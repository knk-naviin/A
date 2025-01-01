import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authentication/otpInputScreen.dart';
import 'Dashboard/Home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  runApp(
    MaterialApp(
      home: user == null ? const OtpVerificationScreen() : const home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
