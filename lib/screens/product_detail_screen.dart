import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image - FIXED
            Container(
              width: double.infinity,
              height: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFFD1DC), // PASTEL PINK background
              ),
              child: _buildProductImage(),
            ),
            const SizedBox(height: 20),
            
            // Product Name
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Price
            Text(
              '\$${widget.product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6EC7), // NEON PINK
              ),
            ),
            const SizedBox(height: 20),
            
            // Availability
            Row(
              children: [
                const Text(
                  'Availability',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.product.inStock ? 'in Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.product.inStock ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Rating
            const Row(
              children: [
                Text(
                  'Rating',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star_half, color: Colors.amber, size: 20),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Quantity
            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            
            // Quantity Counter
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: _decrementQuantity,
                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: _incrementQuantity,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart functionality
                  _showAddToCartDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6EC7), // NEON PINK
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem('Home'),
            _buildBottomNavItem('Cating'),
            _buildBottomNavItem('Oak'),
            _buildBottomNavItem('Cart'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    // Cek jika product.image ada dan tidak kosong
    if (widget.product.image != null && widget.product.image.isNotEmpty) {
      // Jika image adalah URL
      if (widget.product.image.startsWith('http')) {
        return Image.network(
          widget.product.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderImage();
          },
        );
      } 
      // Jika image adalah asset local
      else {
        return Image.asset(
          widget.product.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderImage();
          },
        );
      }
    } 
    // Jika tidak ada image, tampilkan placeholder
    else {
      return _buildPlaceholderImage();
    }
  }

  Widget _buildPlaceholderImage() {
    return Icon(
      Icons.shopping_bag,
      size: 80,
      color: Color(0xFFFF6EC7), // NEON PINK
    );
  }

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          content: Text('${widget.product.name} has been added to cart!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavItem(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}