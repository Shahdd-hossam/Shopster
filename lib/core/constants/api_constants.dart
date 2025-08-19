class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  
  // Auth endpoints
  static const String login = '/auth/login';
  
  // User endpoints
  static const String users = '/users';
  static const String user = '/users/{id}';
  
  // Product endpoints
  static const String products = '/products';
  static const String product = '/products/{id}';
  static const String categories = '/products/categories';
  static const String productsInCategory = '/products/category/{category}';
  
  // Cart endpoints
  static const String carts = '/carts';
  static const String userCarts = '/carts/user/{userId}';
  static const String cart = '/carts/{id}';
}
