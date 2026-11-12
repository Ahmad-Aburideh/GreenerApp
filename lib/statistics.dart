import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  Map<String, int> imageCount = {
    'Plastic': 0,
    'Metal': 0,
    'Trash': 0,
    'Paper': 0,
  };

  int totalImages = 0;
  int selectedTab = 0;
  final List<String> tabs = ['Daily', 'Weekly', 'Monthly', 'yearly'];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    fetchImageCounts();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchImageCounts() async {
    await Future.wait([
      countImagesInCategory('Plastic'),
      countImagesInCategory('Metal'),
      countImagesInCategory('Trash'),
      countImagesInCategory('Paper'),
    ]);
    setState(() {});
  }

  Future<void> countImagesInCategory(String category) async {
    final ListResult result =
        await FirebaseStorage.instance.ref().child(category).listAll();

    setState(() {
      imageCount[category] = result.items.length;
      totalImages += result.items.length;
    });
  }

  double getPercentage(String category) {
    if (totalImages == 0) return 0;
    return (imageCount[category]! / totalImages) * 100;
  }

  List<PieChartSectionData> getPieChartSections() {
    final colors = {
      'Plastic': Colors.deepOrange,
      'Paper': Colors.yellow,
      'Metal': Colors.deepPurple,
      'Trash': Colors.teal,
    };

    return imageCount.entries.map((entry) {
      return PieChartSectionData(
        color: colors[entry.key],
        value: entry.value.toDouble(),
        title: '',
        radius: 50,
      );
    }).toList();
  }

  Widget buildLegend() {
    final colors = {
      'Trash': Colors.teal,
      'Metal': Colors.deepPurple,
      'Paper': Colors.yellow,
      'Plastic': Colors.deepOrange,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          colors.keys.map((key) {
            return Row(
              children: [
                Container(width: 12, height: 12, color: colors[key]),
                SizedBox(width: 4),
                Text(
                  "$key\n${getPercentage(key).toStringAsFixed(1)}%",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget buildDeviceCards() {
    List<Map<String, dynamic>> devices = [
      {'name': 'Device 3', 'count': 230},
      {'name': 'All Devices', 'count': totalImages},
      {'name': 'Device 1', 'count': 500},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children:
            devices.map((device) {
              bool isAll = device['name'] == 'All Devices';
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                padding: EdgeInsets.all(16),
                width: 130,
                decoration: BoxDecoration(
                  color: isAll ? Color(0xFF83914C) : Color(0xFFE1E6CF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      device['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isAll ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Total\ninteractions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isAll ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      device['count'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isAll ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = totalImages == 0;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Color(0xFF4C602A), // أخضر غامق
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Statistics',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(tabs.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(tabs[index]),
                      selected: selectedTab == index,
                      selectedColor: Color(0xFF83914C),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            selectedTab == index ? Colors.white : Colors.black,
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedTab = index;
                          _controller.forward(from: 0); // يبدأ الانميشن
                        });
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 24),

              if (isLoading)
                CircularProgressIndicator()
              else
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 170,
                        width: 170,
                        child: PieChart(
                          PieChartData(
                            sections: getPieChartSections(),
                            centerSpaceRadius: 45,
                            sectionsSpace: 2,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'All Devices',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '$totalImages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Total interactions',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 16),
              if (!isLoading) buildLegend(),

              SizedBox(height: 20),
              if (!isLoading) buildDeviceCards(),
            ],
          ),
        ),
      ),
    );
  }
}
