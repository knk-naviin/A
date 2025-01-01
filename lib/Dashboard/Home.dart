import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Authentication/otpInputScreen.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}



class _homeState extends State<home> {


  Future<void> signOut() async{
    await GoogleSignIn().signOut().then((onValue){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
      );
    }).catchError((onError){
      print(onError);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout))
        ],
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
