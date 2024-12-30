import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Enter your name',
              icon: Icons.person,
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Enter your email',
              icon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Submit',
              onPressed: () {
                // Handle profile update logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
