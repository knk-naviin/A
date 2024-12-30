import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otpInputScreen.dart';
import '../widgets/primary_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

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
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
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
                initialCountryCode: 'IN', // Default country code
                onChanged: (phone) {
                  // Get the complete phone number
                  print(phone.completeNumber);
                  phoneController.text = phone.completeNumber;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Verify',
                onPressed: () {
                  // Navigate to OTP screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OtpInputScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
