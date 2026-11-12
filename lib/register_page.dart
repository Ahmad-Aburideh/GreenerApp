import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Arrow + Top Space
              SizedBox(height: 32),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              // Frame 1: Title and Subtitle
              SizedBox(height: 32),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1C1E),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Create an account to continue!",
                style: TextStyle(fontSize: 14, color: Color(0xFF6C7278)),
              ),

              SizedBox(height: 24),

              // Frame 2: Input Fields
              _buildLabel("Full Name"),
              _buildInputField(hint: "Enter your Full Name"),

              SizedBox(height: 16),
              _buildLabel("Email"),
              _buildInputField(hint: "email@example.com"),

              SizedBox(height: 16),
              _buildLabel("City"),
              _buildDropdownField(),

              SizedBox(height: 16),
              _buildLabel("Phone Number"),
              _buildPhoneField(),

              SizedBox(height: 16),
              _buildLabel("Set Password"),
              _buildInputField(hint: "Enter new password", obscure: true),

              SizedBox(height: 24),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6E8C39),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Bottom Link
              Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFF6C7278)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF00BFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF6C7278),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInputField({String? hint, bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFE6E6E6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFE6E6E6)),
        ),
        suffixIcon:
            obscure
                ? Icon(Icons.visibility_off, color: Color(0xFFBFBFBF))
                : null,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(border: InputBorder.none),
        hint: Text(
          "Select City",
          style: TextStyle(color: Colors.grey.withOpacity(0.6)),
        ),
        items:
            ["Amman", "Irbid", "Zarqa"]
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Image.asset("images/flag.png", width: 24, height: 24),
          SizedBox(width: 8),
          Text("(962)", style: TextStyle(color: Color(0xFF6C7278))),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "70 000 0000",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
