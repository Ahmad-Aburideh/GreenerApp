import 'package:flutter/material.dart';
import 'package:greener/devices_page.dart';
import 'package:greener/settings_page.dart';
import 'package:greener/statistics.dart';
import 'package:greener/change_floor_page.dart'; // Optional

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar (Frame 2)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi BLK",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  "Location: Amman",
                  style: TextStyle(fontSize: 18, color: Color(0xFF595959)),
                ),
              ],
            ),
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('images/blk.png'), // Profile Image
            ),
          ],
        ),
      ),

      // Body Content
      body: Column(
        children: [
          // Separator Line (Frame 3)
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFEBEBEB),
          ),

          // Devices Header (Frame 4)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Devices",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DevicesPage()),
                    );
                  },

                  child: Text(
                    "View all",
                    style: TextStyle(fontSize: 14, color: Color(0xFF00BFFF)),
                  ),
                ),
              ],
            ),
          ),

          // Device Containers (Frame 5 & 6)
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildDeviceCard(
                  deviceNo: 1,
                  floor: 1,
                  levels: [25, 50, 75, 100],
                ),
                _buildDeviceCard(
                  deviceNo: 2,
                  floor: 2,
                  levels: [50, 75, 100, 100],
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar (Frame 7)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF6E8C39),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white.withOpacity(0.8),
            ), // Highlighted
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: 0, // Home is selected
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticsPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
      ),
    );
  }

  // Device Card (Frame 5 & 6)
  Widget _buildDeviceCard({
    required int deviceNo,
    required int floor,
    required List<int> levels,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 12,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Device No: $deviceNo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Floor: $floor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Waste Levels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularIndicator(levels[0], "Plastic"),
              _buildCircularIndicator(levels[1], "Metal"),
              _buildCircularIndicator(levels[2], "Paper"),
              _buildCircularIndicator(levels[3], "Trash"),
            ],
          ),
        ],
      ),
    );
  }

  // Circular Indicator for Waste Levels (Frame 6)
  Widget _buildCircularIndicator(int level, String type) {
    Color color;
    String text = "$level%";

    if (level <= 25) {
      color = Colors.green;
    } else if (level <= 50) {
      color = Colors.yellow;
    } else if (level <= 75) {
      color = Colors.orange;
    } else {
      color = Colors.red;
      text = "FULL!";
    }

    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: level == 100 ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(type, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
