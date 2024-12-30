import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Enter OTP',
              icon: Icons.lock,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Verify',
              onPressed: () {
                // Handle OTP verification
              },
            ),
          ],
        ),
      ),
    );
  }
}
