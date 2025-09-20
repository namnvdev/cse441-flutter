import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    // Sau này có thể kết hợp cache/local tại đây
    return remoteDataSource.fetchProducts();
  }
  
  
  @override
  Future<Product> createProduct(Product product) async {
    final model = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
    );
    return remoteDataSource.createProduct(model);
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final model = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
    );
    return remoteDataSource.updateProduct(model);
  }

  @override
  Future<void> deleteProduct(String id) {
    return remoteDataSource.deleteProduct(id);
  }
  
}
