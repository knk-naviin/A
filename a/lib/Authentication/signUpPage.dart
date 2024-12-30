// import 'package:flutter/material.dart';
//
// class CustomUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(120),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           flexibleSpace: Column(
//             children: [
//               // Top banner
//
//               // Location and cart
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Coimbatore',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         Text(
//                           'Tamil Nadu - India',
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     Stack(
//                       children: [
//                         Icon(
//                           Icons.shopping_cart_outlined,
//                           size: 28,
//                           color: Colors.black,
//                         ),
//                         Positioned(
//                           right: 0,
//                           child: CircleAvatar(
//                             radius: 8,
//                             backgroundColor: Colors.red,
//                             child: Text(
//                               '3',
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 10),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         currentIndex: 0,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'UC',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_outlined),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Stack(
//               children: [
//                 Icon(Icons.card_giftcard_outlined),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: CircleAvatar(
//                     radius: 4,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             label: 'Rewards',
//           ),
//           BottomNavigationBarItem(
//             icon: Stack(
//               children: [
//                 Icon(Icons.local_offer_outlined),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Text(
//                     'New',
//                     style: TextStyle(
//                         fontSize: 10, color: Colors.green),
//                   ),
//                 ),
//               ],
//             ),
//             label: 'Native',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//       body: Center(child: Text('Body Content')),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Full Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Email',
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
              text: 'Sign Up',
              onPressed: () {
                // Handle sign-up logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
