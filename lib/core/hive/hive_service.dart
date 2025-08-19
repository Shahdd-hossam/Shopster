import 'package:hive_flutter/hive_flutter.dart';
import '../constants/hive_constants.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters here
    // Hive.registerAdapter(ProductAdapter());
    // Hive.registerAdapter(UserAdapter());
    
    // Open boxes
    await Hive.openBox<Map>(HiveConstants.productsBox);
    await Hive.openBox<Map>(HiveConstants.cartBox);
    await Hive.openBox<Map>(HiveConstants.favoritesBox);
    await Hive.openBox<Map>(HiveConstants.userBox);
  }
  
  static Box<Map> get productsBox => Hive.box<Map>(HiveConstants.productsBox);
  static Box<Map> get cartBox => Hive.box<Map>(HiveConstants.cartBox);
  static Box<Map> get favoritesBox => Hive.box<Map>(HiveConstants.favoritesBox);
  static Box<Map> get userBox => Hive.box<Map>(HiveConstants.userBox);
}
