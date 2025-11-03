import 'package:flutter/material.dart';
import 'tabs/features_tab.dart';
import 'tabs/gallery_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/maps_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 1. Index for the currently selected tab
  int _selectedIndex = 0;

  // 2. List of the screens (tabs) to display
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    GalleryTab(),
    MapsTab(),
    FeaturesTab(),
  ];

  // 3. List of titles for the AppBar
  static const List<String> _titles = <String>[
    'Home',
    'Gallery',
    'Maps',
    'Features',
  ];

  // 4. Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 5. Title changes based on the selected tab
        title: Text(_titles[_selectedIndex]),
        // Optional: Add a logout button to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login and remove all other routes
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        // 6. Use IndexedStack to keep the state of each tab
        // This means scroll position, etc., is preserved when switching tabs
        child: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 7. The tabs
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Features'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey, // Important for seeing inactive tabs
        showUnselectedLabels: true, // Also important
        onTap: _onItemTapped, // 8. Link to our handler method
      ),
    );
  }
}
