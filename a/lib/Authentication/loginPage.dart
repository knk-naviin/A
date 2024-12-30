import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose(); // Dispose FocusNode when screen is disposed
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override

  Widget build(BuildContext context) {
    // Create FocusNode to manage focus


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset("assets/images/Logo.png",scale: 35,),
              SizedBox(height: 30),
              TextField(
                focusNode: _emailFocusNode, // Attach focus n
                decoration: InputDecoration(
                
                  filled: true,
                  fillColor: Colors.grey.shade200, // Light background color
                  hintText: 'Email or Phone Number',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey.shade600, // Icon color
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide.none, // No border side
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blueAccent), // Focused border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400), // Default border color
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                focusNode: _passwordFocusNode,
                obscureText: true, // For password input
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200, // Light background color
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.grey.shade600, // Icon color
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide.none, // No border side
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blueAccent), // Focused border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400), // Default border color
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15), backgroundColor: Colors.blueAccent, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
