import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_grid_item.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  // Fungsi untuk format rupiah
  String _formatRupiah(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  List<Product> get products {
    return [
      // === BOUQUET PRODUCTS ===
      Product(id: '1', name: 'Spark Bouquet', price: 250000, category: 'Bouquet', image: 'assets/products/spark_bouquet.png', rating: 4.9),
      Product(id: '2', name: 'Magic Bouquet', price: 180000, category: 'Bouquet', image: 'assets/products/magic_bouquet.png', rating: 4.7),
      Product(id: '3', name: 'Soft Elegant', price: 150000, category: 'Bouquet', image: 'assets/products/soft_bouquet1.png', rating: 4.8),
      Product(id: '4', name: 'Soft Deluxe', price: 165000, category: 'Bouquet', image: 'assets/products/soft_bouquet2.png', rating: 4.6),
      Product(id: '5', name: 'White Pure', price: 220000, category: 'Bouquet', image: 'assets/products/white_bouquet.png', rating: 4.7),
      Product(id: '6', name: 'Red Romance', price: 275000, category: 'Bouquet', image: 'assets/products/wedding_rose_red.png', rating: 4.9),

      // === WEDDING PRODUCTS ===
      Product(id: '7', name: 'Blue Wedding', price: 450000, category: 'Wedding', image: 'assets/products/wedding_biru.png', rating: 5.0),
      Product(id: '8', name: 'Pink Dream', price: 420000, category: 'Wedding', image: 'assets/products/wedding_merahmuda.png', rating: 4.9),
      Product(id: '9', name: 'White Elegance', price: 480000, category: 'Wedding', image: 'assets/products/spark_bouquet.png', rating: 4.8),
      Product(id: '10', name: 'Rose Pink', price: 380000, category: 'Wedding', image: 'assets/products/wedding_rose_pingke.png', rating: 4.7),
      Product(id: '11', name: 'Rose Red', price: 520000, category: 'Wedding', image: 'assets/products/wedding_rose_red.png', rating: 5.0),
      Product(id: '12', name: 'Rose White', price: 460000, category: 'Wedding', image: 'assets/products/soft_bouquet1.png', rating: 4.9),

      // === DECOR PRODUCTS ===
      Product(id: '13', name: 'Modern Home Decor', price: 350000, category: 'Decor', image: 'assets/products/home_decor1.png', rating: 4.6),
      Product(id: '14', name: 'Classic Home Decor', price: 280000, category: 'Decor', image: 'assets/products/home_decor2.png', rating: 4.5),
      Product(id: '15', name: 'Luxury Home Decor', price: 420000, category: 'Decor', image: 'assets/products/home_decor3.png', rating: 4.7),
      Product(id: '16', name: 'Art Wall Decor', price: 175000, category: 'Decor', image: 'assets/products/wall_decor1.png', rating: 4.4),
      Product(id: '17', name: 'Modern Wall Decor', price: 195000, category: 'Decor', image: 'assets/products/wall_decor2.png', rating: 4.3),
      Product(id: '18', name: 'Premium Wall Decor', price: 320000, category: 'Decor', image: 'assets/products/wall_decor3.png', rating: 4.6),

      // === ACCESSORIES PRODUCTS ===
      Product(id: '19', name: 'Elegant Bow', price: 45000, category: 'Accessories', image: 'assets/products/bow.png', rating: 4.2),
      Product(id: '20', name: 'Greeting Card', price: 25000, category: 'Accessories', image: 'assets/products/card.png', rating: 4.1),
      Product(id: '21', name: 'Gift Box', price: 35000, category: 'Accessories', image: 'assets/products/gift_box.png', rating: 4.3),
      Product(id: '22', name: 'LED Light', price: 75000, category: 'Accessories', image: 'assets/products/light.png', rating: 4.4),
      Product(id: '23', name: 'Decorative Ribbon', price: 30000, category: 'Accessories', image: 'assets/products/ribbon.png', rating: 4.2),
      Product(id: '24', name: 'Flower Vase', price: 120000, category: 'Accessories', image: 'assets/products/vase.png', rating: 4.5),
    ];
  }

  double _getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 380 ? 12 : 16;
  }

  double _getSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 380 ? 8 : 12;
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 2; 
    if (width < 600) return 2;
    if (width < 900) return 3; 
    return 4; 
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 0.65; 
    if (width < 600) return 0.7;  
    if (width < 900) return 0.75; 
    return 0.8;
  }

  @override
  Widget build(BuildContext context) {
    final categoryProducts = products
        .where((product) => product.category == categoryName)
        .toList();

    final isSmall = MediaQuery.of(context).size.width < 380;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: isSmall ? 18 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: isSmall ? 20 : 24),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, size: isSmall ? 20 : 24),
            onPressed: () {},
          ),
        ],
      ),
      body: categoryProducts.isEmpty
          ? _buildEmptyState(context)
          : _buildProductGrid(context, categoryProducts),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: isSmall ? 50 : 60,
            color: Colors.grey[300],
          ),
          SizedBox(height: isSmall ? 12 : 16),
          Text(
            'No products available',
            style: TextStyle(
              fontSize: isSmall ? 16 : 18,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isSmall ? 8 : 12),
          Text(
            'Check back later for new arrivals',
            style: TextStyle(
              fontSize: isSmall ? 12 : 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<Product> categoryProducts) {
    final isSmall = MediaQuery.of(context).size.width < 380;

    return Padding(
      padding: EdgeInsets.all(_getPadding(context)),
      child: Column(
        children: [
          // HEADER INFO
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 12 : 16,
              vertical: isSmall ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: _getCategoryColor(categoryName).withOpacity(0.1),
              borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
            ),
            child: Row(
              children: [
                Icon(
                  _getCategoryIcon(categoryName),
                  color: _getCategoryColor(categoryName),
                  size: isSmall ? 18 : 20,
                ),
                SizedBox(width: isSmall ? 8 : 12),
                Text(
                  '${categoryProducts.length} products available',
                  style: TextStyle(
                    fontSize: isSmall ? 13 : 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: _getSpacing(context) + 4),

          // PRODUCTS GRID
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: _getSpacing(context),
                mainAxisSpacing: _getSpacing(context),
                childAspectRatio: _getChildAspectRatio(context),
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                return ProductGridItem(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // HELPER METHODS FOR CATEGORY STYLING
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Wedding':
        return Color(0xFFFF6B8B);
      case 'Decor':
        return Color(0xFF4CD97B);
      case 'Bouquet':
        return Color(0xFF9C57FF);
      case 'Accessories':
        return Color(0xFFFFD166);
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Wedding':
        return Icons.celebration;
      case 'Decor':
        return Icons.architecture;
      case 'Bouquet':
        return Icons.local_florist;
      case 'Accessories':
        return Icons.card_giftcard;
      default:
        return Icons.category;
    }
  }

  BottomNavigationBar _buildBottomNav(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFFF6B8B),
      unselectedItemColor: Colors.grey[500],
      currentIndex: 1, // Categories active
      elevation: 4,
      iconSize: isSmall ? 18 : 20,
      selectedFontSize: isSmall ? 9 : 10,
      unselectedFontSize: isSmall ? 9 : 10,
      onTap: (index) {
        if (index == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }


  bool get isSmall => false; 
}