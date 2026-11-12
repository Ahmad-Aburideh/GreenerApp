import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greener/login_page.dart'; // Import Login Page
import 'package:greener/settings_page.dart'; // Import Settings Page
import 'package:google_fonts/google_fonts.dart'; // Ensure you have Google Fonts installed
import 'package:greener/change_floor_page.dart';
import 'package:greener/devices_page.dart';
import 'package:greener/forget_password.dart';
import 'package:greener/change_password_page.dart';
import 'package:greener/home_page.dart';
import 'package:greener/register_page.dart';
import 'package:greener/forget_password_email.dart';
import 'package:greener/statistics.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

// ChangeFloorPage(deviceNo: 1, currentFloor: 1)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for Fade Out Effect
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Fade-out duration
    );
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    // Wait for 4 seconds then start fade out animation
    Timer(Duration(seconds: 4), () {
      _controller.forward();
    });

    // Navigate to LoginPage after fade out animation
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bigger Logo (Ensure image exists in assets folder)
              Image.asset(
                'images/greener_text.png', // Your logo image
                height: 200, // Increased size
              ),

              SizedBox(height: 20),

              // Enhanced Slogan (Centered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'The place were you can save the world',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Animated Loading Indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E8C39)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
