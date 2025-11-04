import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  // --- THIS IS THE ONLY CHANGE IN THIS FILE ---
  static const String _usersUrl = 'https://fakestoreapi.com/users';
  // --- END OF CHANGE ---

  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(_usersUrl));

      if (response.statusCode == 200) {
        final List<User> users = userListFromJson(response.body);
        return users;
      } else {
        throw Exception(
          'Failed to load users (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
