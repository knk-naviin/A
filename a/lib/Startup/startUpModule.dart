import 'package:a/Authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Authentication/otpInputScreen.dart';

class startUp extends StatefulWidget {
  const startUp({super.key});

  @override
  State<startUp> createState() => _startUpState();
}

class _startUpState extends State<startUp> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            // PageView for Onboarding Screens
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                buildPage(
                  image: 'assets/images/shop.png',
                  title: 'Find What You Need, When You Need It',
                  description:
                  'Instantly check if nearby shops and service providers are open and ready to assist you, all at your fingertips.',
                ),
                buildPage(
                  image: 'assets/images/dailydeals.png',
                  title: 'Never Miss a Deal',
                  description:
                  'Stay updated with the latest offers and discounts posted by shops near you, tailored to your location.',
                ),
                buildPage(
                  image: 'assets/images/service.png',
                  title: 'Convenient Home Services',
                  description:
                  'Find trusted plumbers, electricians, carpenters, and more to handle all your home service needs effortlessly.',
                ),
              ],
            ),

            // Company Logo and Tagline
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Company Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Logo.png",// Replace with your logo asset
                        height: 50,
                        scale: 35,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Company Tagline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Anything • Anywhere • Anytime",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Skip Button
            Positioned(
              top: 60,
              right: 20,
              child: isLastPage
                  ? SizedBox.shrink()
                  : TextButton(
                onPressed: () {
                  _pageController.jumpToPage(2);
                },
                style: ButtonStyle(
                  overlayColor:
                  MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            // Get Started Button
            Positioned(
              bottom: 150,
              left: 50,
              right: 50,
              child: isLastPage
                  ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => OtpVerificationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 50),
                  backgroundColor: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : SizedBox.shrink(),
            ),

            // Page Indicator
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: Colors.indigoAccent,
                    dotColor: Colors.grey.shade300,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
