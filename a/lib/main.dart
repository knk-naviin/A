import 'package:a/Startup/startUpModule.dart';
import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.white
  ),
) );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return startUp();
  }
}
