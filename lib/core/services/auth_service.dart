import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../remote/api_service.dart';
import '../../../remote/api_constants.dart';
import '../../../data/models/user_model.dart';

class AuthService extends ChangeNotifier {
  final ApiService _apiService;
  
  UserModel? _currentUser;
  String? _token;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  // Getters
  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthService({required ApiService apiService}) : _apiService = apiService {
    _loadFromStorage();
  }

  // Load user data from local storage on app start
  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    final userToken = prefs.getString('user_token');
    
    if (userData != null && userToken != null) {
      _currentUser = UserModel.fromJson(json.decode(userData));
      _token = userToken;
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  // Save user data to local storage
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUser != null && _token != null) {
      await prefs.setString('user_data', json.encode(_currentUser!.toJson()));
      await prefs.setString('user_token', _token!);
    }
  }

  // Clear user data from local storage
  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.remove('user_token');
  }

  // Login with FakeStore API
  Future<bool> login({required String username, required String password}) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Login API call
      final response = await _apiService.post(
        path: ApiConstants.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        _token = response.data['token'];
        
        // Get user details
        await _fetchUserDetails(username);
        
        _isLoggedIn = true;
        await _saveToStorage();
        
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Login error: $e');
    }
    
    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Fetch user details from API
  Future<void> _fetchUserDetails(String username) async {
    try {
      // Get all users and find the one with matching username
      final response = await _apiService.get(path: ApiConstants.users);
      
      if (response.statusCode == 200) {
        final List<dynamic> users = response.data;
        final userData = users.firstWhere(
          (user) => user['username'] == username,
          orElse: () => null,
        );
        
        if (userData != null) {
          _currentUser = UserModel.fromJson(userData);
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    _isLoggedIn = false;
    await _clearStorage();
    notifyListeners();
  }

  // Check if user session is valid (you can add token validation here)
  Future<bool> validateSession() async {
    // For now, just check if user data exists
    return _isLoggedIn && _currentUser != null && _token != null;
  }
}
