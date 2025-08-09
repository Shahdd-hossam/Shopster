import 'package:flutter/material.dart';
import 'package:new_task/core/controllers/user_controller.dart';
import 'package:new_task/core/models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController _userController = UserController();
  List<User> _users = [];
  List<User> _tempUsers = [];
  bool _isLoading = true;
  bool _isEditing = false;
  User? _selectedUser;

  // Controllers for editing
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    try {
      setState(() => _isLoading = true);
      final users = await _userController.getAllUsers();
      if (mounted) {
        setState(() {
          _users = users;
          _tempUsers = List.from(users); // Initialize temp state with API data
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading users: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _startEditing(User user) {
    setState(() {
      _isEditing = true;
      _selectedUser = user;
      _nameController.text = user.name;
      _emailController.text = user.email;
      _usernameController.text = user.username;
      _passwordController.text = user.password;
      _phoneController.text = user.phone;
      _addressController.text = user.address;
    });
  }

  void _startAdding() {
    setState(() {
      _isEditing = true;
      _selectedUser = null;
      _nameController.clear();
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _phoneController.clear();
      _addressController.clear();
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _selectedUser = null;
    });
  }

  Future<void> _saveUser() async {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      // Create temporary user object for immediate UI update
      User tempUser;
      if (_selectedUser == null) {
        // Creating new user - use a temporary ID
        tempUser = User(
          id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
          name: _nameController.text,
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          address: _addressController.text,
        );
        
        // Add to temporary state immediately
        setState(() {
          _tempUsers.add(tempUser);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added temporarily! (API call simulated)'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Editing existing user
        tempUser = User(
          id: _selectedUser!.id,
          name: _nameController.text,
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          address: _addressController.text,
        );
        
        // Update in temporary state immediately
        setState(() {
          int index = _tempUsers.indexWhere((user) => user.id == _selectedUser!.id);
          if (index != -1) {
            _tempUsers[index] = tempUser;
          }
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User updated temporarily! (API call simulated)'),
            backgroundColor: Colors.green,
          ),
        );
      }

      _cancelEditing();
      
      // Simulate API call in background (optional)
      _performBackgroundApiCall();
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving user: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _performBackgroundApiCall() async {
    // This simulates the actual API call happening in the background
    // You can uncomment this if you want real API calls
    /*
    try {
      Map<String, dynamic> userData = {
        'name': {'firstname': _nameController.text, 'lastname': ''},
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
        'address': {'city': _addressController.text},
      };

      if (_selectedUser == null) {
        await _userController.addUser(userData);
      } else {
        await _userController.updateUser(_selectedUser!.id, userData);
      }
    } catch (e) {
      // Handle background API error
      print('Background API call failed: $e');
    }
    */
  }

  Future<void> _deleteUser(User user) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete "${user.name}"?\n\nThis action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      // Remove from temporary state immediately
      setState(() {
        _tempUsers.removeWhere((u) => u.id == user.id);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted temporarily! (API call simulated)'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Simulate background API call
      _performBackgroundDeleteApiCall(user.id);
    }
  }

  Future<void> _performBackgroundDeleteApiCall(int userId) async {
    // This simulates the actual API delete call happening in the background
    // You can uncomment this if you want real API calls
    /*
    try {
      await _userController.deleteUser(userId);
    } catch (e) {
      // Handle background API error
      print('Background delete API call failed: $e');
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing 
            ? (_selectedUser == null ? 'Add User' : 'Edit User')
            : 'Users (${_tempUsers.length}${_tempUsers.length != _users.length ? ' • ${_tempUsers.length - _users.length} temp' : ''})'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: _isEditing
            ? [
                IconButton(
                  onPressed: _saveUser,
                  icon: const Icon(Icons.save),
                  tooltip: 'Save',
                ),
                IconButton(
                  onPressed: _cancelEditing,
                  icon: const Icon(Icons.close),
                  tooltip: 'Cancel',
                ),
              ]
            : [
                IconButton(
                  onPressed: _startAdding,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add User',
                ),
                IconButton(
                  onPressed: _loadUsers,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                ),
              ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            )
          : _isEditing
              ? _buildEditForm()
              : _buildUsersList(),
    );
  }

  Widget _buildEditForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedUser == null ? 'Add New User' : 'Edit User Details',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.account_circle,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Address',
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(_selectedUser == null ? 'Add User' : 'Update User'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _cancelEditing,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool required = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label + (required ? ' *' : ''),
        prefixIcon: Icon(icon, color: Colors.teal),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    if (_tempUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No users found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Add some users to get started',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tempUsers.length,
      itemBuilder: (context, index) {
        final user = _tempUsers[index];
        final isTemporary = !_users.any((u) => u.id == user.id);
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: isTemporary ? Colors.green.shade50 : null,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isTemporary ? Colors.green : Colors.teal,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    user.name, 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
                if (isTemporary)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'TEMP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${user.username}'),
                Text('Email: ${user.email}'),
                if (user.phone.isNotEmpty) Text('Phone: ${user.phone}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _startEditing(user),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () => _deleteUser(user),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete',
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
