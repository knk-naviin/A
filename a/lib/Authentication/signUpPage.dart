import 'package:flutter/material.dart';

class CustomUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Column(
            children: [
              // Top banner

              // Location and cart
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coimbatore',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'Tamil Nadu - India',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 28,
                          color: Colors.black,
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(
                              '3',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'UC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.card_giftcard_outlined),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.local_offer_outlined),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    'New',
                    style: TextStyle(
                        fontSize: 10, color: Colors.green),
                  ),
                ),
              ],
            ),
            label: 'Native',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(child: Text('Body Content')),
    );
  }
}

