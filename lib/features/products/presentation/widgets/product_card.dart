import 'package:flutter/material.dart';
import '../../../products/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(product.name),
        subtitle: Text('${product.price.toStringAsFixed(2)} \$ • ${product.description}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Chỗ này sau có thể điều hướng sang Product Detail
        },
      ),
    );
  }
}
