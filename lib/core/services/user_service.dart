import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final String baseUrl = 'https://fakestoreapi.com/users';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User?> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }

  Future<User?> updateUser(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<User?> addUser(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<User?> authenticateUser(String username, String password) async {
    try {
      final users = await fetchUsers();
      for (User user in users) {
        if (user.username == username && user.password == password) {
          return user;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  Future<bool> validateUser(int id, String password) async {
    final user = await getUserById(id);
    if (user != null && user.password == password) {
      return true;
    }
    return false;
  }
}
