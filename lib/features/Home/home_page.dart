import 'package:flutter/material.dart';
import 'package:new_app/core/services/products_service.dart';
import 'package:new_app/features/Home/widgets/search_bar.dart';
import 'package:new_app/features/Home/widgets/banner.dart';
import 'package:new_app/features/Home/widgets/categories.dart';
import 'package:new_app/common/custom_app_bar.dart';
import 'package:new_app/common/bottomnav_bar.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/features/Home/widgets/products_list.dart';
import 'package:new_app/remote/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

final ApiService apiService = ApiService(); 
ProductsService productsService = ProductsService(apiService: apiService);

class HomePageState extends State<HomePage> {
  List<Product> allProducts = [];   
  List<Product> products = [];      
  List<String> categories = [];
  String searchQuery = '';
  String selectedCategory = 'All';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch all products 
  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
  final fetchedProducts = await productsService.getProducts();
      setState(() {
        allProducts = fetchedProducts;
        products = fetchedProducts;
        categories = [
          'All',
          ...fetchedProducts.map((p) => p.category).toSet(),
        ];
      });
    } catch (_) {
      setState(() {
        allProducts = [];
        products = [];
        categories = ['All'];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handle search query changes
  void _handleSearchChanged(String value) {
    setState(() {
      searchQuery = value;
      _applyFilters();
    });
  }

  // Handle category selection
  void _handleCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _applyFilters();
    });
  }

  // Apply filters locally
  void _applyFilters() {
    List<Product> filtered = allProducts;

    if (selectedCategory != 'All') {
      filtered = filtered.where((p) => p.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) =>
              p.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    setState(() {
      products = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final horizontal = media.size.width * 0.04;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Products",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("See All"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Welcome back!"),
                          Text("Explore our products"),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Search bar
                      SearchBarWidget(onChanged: _handleSearchChanged),
                      const SizedBox(height: 14),

                      // Banner
                      const BannerWidget(),
                      const SizedBox(height: 14),

                      // Categories
                      CategoriesWidget(
                        categories: categories,
                        selectedCategory: selectedCategory,
                        onCategorySelected: _handleCategorySelected,
                      ),
                      const SizedBox(height: 14),

                      // Products grid
                      SizedBox(
                        height: media.size.height * 0.65,
                        child: ProductsList(
                          products: products,
                          isLoading: isLoading,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: !isLoading,
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onHomePressed: () => Navigator.pushReplacementNamed(context, '/home'),
        onCartPressed: () => Navigator.pushReplacementNamed(context, '/cart'),
        onProfilePressed: () => Navigator.pushReplacementNamed(context, '/profile'),
      ),
    );
  }
}
