import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BottomNavScreens/Profile/Profile.dart';
import '../BottomNavScreens/notificationPage.dart';
import '../dashBoardScreen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          DashBoardScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: Colors.black,
            child: TabBar(
              onTap: _onItemTapped,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide.none,
              ),
              tabs: [
                _tabItem(
                  Icon(Icons.home_filled),
                  'Home',
                  isSelected: _selectedIndex == 0,
                ),
                _tabItem(
                  Icon(Icons.notifications_rounded),
                  'Notification',
                  isSelected: _selectedIndex == 1,
                ),
                _tabItem(
                  Icon(Icons.person),
                  'Profile',
                  isSelected: _selectedIndex == 2,
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey.withOpacity(0.3),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          child,
          Text(label, style: TextStyle(fontSize: 8)),
        ],
      ),
    );
  }
}