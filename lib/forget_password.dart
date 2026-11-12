import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greener/login_page.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  List<String> otp = ["", "", "", ""]; // To store the entered OTP ssssssss
  int currentIndex = 0; // Current active box

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Responsive width

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
          ), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ), // Navigate back to login
                  );
                },
              ),

              SizedBox(height: 20),

              // Verification Code Title
              Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 8),

              // Subtitle
              RichText(
                text: TextSpan(
                  text: "We have sent the OTP code via email to ",
                  style: TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
                  children: [
                    TextSpan(
                      text: "********999@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: " for the verification process",
                      style: TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return _buildOtpBox(index);
                }),
              ),

              SizedBox(height: 24),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6E8C39), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Color(0xFF6E8C39),
                      ), // Border color
                    ),
                  ),
                  onPressed: () {
                    // Handle OTP verification
                    print("Entered OTP: ${otp.join()}");
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // OTP Box Builder
  Widget _buildOtpBox(int index) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              index == currentIndex
                  ? Color(0xFF6E8C39)
                  : Color(0xFFE6E6E6), // Highlight active box
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: TextField(
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 24,
          color: Color(0xFF999999),
        ), // Number color
        decoration: InputDecoration(
          counterText: "", // Hide counter
          border: InputBorder.none, // Remove extra borders
        ),
        onChanged: (value) {
          setState(() {
            otp[index] = value;
            if (value.isNotEmpty && index < 3) {
              currentIndex = index + 1; // Move to next box
            } else if (value.isEmpty && index > 0) {
              currentIndex = index - 1; // Move back on delete
            }
          });
        },
      ),
    );
  }
}
