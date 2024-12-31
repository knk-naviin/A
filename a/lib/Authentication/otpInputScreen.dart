// import 'package:a/Authentication/profileUpdate.dart';
// import 'package:flutter/material.dart';
// import '../widgets/primary_button.dart';
//
// class OtpInputScreen extends StatelessWidget {
//   const OtpInputScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               const Text(
//                 'Enter the 5-digit OTP sent to your mobile number.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(
//                   5,
//                       (index) => SizedBox(
//                     width: 50,
//                     child: TextField(
//                       textAlign: TextAlign.center,
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       style: const TextStyle(fontSize: 20),
//                       decoration: InputDecoration(
//                         counterText: '',
//                         filled: true,
//                         fillColor: Colors.grey[100],
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: const BorderSide(
//                               color: Colors.indigoAccent, width: 2),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               PrimaryButton(
//                 text: 'Submit OTP',
//                 onPressed: () {
//                   // Navigate to profile update
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileUpdateScreen()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:a/Authentication/profileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otpInputScreen.dart';
import '../widgets/primary_button.dart';
import 'otpVerification.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  void sendOtp(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically signs the user in with the OTP
          await _auth.signInWithCredential(credential);
          navigateToProfileUpdate();
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message ?? 'Verification failed.')));
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpInputScreen(verificationId: verificationId)),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void navigateToProfileUpdate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileUpdateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/Logo.png', height: 100),
                    const SizedBox(height: 16),
                    const Text(
                      'Anything • Anywhere • Anytime',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Welcome',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Enter mobile number',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                        color: Colors.indigoAccent, width: 2),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  phoneController.text = phone.completeNumber;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Verify',
                onPressed: () {
                  sendOtp(phoneController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
