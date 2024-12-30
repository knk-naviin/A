import "package:a/Authentication/loginPage.dart";
import "package:flutter/material.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

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
      textDirection: TextDirection.ltr, // Use TextDirection.rtl for right-to-left languages

      child:  Scaffold(

        body: Stack(
          children: [

            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                buildPage(
                  color: Colors.white,
                  image: 'assets/images/shop.png',
                  title: 'Find What You Need, When You Need It',
                  description: 'Instantly check if nearby shops and service providers are open and ready to assist you, all at your fingertips.',
                ),
                buildPage(
                  color: Colors.white,
                  image: 'assets/images/dailydeals.png',
                  title: 'Never Miss a Deal',
                  description: 'Stay updated with the latest offers and discounts posted by shops near you, tailored to your location.',
                ),
                buildPage(
                  color: Colors.white,
                  image: 'assets/images/service.png',
                  title: 'Convenient Home Services',
                  description: 'Find trusted plumbers, electricians, carpenters, and more to handle all your home service needs effortlessly.',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("A",style: TextStyle(
                          color: Colors.black87.withOpacity(0.7),
                          fontSize: 100
                      ),)
                      // Image.asset("assets/images/Logo.png",scale: 50,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Anything Anytime at Anywhere",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                      ),)
                      // Image.asset("assets/images/Logo.png",scale: 50,),
                    ],
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 230,
              left: 20,
              child: isLastPage
                  ? SizedBox.shrink()
                  : TextButton(
                onPressed: () {
                  _pageController.jumpToPage(2);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text('Skip',style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700
                ),),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 110,
              child: isLastPage
                  ? OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => loginPage()),
                  );
                },
                child: Text('Get Started'),
                style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                        (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return BorderSide(color: Colors.indigoAccent, width: 2.0);
                      }
                      return BorderSide(color: Colors.indigoAccent, width: 2.0);
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.indigoAccent.withOpacity(0.9); // Background color when pressed
                      }
                      return Colors.indigoAccent; // Default background color
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white; // Text color when pressed
                      }
                      return Colors.white; // Default text color
                    },
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent), // No splash
                ),
              )



                  : Text("")
            ),
            Positioned(
              bottom: 250,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,

                  effect: WormEffect(
                    type: WormType.thinUnderground,
                    activeDotColor: Colors.black45,
                    dotColor: Colors.grey.shade300,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget buildPage({
    required Color color,
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              description,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}




