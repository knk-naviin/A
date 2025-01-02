import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentAddress = "Fetching location...";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndUpdateFirestore();
  }

  Future<void> _getCurrentLocationAndUpdateFirestore() async {
    if (!mounted) return; // Prevent further execution if the widget is not mounted
    setState(() => isLoading = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            currentAddress = "Location services are disabled.";
            isLoading = false;
          });
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          if (mounted) {
            setState(() {
              currentAddress = "Location permission denied.";
              isLoading = false;
            });
          }
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String address = await _getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );

      await _updateUserLocationInFirestore(
        position.latitude,
        position.longitude,
        address,
      );

      if (mounted) {
        setState(() {
          currentAddress = address;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          currentAddress = "Error fetching location.";
          isLoading = false;
        });
      }
    }
  }

  Future<String> _getAddressFromLatLng(double latitude, double longitude) async {
    final String apiKey = "AIzaSyC8tiKzqnGXHnYQVOozoLtIouydYk1UAxM"; // Replace with your API key
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      if (data["status"] == "OK") {
        return data["results"][0]["formatted_address"];
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
    return "Address not found.";
  }

  Future<void> _updateUserLocationInFirestore(
      double latitude, double longitude, String address) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = auth.currentUser?.uid ?? "";

    if (userId.isEmpty) {
      print("No user is logged in.");
      return;
    }

    try {
      await firestore.collection("users").doc(userId).update({
        'location': {
          'latitude': latitude,
          'longitude': longitude,
        },
        'address': address,
      });
      print("User location updated successfully.");
    } catch (e) {
      print("Error updating location in Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Updater"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Current Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              currentAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
