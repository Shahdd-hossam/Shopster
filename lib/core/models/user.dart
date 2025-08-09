class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String name;
  final String phone;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String firstName = '';
    String lastName = '';
    
    if (json['name'] is Map) {
      firstName = json['name']['firstname'] ?? '';
      lastName = json['name']['lastname'] ?? '';
    } else if (json['name'] is String) {
      firstName = json['name'] ?? '';
    }
    
    String fullName = firstName;
    if (lastName.isNotEmpty) {
      fullName = '$firstName $lastName'.trim();
    }
    
    String address = '';
    if (json['address'] is Map) {
      final addressMap = json['address'];
      final city = addressMap['city'] ?? '';
      final street = addressMap['street'] ?? '';
      final number = addressMap['number']?.toString() ?? '';
      
      if (street.isNotEmpty && number.isNotEmpty) {
        address = '$number $street, $city'.trim();
      } else if (street.isNotEmpty) {
        address = '$street, $city'.trim();
      } else {
        address = city;
      }
    }
    
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      name: fullName,
      phone: json['phone'] ?? '',
      address: address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}
