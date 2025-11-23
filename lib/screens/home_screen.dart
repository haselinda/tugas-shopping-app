import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import 'product_detail_screen.dart'; // IMPORT PRODUCT DETAIL
import '../models/product.dart'; // IMPORT PRODUCT MODEL

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Wedding',
      'icon': Icons.celebration,
      'color': Color(0xFFFF6EC7),
      'gradient': [Color(0xFFFF6EC7), Color(0xFFFFD1DC)],
    },
    {
      'name': 'Decor',
      'icon': Icons.architecture,
      'color': Color(0xFFFFD700),
      'gradient': [Color(0xFFFFD700), Color(0xFFFFD1DC)],
    },
    {
      'name': 'Bouquet',
      'icon': Icons.local_florist,
      'color': Color(0xFFFFD1DC),
      'gradient': [Color(0xFFFFD1DC), Color(0xFFFF6EC7)],
    },
    {
      'name': 'Accessories',
      'icon': Icons.card_giftcard,
      'color': Color(0xFFFF6EC7),
      'gradient': [Color(0xFFFF6EC7), Color(0xFFFFD700)],
    },
  ];

  // FUNGSI FORMAT RUPIAH
  String _formatRupiah(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  // DATA PRODUK POPULAR YANG KONSISTEN
  List<Product> get popularProducts {
    return [
      Product(
        id: '1', 
        name: 'Spark Bouquet', 
        price: 250000, 
        category: 'Bouquet', 
        image: 'assets/products/spark_bouquet.png', 
        rating: 4.9
      ),
      Product(
        id: '7', 
        name: 'Blue Wedding', 
        price: 450000, 
        category: 'Wedding', 
        image: 'assets/products/wedding_biru.png', 
        rating: 5.0
      ),
      Product(
        id: '2', 
        name: 'Magic Bouquet', 
        price: 180000, 
        category: 'Bouquet', 
        image: 'assets/products/magic_bouquet.png', 
        rating: 4.7
      ),
      Product(
        id: '13', 
        name: 'Modern Home Decor', 
        price: 350000, 
        category: 'Decor', 
        image: 'assets/products/home_decor1.png', 
        rating: 4.6
      ),
    ];
  }

  // RESPONSIVE METHODS
  double _getProductCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 110; // iPhone SE
    if (width < 600) return 130; // Mobile
    return 150; // Tablet/Desktop
  }

  double _getProductImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 80; // iPhone SE
    if (width < 600) return 100; // Mobile
    return 120; // Tablet/Desktop
  }

  double _getProductFontSize(BuildContext context, bool isTitle) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return isTitle ? 10 : 12; // iPhone SE
    if (width < 600) return isTitle ? 12 : 14; // Mobile
    return isTitle ? 14 : 16; // Tablet/Desktop
  }

  double _getCategorySize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 36; // iPhone SE
    if (width < 600) return 40; // Mobile
    return 44; // Tablet/Desktop
  }

  double _getCategoryFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 380) return 10; // iPhone SE
    if (width < 600) return 11; // Mobile
    return 12; // Tablet/Desktop
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(_getPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER SECTION
                _buildHeaderSection(context),
                
                SizedBox(height: _getSpacing(context)),
                
                // SEARCH BAR
                _buildSearchBar(context),
                
                SizedBox(height: _getSpacing(context) + 4),
                
                // POPULARITY SECTION
                _buildPopularitySection(context),
                
                SizedBox(height: _getSpacing(context) + 4),
                
                // CATEGORIES SECTION
                _buildCategoriesSection(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  double _getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 380 ? 12 : 16; // iPhone SE vs lainnya
  }

  double _getSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 380 ? 16 : 20; // iPhone SE vs lainnya
  }

  Widget _buildHeaderSection(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6EC7), Color(0xFFFFD700)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(isSmall ? 12 : 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome! 👋',
                style: TextStyle(
                  fontSize: isSmall ? 14 : 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isSmall ? 2 : 4),
              Text(
                'Find Perfect\nFlowers',
                style: TextStyle(
                  fontSize: isSmall ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ],
          ),
          Container(
            width: isSmall ? 40 : 44,
            height: isSmall ? 40 : 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: isSmall ? 20 : 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Container(
      height: isSmall ? 40 : 44,
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFFFF6EC7), size: isSmall ? 18 : 20),
          SizedBox(width: isSmall ? 6 : 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search flowers...',
                hintStyle: TextStyle(
                  color: Colors.grey[500], 
                  fontSize: isSmall ? 13 : 14
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularitySection(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popularity',
              style: TextStyle(
                fontSize: isSmall ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 10 : 12, 
                vertical: isSmall ? 3 : 4
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFF6EC7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: isSmall ? 11 : 12,
                  color: Color(0xFFFF6EC7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: isSmall ? 12 : 16),

        SizedBox(
          height: _getProductImageHeight(context) + 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: popularProducts.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: isSmall ? 10 : 12),
            itemBuilder: (context, index) {
              final product = popularProducts[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    final useShortName = MediaQuery.of(context).size.width < 400;
    
    // Tentukan warna berdasarkan kategori
    Color getProductColor(String category) {
      switch (category) {
        case 'Wedding':
          return Color(0xFFFF6EC7);
        case 'Decor':
          return Color(0xFFFFD700);
        case 'Bouquet':
          return Color(0xFFFFD1DC);
        default:
          return Color(0xFFFF6EC7);
      }
    }

    // Nama pendek untuk layar kecil
    String getShortName(String name) {
      if (name.length > 10) {
        return name.split(' ').first;
      }
      return name;
    }
    
    return GestureDetector(
      onTap: () {
        // NAVIGATION KE PRODUCT DETAIL
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        width: _getProductCardWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCT IMAGE
            Container(
              height: _getProductImageHeight(context),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isSmall ? 10 : 12),
                  topRight: Radius.circular(isSmall ? 10 : 12),
                ),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // PRODUCT INFO
            Padding(
              padding: EdgeInsets.all(isSmall ? 6 : 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    height: isSmall ? 14 : 16,
                    child: Text(
                      useShortName ? getShortName(product.name) : product.name,
                      style: TextStyle(
                        fontSize: _getProductFontSize(context, true),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: isSmall ? 2 : 4),
                  // PRICE - SUDAH DIUBAH KE RUPIAH
                  Text(
                    _formatRupiah(product.price),
                    style: TextStyle(
                      fontSize: _getProductFontSize(context, false),
                      fontWeight: FontWeight.bold,
                      color: getProductColor(product.category),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: isSmall ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: isSmall ? 12 : 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: isSmall ? 8 : 12,
            mainAxisSpacing: isSmall ? 8 : 12,
            childAspectRatio: isSmall ? 0.75 : 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryItem(context, category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, Map<String, dynamic> category) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              categoryName: category['name'] as String,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: category['gradient'] as List<Color>,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
          boxShadow: [
            BoxShadow(
              color: (category['gradient'] as List<Color>)[0].withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _getCategorySize(context),
              height: _getCategorySize(context),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(_getCategorySize(context) / 2),
              ),
              child: Icon(
                category['icon'] as IconData,
                color: Colors.white,
                size: _getCategorySize(context) / 2,
              ),
            ),
            SizedBox(height: isSmall ? 4 : 6),
            Text(
              category['name'] as String,
              style: TextStyle(
                fontSize: _getCategoryFontSize(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNav(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFFF6EC7),
      unselectedItemColor: Colors.grey[500],
      currentIndex: 0,
      elevation: 4,
      iconSize: isSmall ? 18 : 20,
      selectedFontSize: isSmall ? 9 : 10,
      unselectedFontSize: isSmall ? 9 : 10,
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
}