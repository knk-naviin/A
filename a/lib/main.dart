import 'package:a/Startup/startUpModule.dart';
import 'package:flutter/material.dart';

void main() => runApp( new MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
  title: 'Flutter Demo',
  theme: ThemeData(
    // Set global colors
    scaffoldBackgroundColor: Colors.white, // White background for all screens
    primaryColor: Colors.indigoAccent, // Primary app color
    hintColor: Colors.indigoAccent, // For older widgets (if needed)
    colorScheme: ColorScheme.light(
      primary: Colors.indigoAccent, // Used for AppBar and primary buttons
      secondary: Colors.indigoAccent, // Accent color for FABs, etc.
      background: Colors.white, // General background
    ),
    appBarTheme: AppBarTheme(
      color: Colors.indigoAccent, // AppBar background color
      foregroundColor: Colors.white, // Text and icons in AppBar
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.indigoAccent, // Background color for buttons
      textTheme: ButtonTextTheme.primary, // Makes button text white
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.indigoAccent, // TextButton text color
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.indigoAccent), // Border color
        foregroundColor: Colors.indigoAccent, // Text color
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigoAccent, // Background color
        foregroundColor: Colors.white, // Text color
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.indigoAccent, // FAB color
      foregroundColor: Colors.white, // Icon color
    ),
  ),
) );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return startUp();
  }
}
