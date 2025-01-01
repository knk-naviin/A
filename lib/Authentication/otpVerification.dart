import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OtpInputScreen extends StatefulWidget {
  final String verificationId;

  const OtpInputScreen({required this.verificationId, super.key});

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
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
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
    }
  }

  Future<void> saveUserToFirestore(User? phoneUser, User? googleUser) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(phoneUser?.uid);

    final userDoc = await userRef.get();

    if (userDoc.exists) {
      // User already exists
      final data = userDoc.data()!;
      final existingEmail = data['email'];

      if (googleUser?.email != existingEmail) {
        // Show dialog with existing email
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

        throw Exception(
            'Phone number already linked to a different email: $existingEmail');
      }
    } else {
      // Create or update the user document
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
                ElevatedButton(
                  onPressed: verifyOtp,
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
          ),
          if (isLoading)
            Center(
              child: Container(

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade800, Colors.blue.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircularProgressIndicator(),
                  ),),
            ),
          if (isSuccess)
            Center(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleTransition(
                              scale: _animationController.drive(
                                CurveTween(curve: Curves.elasticOut),
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.indigoAccent,
                                size: 100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Hooray! ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: ',Your Profile Has Been Updated',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ))),
        ],
      ),
    );
  }
}
