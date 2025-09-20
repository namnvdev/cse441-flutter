import 'package:my_app/features/products/domain/entities/product.dart';

import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;
  ProductRemoteDataSource({required this.apiClient});

  Future<List<ProductModel>> fetchProducts() async {
    final data = await apiClient.get('/products') as List<dynamic>;
    return data.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
  }

 Future<ProductModel> createProduct(ProductModel product) async {
    final data = await apiClient.post('/products', product.toJson());
    return ProductModel.fromJson(data);
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final data = await apiClient.put('/products/${product.id}', product.toJson());
    return ProductModel.fromJson(data);
  }

  Future<void> deleteProduct(String id) async {
    await apiClient.delete('/products/$id');
  }

}
