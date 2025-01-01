import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/primary_button.dart';

class OtpInputScreen extends StatefulWidget {
  final String verificationId;

  const OtpInputScreen({required this.verificationId, super.key});

  @override
  _OtpInputScreenState createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());
  bool isLoading = false;

  Future<void> verifyOtp() async {
    setState(() => isLoading = true);

    String otp = otpControllers.map((controller) => controller.text).join();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      final userCredential = await _auth.signInWithCredential(credential);
      await signInWithGoogle(userCredential.user);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> signInWithGoogle(User? phoneUser) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => isLoading = false);
        return; // User cancelled Google Sign-In
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      await saveUserToFirestore(phoneUser, user);
      setState(() => isLoading = false);

      // Navigate to dashboard or home screen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
    }
  }

  Future<void> saveUserToFirestore(User? phoneUser, User? googleUser) async {
    if (googleUser != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(googleUser.uid);

      await userRef.set({
        'phoneNumber': phoneUser?.phoneNumber ?? googleUser.phoneNumber,
        'name': googleUser.displayName,
        'email': googleUser.email,
        'photoUrl': googleUser.photoURL,
        'dateOfBirth': null, // Add a field for DOB (can be updated later)
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
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
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                PrimaryButton(
                  text: 'Verify OTP',
                  onPressed: verifyOtp,
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
