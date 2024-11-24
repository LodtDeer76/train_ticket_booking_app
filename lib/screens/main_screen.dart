import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../screens/booking_history_screen.dart';

class MainScreen extends StatefulWidget {
  final int selectedIndex;

  const MainScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BookingHistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
