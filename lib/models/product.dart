class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  final bool inStock;
  final double rating;
  final Map<String, int> variants;
  final double? originalPrice; // ✅ TAMBAH BARIS INI

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.inStock = true,
    this.rating = 0.0,
    this.variants = const {},
    this.originalPrice, // ✅ TAMBAH PARAMETER INI
  });
}