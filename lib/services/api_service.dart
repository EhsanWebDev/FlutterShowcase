import 'package:http/http.dart' as http;
import '../models/user_model.dart'; // <-- Import your model

class ApiService {
  static const String _usersUrl = 'https://jsonplaceholder.typicode.com/users';

  // Static method so we don't have to instantiate the class
  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(_usersUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // then parse the JSON.
        final List<User> users = userListFromJson(response.body);
        return users;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception(
          'Failed to load users (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      // Handle network errors or parsing errors
      throw Exception('Failed to load users: $e');
    }
  }
}
