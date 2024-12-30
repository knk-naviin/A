import 'package:a/Authentication/signUpPage.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'otpVerification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Email or Phone Number',
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Login',
              onPressed: () {
                // Navigate to OTP screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
