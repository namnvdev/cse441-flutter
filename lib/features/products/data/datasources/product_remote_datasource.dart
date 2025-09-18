import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;
  ProductRemoteDataSource({required this.apiClient});

  Future<List<ProductModel>> fetchProducts() async {
    final data = await apiClient.get('/products') as List<dynamic>;
    return data.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
