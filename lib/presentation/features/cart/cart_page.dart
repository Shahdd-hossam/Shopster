import 'package:flutter/material.dart';
import 'package:new_task/core/models/cart.dart';
import 'package:new_task/core/services/cart_service.dart';
import 'package:new_task/presentation/features/cart/empty_state_widget.dart';
import 'package:new_task/presentation/features/cart/confirmation_dialog.dart';
import 'package:new_task/presentation/features/cart/cart_details_dialog.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartController = CartService();
  List<Cart> _carts = [];
  List<Cart> _tempCarts = []; // Temporary state for immediate UI updates
  bool _isLoading = true;
  Cart? _selectedCart;

  // Controllers for editing
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCarts();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _productIdController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _loadCarts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      
      List<Cart> carts = await _cartController.fetchCarts();
      
      if (mounted) {
        setState(() {
          _carts = carts;
          _tempCarts = List.from(carts); // Initialize temp state with API data
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading carts: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _deleteCart(int cartId) async {
    // Remove from temporary state immediately
    setState(() {
      _tempCarts.removeWhere((cart) => cart.id == cartId);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cart deleted temporarily! (API call simulated)'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Simulate background API call
    _performBackgroundDeleteApiCall(cartId);
  }

  Future<void> _performBackgroundDeleteApiCall(int cartId) async {
    // This simulates the actual API delete call happening in the background
    // You can uncomment this if you want real API calls
    /*
    try {
      bool success = await _cartController.deleteCart(cartId);
      if (!success) {
        // If API call fails, you could revert the UI change here
        print('Background delete API call failed');
      }
    } catch (e) {
      print('Background delete API call failed: $e');
    }
    */
  }

  void _addNewCart() async {
    _showAddEditCartDialog();
  }

  void _editCart(Cart cart) {
    _showAddEditCartDialog(cart: cart);
  }

  void _showAddEditCartDialog({Cart? cart}) {
    final isEditing = cart != null;
    _selectedCart = cart;
    
    // Initialize controllers
    _userIdController.text = cart?.userId.toString() ?? '1';
    
    // Handle products - check if products exist and are not empty
    if (cart != null && cart.products.isNotEmpty) {
      final firstProduct = cart.products.first as Map<String, dynamic>;
      _productIdController.text = firstProduct['productId']?.toString() ?? '1';
      _quantityController.text = firstProduct['quantity']?.toString() ?? '2';
    } else {
      _productIdController.text = '1';
      _quantityController.text = '2';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Cart' : 'Add New Cart'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _productIdController,
                decoration: const InputDecoration(
                  labelText: 'Product ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _saveCart();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: Text(
              isEditing ? 'Update' : 'Add',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _saveCart() async {
    try {
      final userId = int.tryParse(_userIdController.text) ?? 1;
      final productId = int.tryParse(_productIdController.text) ?? 1;
      final quantity = int.tryParse(_quantityController.text) ?? 1;

      Cart tempCart;
      
      if (_selectedCart == null) {
        // Adding new cart
        tempCart = Cart(
          id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
          userId: userId,
          date: DateTime.now().toIso8601String(),
          products: [
            {
              'productId': productId,
              'quantity': quantity,
            },
          ],
        );
        
        // Add to temporary state immediately
        setState(() {
          _tempCarts.add(tempCart);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cart added temporarily! (API call simulated)'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Editing existing cart
        tempCart = Cart(
          id: _selectedCart!.id,
          userId: userId,
          date: _selectedCart!.date,
          products: [
            {
              'productId': productId,
              'quantity': quantity,
            },
          ],
        );
        
        // Update in temporary state immediately
        setState(() {
          int index = _tempCarts.indexWhere((c) => c.id == _selectedCart!.id);
          if (index != -1) {
            _tempCarts[index] = tempCart;
          }
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cart updated temporarily! (API call simulated)'),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      // Simulate background API call
      _performBackgroundSaveApiCall();
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving cart: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _performBackgroundSaveApiCall() async {
    // This simulates the actual API save call happening in the background
    // You can uncomment this if you want real API calls
    /*
    try {
      Map<String, dynamic> cartData = {
        'userId': int.tryParse(_userIdController.text) ?? 1,
        'date': DateTime.now().toIso8601String(),
        'products': [
          {
            'productId': int.tryParse(_productIdController.text) ?? 1,
            'quantity': int.tryParse(_quantityController.text) ?? 1,
          }
        ]
      };
      
      if (_selectedCart == null) {
        await _cartController.addCart(cartData);
      } else {
        await _cartController.updateCart(_selectedCart!.id, cartData);
      }
    } catch (e) {
      print('Background save API call failed: $e');
    }
    */
  }

  void _showCartDetails(Cart cart) {
    CartDetailsDialog.show(
      context: context,
      cart: cart,
      onDelete: () => _confirmDelete(cart.id),
    );
  }

  void _confirmDelete(int cartId) {
    ConfirmationDialog.show(
      context: context,
      title: 'Confirm Delete',
      content: 'Are you sure you want to delete this cart?',
      confirmText: 'Delete',
      onConfirm: () => _deleteCart(cartId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carts (${_carts.length})'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _loadCarts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : _carts.isEmpty
              ? _buildEmptyState()
              : _buildCartsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCart,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const EmptyStateWidget(
      icon: Icons.shopping_cart_outlined,
      title: 'No carts found',
      subtitle: 'Tap the + button to add a new cart',
    );
  }

  Widget _buildCartsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _carts.length,
      itemBuilder: (context, index) {
        final cart = _carts[index];
        return _buildCartCard(cart);
      },
    );
  }

  Widget _buildCartCard(Cart cart) {
    // Check if this is a temporary cart
    bool isTemp = _tempCarts.any((tempCart) => tempCart.id == cart.id && 
        !_carts.any((originalCart) => originalCart.id == cart.id));
    
    return CartCard(
      cart: cart,
      isTemp: isTemp,
      onTap: () => _showCartDetails(cart),
      onView: () => _showCartDetails(cart),
      onEdit: () => _editCart(cart),
      onDelete: () => _confirmDelete(cart.id),
    );
  }
}

class CartCard extends StatelessWidget {
  final Cart cart;
  final bool isTemp;
  final VoidCallback? onTap;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CartCard({
    super.key,
    required this.cart,
    this.isTemp = false,
    this.onTap,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            '${cart.id}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          children: [
            Text('Cart #${cart.id}'),
            if (isTemp) 
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
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
            Text('User ID: ${cart.userId}'),
            Text('Date: ${cart.date}'),
            Text('${cart.products.length} products'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onView != null)
              IconButton(
                onPressed: onView,
                icon: const Icon(Icons.visibility, color: Colors.blue),
              ),
            if (onEdit != null)
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Colors.green),
              ),
            if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
