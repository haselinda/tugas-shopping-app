import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductGridItem({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.image,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 8),
              
              // Nama Produk - FIX OVERFLOW
              SizedBox(
                height: 40, // ✅ FIXED HEIGHT untuk nama
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 2, // ✅ MAX 2 BARIS
                  overflow: TextOverflow.ellipsis, // ✅ ... jika kepanjangan
                ),
              ),
              
              SizedBox(height: 4),
              
              // Harga
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[600],
                ),
              ),
              
              Spacer(),
              
              // Rating & Stock - LAYOUT LEBIH RAPI
              Row(
                children: [
                  // Rating - PAKAI FLEXIBLE
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Spacer(),
                  
                  // STOCK STATUS - DIUBAH JADI ICON CART
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.green,
                    size: isSmall ? 12 : 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}