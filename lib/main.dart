import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authentication/otpInputScreen.dart';
import 'Authentication/otpVerification.dart';
import 'Dashboard/Home.dart';
import 'Startup/startUpModule.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user == null ? '/' : '/home',
      routes: {
        '/': (context) => const OtpVerificationScreen(),
        '/home': (context) => const home(),
        '/otp': (context) => const OtpInputScreen(verificationId: '', phoneNumber: '',),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Page not found!'),
          ),
        ),
      ),
    );
  }
}
