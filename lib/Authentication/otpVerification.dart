// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:google_sign_in/google_sign_in.dart';
// // // import 'package:otp_pin_field/otp_pin_field.dart';
// // // import 'package:pin_keyboard/pin_keyboard.dart';
// // //
// // // class OtpInputScreen extends StatefulWidget {
// // //   final String verificationId;
// // //
// // //   const OtpInputScreen({required this.verificationId, super.key});
// // //
// // //   @override
// // //   _OtpInputScreenState createState() => _OtpInputScreenState();
// // // }
// // //
// // // class _OtpInputScreenState extends State<OtpInputScreen>
// // //     with SingleTickerProviderStateMixin {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final List<TextEditingController> otpControllers =
// // //       List.generate(6, (index) => TextEditingController());
// // //   late AnimationController _animationController;
// // //   bool isLoading = false;
// // //   bool isSuccess = false;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _animationController = AnimationController(
// // //       duration: const Duration(milliseconds: 500),
// // //       vsync: this,
// // //     );
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _animationController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   Future<void> verifyOtp() async {
// // //     setState(() => isLoading = true);
// // //
// // //     String otp = otpControllers.map((controller) => controller.text).join();
// // //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
// // //       verificationId: widget.verificationId,
// // //       smsCode: otp,
// // //     );
// // //
// // //     try {
// // //       final userCredential = await _auth.signInWithCredential(credential);
// // //       await signInWithGoogle(userCredential.user);
// // //     } catch (e) {
// // //       setState(() => isLoading = false);
// // //       ScaffoldMessenger.of(context)
// // //           .showSnackBar(SnackBar(content: Text('Error: $e')));
// // //     }
// // //   }
// // //
// // //   Future<void> signInWithGoogle(User? phoneUser) async {
// // //     try {
// // //       final GoogleSignIn googleSignIn = GoogleSignIn();
// // //       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
// // //
// // //       if (googleUser == null) {
// // //         setState(() => isLoading = false);
// // //         return; // User cancelled Google Sign-In
// // //       }
// // //
// // //       final GoogleSignInAuthentication googleAuth =
// // //           await googleUser.authentication;
// // //       final AuthCredential credential = GoogleAuthProvider.credential(
// // //         accessToken: googleAuth.accessToken,
// // //         idToken: googleAuth.idToken,
// // //       );
// // //
// // //       final userCredential = await _auth.signInWithCredential(credential);
// // //       final user = userCredential.user;
// // //
// // //       await saveUserToFirestore(phoneUser, user);
// // //       setState(() {
// // //         isLoading = false;
// // //         isSuccess = true;
// // //       });
// // //
// // //       _animationController.forward();
// // //       Future.delayed(const Duration(seconds: 2), () {
// // //         Navigator.pushReplacementNamed(context, '/home');
// // //       });
// // //     } catch (e) {
// // //       setState(() => isLoading = false);
// // //       ScaffoldMessenger.of(context)
// // //           .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
// // //     }
// // //   }
// // //
// // //   Future<void> saveUserToFirestore(User? phoneUser, User? googleUser) async {
// // //     final FirebaseFirestore firestore = FirebaseFirestore.instance;
// // //     final userRef = firestore.collection('users').doc(phoneUser?.uid);
// // //
// // //     final userDoc = await userRef.get();
// // //
// // //     if (userDoc.exists) {
// // //       // User already exists
// // //       final data = userDoc.data()!;
// // //       final existingEmail = data['email'];
// // //
// // //       if (googleUser?.email != existingEmail) {
// // //         // Show dialog with existing email
// // //         await showDialog(
// // //           context: context,
// // //           builder: (context) => AlertDialog(
// // //             title: const Text('Account Already Linked'),
// // //             content: Text(
// // //               'This phone number is already linked with the email: $existingEmail. Please use the same email.',
// // //             ),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () => Navigator.pop(context),
// // //                 child: const Text('OK'),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //
// // //         throw Exception(
// // //             'Phone number already linked to a different email: $existingEmail');
// // //       }
// // //     } else {
// // //       // Create or update the user document
// // //       await userRef.set({
// // //         'phoneNumber': phoneUser?.phoneNumber ?? googleUser?.phoneNumber,
// // //         'email': googleUser?.email,
// // //         'name': googleUser?.displayName,
// // //         'photoUrl': googleUser?.photoURL,
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 const Text('Enter the OTP sent to your number.'),
// // //                 const SizedBox(height: 16),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                   children: List.generate(
// // //                     6,
// // //                     (index) => SizedBox(
// // //                       width: 50,
// // //                       child: TextField(
// // //
// // //                         controller: otpControllers[index],
// // //                         textAlign: TextAlign.center,
// // //                         keyboardType: TextInputType.number,
// // //                         maxLength: 1,
// // //                         decoration: InputDecoration(
// // //                           counterText: '',
// // //                           filled: false,
// // //
// // //                           border: OutlineInputBorder(
// // //                             borderRadius: BorderRadius.circular(5),
// // //                           ),
// // //                         ),
// // //                         onChanged: (value) {
// // //                           if (value.isNotEmpty && index < 5) {
// // //                             FocusScope.of(context).nextFocus();
// // //                           } else if (value.isEmpty && index > 0) {
// // //                             FocusScope.of(context).previousFocus();
// // //                           }
// // //                         },
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //
// // //                 const SizedBox(height: 24),
// // //                 ElevatedButton(
// // //                   onPressed: verifyOtp,
// // //                   child: const Text('Verify OTP'),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           if (isLoading)
// // //             Center(
// // //               child: Container(
// // //
// // //                   decoration: BoxDecoration(
// // //                     gradient: LinearGradient(
// // //                       begin: Alignment.topRight,
// // //                       end: Alignment.bottomLeft,
// // //                       colors: [
// // //                         Colors.blue,
// // //                         Colors.red,
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   child: Container(
// // //                     width: 300,
// // //                     height: 200,
// // //                     decoration: BoxDecoration(
// // //                       borderRadius: BorderRadius.circular(20),
// // //                       gradient: LinearGradient(
// // //                         colors: [Colors.blue.shade800, Colors.blue.shade400],
// // //                         begin: Alignment.topLeft,
// // //                         end: Alignment.bottomRight,
// // //                       ),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.3),
// // //                           spreadRadius: 5,
// // //                           blurRadius: 7,
// // //                           offset: Offset(0, 3),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: CircularProgressIndicator(),
// // //                   ),),
// // //             ),
// // //           if (isSuccess)
// // //             Center(
// // //                 child: Scaffold(
// // //                     backgroundColor: Colors.white,
// // //                     body: Column(
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         Row(
// // //                           mainAxisAlignment: MainAxisAlignment.center,
// // //                           children: [
// // //                             ScaleTransition(
// // //                               scale: _animationController.drive(
// // //                                 CurveTween(curve: Curves.elasticOut),
// // //                               ),
// // //                               child: Icon(
// // //                                 Icons.check_circle,
// // //                                 color: Colors.indigoAccent,
// // //                                 size: 100,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         SizedBox(height: 10,),
// // //                         Row(
// // //                           mainAxisAlignment: MainAxisAlignment.center,
// // //                           children: [
// // //                             RichText(
// // //                               text: TextSpan(
// // //                                 text: 'Hooray! ',
// // //                                 style: TextStyle(
// // //                                     fontWeight: FontWeight.bold,
// // //                                     color: Colors.black),
// // //                                 children: const <TextSpan>[
// // //                                   TextSpan(
// // //                                       text: ',Your Profile Has Been Updated',
// // //                                       style: TextStyle(
// // //                                           color: Colors.black,
// // //                                           fontWeight: FontWeight.normal)),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         )
// // //                       ],
// // //                     ))),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:otp_pin_field/otp_pin_field.dart';
// import 'package:pin_keyboard/pin_keyboard.dart';
//
// class OtpInputScreen extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;
//
//   const OtpInputScreen({
//     required this.verificationId,
//     required this.phoneNumber,
//     super.key,
//   });
//
//   @override
//   _OtpInputScreenState createState() => _OtpInputScreenState();
// }
//
// class _OtpInputScreenState extends State<OtpInputScreen>
//     with SingleTickerProviderStateMixin {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final List<TextEditingController> otpControllers =
//   List.generate(6, (index) => TextEditingController());
//   late AnimationController _animationController;
//   bool isLoading = false;
//   bool isSuccess = false;
//   String? verificationId;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     verificationId = widget.verificationId;
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> verifyOtp() async {
//     setState(() => isLoading = true);
//
//     String otp = otpControllers.map((controller) => controller.text).join();
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId!,
//       smsCode: otp,
//     );
//
//     try {
//       final userCredential = await _auth.signInWithCredential(credential);
//       await signInWithGoogle(userCredential.user);
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error: $e';
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(errorMessage)));
//     }
//   }
//
//   Future<void> resendOtp() async {
//     setState(() => isLoading = true);
//     await _auth.verifyPhoneNumber(
//       phoneNumber: widget.phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//         setState(() => isLoading = false);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         setState(() {
//           isLoading = false;
//           errorMessage = e.message ?? 'Verification failed.';
//         });
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(errorMessage)));
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           this.verificationId = verificationId;
//           isLoading = false;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   Future<void> signInWithGoogle(User? phoneUser) async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//       if (googleUser == null) {
//         setState(() => isLoading = false);
//         return; // User cancelled Google Sign-In
//       }
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final userCredential = await _auth.signInWithCredential(credential);
//       final user = userCredential.user;
//
//       await saveUserToFirestore(phoneUser, user);
//       setState(() {
//         isLoading = false;
//         isSuccess = true;
//       });
//
//       _animationController.forward();
//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.pushReplacementNamed(context, '/home');
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
//     }
//   }
//
//   Future<void> saveUserToFirestore(User? phoneUser, User? googleUser) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final userRef = firestore.collection('users').doc(phoneUser?.uid);
//
//     final userDoc = await userRef.get();
//
//     if (userDoc.exists) {
//       final data = userDoc.data()!;
//       final existingEmail = data['email'];
//
//       if (googleUser?.email != existingEmail) {
//         await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Account Already Linked'),
//             content: Text(
//               'This phone number is already linked with the email: $existingEmail. Please use the same email.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//         throw Exception('Phone number already linked to a different email: $existingEmail');
//       }
//     } else {
//       await userRef.set({
//         'phoneNumber': phoneUser?.phoneNumber ?? googleUser?.phoneNumber,
//         'email': googleUser?.email,
//         'name': googleUser?.displayName,
//         'photoUrl': googleUser?.photoURL,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }
//
//   Future<void> changePhoneNumber() async {
//     // Implement a logic to change the phone number
//     // This could navigate to another screen or prompt the user for the new phone number
//     Navigator.pop(context); // Returning to the previous screen
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('Phone number change initiated.')));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Enter the OTP sent to your number.'),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: List.generate(
//                     6,
//                         (index) => SizedBox(
//                       width: 50,
//                       child: TextField(
//                         controller: otpControllers[index],
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         decoration: InputDecoration(
//                           counterText: '',
//                           filled: false,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 5) {
//                             FocusScope.of(context).nextFocus();
//                           } else if (value.isEmpty && index > 0) {
//                             FocusScope.of(context).previousFocus();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: verifyOtp,
//                   child: const Text('Verify OTP'),
//                 ),
//                 const SizedBox(height: 16),
//                 if (errorMessage.isNotEmpty)
//                   Text(
//                     errorMessage,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: resendOtp,
//                       child: const Text(
//                         'Resend OTP',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     TextButton(
//                       onPressed: changePhoneNumber,
//                       child: const Text(
//                         'Change Number',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//           if (isSuccess)
//             Center(
//               child: Scaffold(
//                 backgroundColor: Colors.white,
//                 body: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ScaleTransition(
//                           scale: _animationController.drive(
//                             CurveTween(curve: Curves.elasticOut),
//                           ),
//                           child: Icon(
//                             Icons.check_circle,
//                             color: Colors.indigoAccent,
//                             size: 100,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             text: 'Hooray! ',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                             children: const <TextSpan>[
//                               TextSpan(
//                                   text: ',Your Profile Has Been Updated',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.normal)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpInputScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpInputScreen({
    required this.verificationId,
    required this.phoneNumber,
    super.key,
  });

  @override
  _OtpInputScreenState createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());
  late AnimationController _animationController;
  bool isLoading = false;
  bool isSuccess = false;
  String? verificationId;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    verificationId = widget.verificationId;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    setState(() => isLoading = true);

    String otp = otpControllers.map((controller) => controller.text).join();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otp,
    );

    try {
      final userCredential = await _auth.signInWithCredential(credential);
      await signInWithGoogle(userCredential.user);
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  Future<void> signInWithGoogle(User? phoneUser) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      await saveUserToFirestore(phoneUser, user);

      setState(() {
        isLoading = false;
        isSuccess = true;
      });

      _animationController.forward();
      Future.delayed(const Duration(seconds: 2), () async {
        await fetchAndSaveUserLocation();
        Navigator.pushReplacementNamed(context, '/home');
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
    }
  }

  Future<void> fetchAndSaveUserLocation() async {
    setState(() => isLoading = true);

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String address = await getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );

      await updateUserLocationInFirestore(
        position.latitude,
        position.longitude,
        address,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final String apiKey = "YOUR_API_KEY"; // Replace with your Google API key
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      if (data["status"] == "OK") {
        return data["results"][0]["formatted_address"];
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
    return "Address not found.";
  }

  Future<void> updateUserLocationInFirestore(
      double latitude, double longitude, String address) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser?.uid ?? "";

    if (userId.isEmpty) return;

    try {
      await firestore.collection("users").doc(userId).set({
        'location': GeoPoint(latitude, longitude),
        'address': address,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating location: $e");
    }
  }

  Future<void> saveUserToFirestore(User? phoneUser, User? googleUser) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(phoneUser?.uid);

    final userDoc = await userRef.get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      final existingEmail = data['email'];

      if (googleUser?.email != existingEmail) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Account Already Linked'),
            content: Text(
              'This phone number is already linked with the email: $existingEmail. Please use the same email.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        throw Exception('Phone number already linked to a different email: $existingEmail');
      }
    } else {
      await userRef.set({
        'phoneNumber': phoneUser?.phoneNumber ?? googleUser?.phoneNumber,
        'email': googleUser?.email,
        'name': googleUser?.displayName,
        'photoUrl': googleUser?.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter the OTP sent to your number.'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: 50,
                      child: TextField(
                        controller: otpControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: verifyOtp,
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (isSuccess)
            Center(
              child: ScaleTransition(
                scale: _animationController.drive(
                  CurveTween(curve: Curves.elasticOut),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.indigoAccent,
                  size: 100,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

