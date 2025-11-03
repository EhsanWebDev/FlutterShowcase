import 'package:flutter/material.dart';
import '../../models/user_model.dart'; // <-- Import model
import '../../services/api_service.dart'; // <-- Import service

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // 1. A Future to hold the state of our network call
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    // 2. Start the API call when the widget is first built
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _usersFuture = ApiService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Use FutureBuilder to handle the async states
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        // --- State 1: Loading ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- State 2: Error ---
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _fetchData, // <-- Retry button
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // --- State 3: Success ---
        if (snapshot.hasData) {
          final List<User> users = snapshot.data!;

          if (users.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          // This is the professional list view
          return RefreshIndicator(
            onRefresh: () async => _fetchData(), // Pull-to-refresh
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                // Use a Card for an "elegant" container
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    // A CircleAvatar is a very professional touch
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        user.name[0], // Display the user's first initial
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user.email),
                    onTap: () {
                      // You could navigate to a user detail screen here
                      // Navigator.push( ... );
                    },
                  ),
                );
              },
            ),
          );
        }

        // --- Fallback State ---
        return const Center(child: Text('No data available.'));
      },
    );
  }
}
