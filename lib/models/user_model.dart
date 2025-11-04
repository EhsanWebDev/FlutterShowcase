import 'dart:convert';

List<User> userListFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
  final int id;
  final String name; // Our app's UI still just wants a single 'name' string
  final String email;

  User({required this.id, required this.name, required this.email});

  // --- THE MODEL'S PARSING LOGIC IS UPDATED ---
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    // We combine 'firstname' and 'lastname' from the nested
    // 'name' object into our single 'name' variable.
    name: "${json["name"]["firstname"]} ${json["name"]["lastname"]}",
    email: json["email"],
  );
  // --- END OF CHANGE ---
}
