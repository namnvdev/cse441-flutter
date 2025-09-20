import 'dart:async';

import '../../features/products/domain/entities/product.dart';

class ApiClient {
  static List<Product> _products = [];
  
  ApiClient(){
    if (_products.isNotEmpty) return;
    _products = [
        Product(id: 'p1', name: 'Táo Mỹ', price: 2.5, description: 'Táo giòn ngọt'),
        Product(id: 'p2', name: 'Cam Úc', price: 3.0, description: 'Cam mọng nước'),
        Product(id: 'p3', name: 'Xoài Cát', price: 4.2, description: 'Xoài thơm dẻo'),
      ];
  }
  // Giả lập gọi GET và trả JSON sau 400ms
  Future<dynamic> get(String path) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (path == '/products') {
      //call a server api --> get dataset
       return _products
          .map((p) => {
                'id': p.id,
                'name': p.name,
                'price': p.price,
                'description': p.description,
              })
          .toList(); // product --> ProductModel
    }
    throw Exception('Unknown path: $path');
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async { 
 await Future.delayed(const Duration(milliseconds: 400));
    if (path == '/products') {
      final newProduct = Product(
        id: body['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: body['name'],
        price: body['price'],
        description: body['description'],
      );
      _products.add(newProduct);
      return {
        'id': newProduct.id,
        'name': newProduct.name,
        'price': newProduct.price,
        'description': newProduct.description,
      };
    }
    throw Exception('Unknown POST path: $path');

   }

  Future<dynamic> put(String path, Map<String, dynamic> body) async { 
     await Future.delayed(const Duration(milliseconds: 400));
    if (path.startsWith('/products/')) {
      final id = path.split('/').last;
      final index = _products.indexWhere((p) => p.id == id);
      if (index == -1) throw Exception('Product not found');

      final updated = Product(
        id: id,
        name: body['name'],
        price: body['price'],
        description: body['description'],
      );
      _products[index] = updated;
      return {
        'id': updated.id,
        'name': updated.name,
        'price': updated.price,
        'description': updated.description,
      };
    }
    throw Exception('Unknown PUT path: $path');
  }

  Future<void> delete(String path) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (path.startsWith('/products/')) {
      final id = path.split('/').last;
      _products.removeWhere((p) => p.id == id);
      return;
    }
    throw Exception('Unknown DELETE path: $path');
   }
}
