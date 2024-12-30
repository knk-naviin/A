import "package:flutter/material.dart";

class startUp extends StatefulWidget {
  const startUp({super.key});

  @override
  State<startUp> createState() => _startUpState();
}

class _startUpState extends State<startUp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Use TextDirection.rtl for right-to-left languages

      child: Scaffold(
       backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("A.",style: TextStyle(
                 fontSize: 60,
               )),
             ],
           )

          ],
        )
      ),
    );
  }
}
