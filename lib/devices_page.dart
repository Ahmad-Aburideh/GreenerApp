import 'package:flutter/material.dart';
import 'change_floor_page.dart';

class DevicesPage extends StatelessWidget {
  final List<Map<String, dynamic>> devices = [
    {"id": 1, "floor": 1},
    {"id": 2, "floor": 2},
    {"id": 3, "floor": 2},
  ];

  DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Devices",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children:
              devices.map((device) {
                return _buildDeviceItem(context, device["id"], device["floor"]);
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDeviceItem(BuildContext context, int deviceNo, int floor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Device $deviceNo",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: Icon(Icons.delete_sweep, color: Colors.black),
          title: Text("Device No: $deviceNo\nFloor: $floor"),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChangeFloorPage(
                        deviceNo: deviceNo,
                        currentFloor: floor,
                      ),
                ),
              );
            },
            child: Text(
              "Change Floor",
              style: TextStyle(color: Color(0xFF00BFFF)),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
