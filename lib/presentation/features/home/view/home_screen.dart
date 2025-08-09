import 'package:flutter/material.dart';
import 'package:new_task/core/Themes/app_theme.dart';
import 'package:new_task/core/animations/cart_animation.dart';
import 'package:new_task/core/animations/page_transition.dart';
import 'package:new_task/core/managers/alert_managers.dart';
import 'package:new_task/core/models/product.dart';
import 'package:new_task/presentation/features/cart/cart_page.dart';
import 'package:new_task/presentation/features/home/home_widgets/category_section.dart';
import 'package:new_task/presentation/features/home/home_widgets/search_bar.dart' as custom_search;
import 'package:new_task/presentation/features/home/home_widgets/top_bar.dart';
import 'package:new_task/presentation/features/products/product_card.dart';
import 'package:new_task/presentation/features/profile/profile_page.dart';
import 'package:new_task/presentation/features/widgets/buttomNavigator_bar.dart';
import 'package:new_task/core/controllers/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = ProductController();
  int _currentIndex = 0;
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  String searchQuery = '';
  String selectedCategory = 'All';
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCartCount();
  }

  void _loadProducts() async {
    try {
      List<Product> apiProducts = await productController.getAllProducts();
      if (mounted) {
        setState(() {
          products = apiProducts;
          _applyFilters();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading products: {e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _loadCartCount() async {
  // ...existing code...
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      _applyFilters();
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      selectedCategory = category;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Product> filtered = products;

    // Apply category filter
    if (selectedCategory != 'All') {
      filtered = filtered
          .where((product) =>
              product.category.toLowerCase() == selectedCategory.toLowerCase())
          .toList();
    }

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.category.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    filteredProducts = filtered;
  }

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        Navigator.push(
          context,
          AnimationUtils.createRoute<void>(
            page: const CartPage(),
            transitionType: TransitionType.slideFromRight,
          ),
        ).then((_) => _loadCartCount());
        break;
      case 2:
        // Navigate to favorites (using ProfilePage as placeholder for now)
        Navigator.push(
          context,
          AnimationUtils.createRoute<void>(
            page: const ProfilePage(),
            transitionType: TransitionType.slideFromRight,
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          AnimationUtils.createRoute<void>(
            page: const ProfilePage(),
            transitionType: TransitionType.slideFromRight,
          ),
        );
        break;
    }

    // Reset to home after navigation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _currentIndex = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onToggleTheme: ThemeManager.toggleTheme,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.teal),
              title: const Text('Refresh Products'),
              onTap: () {
                Navigator.pop(context);
                _loadProducts();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                AlertManager.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadProducts();
          _loadCartCount();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello, Friend",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "What would you like to buy today?",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              custom_search.SearchBar(
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      title: "All",
                      icon: Icons.grid_view,
                      isSelected: selectedCategory == 'All',
                      onTap: () => _onCategoryChanged('All'),
                    ),
                    CategoryCard(
                      title: "Electronics",
                      icon: Icons.electric_bolt,
                      isSelected: selectedCategory == 'electronics',
                      onTap: () => _onCategoryChanged('electronics'),
                    ),
                    CategoryCard(
                      title: "Jewelry",
                      icon: Icons.diamond,
                      isSelected: selectedCategory == 'jewelery',
                      onTap: () => _onCategoryChanged('jewelery'),
                    ),
                    CategoryCard(
                      title: "Men's",
                      icon: Icons.man,
                      isSelected: selectedCategory == "men's clothing",
                      onTap: () => _onCategoryChanged("men's clothing"),
                    ),
                    CategoryCard(
                      title: "Women's",
                      icon: Icons.woman,
                      isSelected: selectedCategory == "women's clothing",
                      onTap: () => _onCategoryChanged("women's clothing"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  ),
                )
              else if (filteredProducts.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.isEmpty
                              ? 'No products available'
                              : 'No products found for "$searchQuery"',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2, // Increased from 0.8 to make cards shorter
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return CardAnimations.slideUpAnimation(
                        delay: Duration(milliseconds: index * 100),
                        child: ProductCard(
                          product: filteredProducts[index],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: BottomNavigatorBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
     selectedItemColor: Colors.teal,
     unselectedItemColor: Colors.grey,
     type: BottomNavigationBarType.fixed,
     cartItemCount: cartItemCount,
),
    );
  }
}
