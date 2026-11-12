import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ), // Set left & right spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(
                  'images/blk.png',
                ), // Replace with user profile image
                backgroundColor: Colors.grey[200], // Placeholder color
              ),
              title: Text(
                "BLK",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "BLK@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.black,
              ),
              onTap: () {
                // Navigate to profile edit page
              },
            ),

            SizedBox(height: 10),

            // Privacy & Security Section
            Text(
              "Privacy & Security",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Divider(),

            _buildSettingsItem(Icons.person, "Manage Information", () {}),
            _buildSettingsItem(Icons.lock, "Change Password", () {}),
            _buildSettingsItem(Icons.delete_sweep, "Devices", () {}),

            SizedBox(height: 10),

            // Info & Support Section
            Text(
              "Info and Support",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Divider(),

            _buildSettingsItem(
              Icons.support_agent,
              "Contact with support",
              () {},
            ),
            _buildSettingsItem(Icons.shopping_cart, "Buy new device", () {}),
            _buildSettingsItem(Icons.info, "About", () {}),

            Spacer(),

            // Logout Button
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                // Logout function
              },
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF6E8C39), // Navigation bar color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: 2, // Highlight the settings tab
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  // Custom Method to Create Settings Items
  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
      onTap: onTap,
    );
  }
}
