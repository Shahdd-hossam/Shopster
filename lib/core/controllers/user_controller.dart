import 'package:new_task/core/services/user_service.dart';
import '../models/user.dart';

class UserController {
  final UserService _userService = UserService();

  Future<List<User>> getAllUsers() async {
    return await _userService.fetchUsers();
  }

  Future<User?> getUser(int id) async {
    return await _userService.getUserById(id);
  }

  Future<bool> deleteUser(int id) async {
    return await _userService.deleteUser(id);
  }

  Future<User?> updateUser(int id, Map<String, dynamic> data) async {
    return await _userService.updateUser(id, data);
  }

  Future<User?> addUser(Map<String, dynamic> data) async {
    return await _userService.addUser(data);
  }

  Future<User?> authenticateUser(String username, String password) async {
    return await _userService.authenticateUser(username, password);
  }

  Future<bool> validateUser(int id, String password) async {
    return await _userService.validateUser(id, password);
  }
}
