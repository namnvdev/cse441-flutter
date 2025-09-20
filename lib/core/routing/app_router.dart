import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/product_list_page.dart';

// Domain/Data/Network wiring tối thiểu ngay trong router cho dễ hiểu.
// Sau này bạn có thể chuyển sang DI (get_it/Riverpod) rất nhẹ nhàng.
import '../../core/network/api_client.dart';
import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/usecases/get_products.dart';
import '../../features/products/domain/usecases/create_product.dart';
import '../../features/products/domain/usecases/update_product.dart';
import '../../features/products/domain/usecases/delete_product.dart';
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/products':
        // Khởi tạo các lớp theo layer
        final apiClient = ApiClient(); // network (mock)
        final remoteDS = ProductRemoteDataSource(apiClient: apiClient);
        final repo = ProductRepositoryImpl(remoteDataSource: remoteDS);
        final getProducts = GetProducts(repo);
        final createProduct = CreateProduct(repo);
        final updateProduct = UpdateProduct(repo);
        final deleteProduct = DeleteProduct(repo);

        return MaterialPageRoute(
          builder: (_) => ProductListPage(getProducts: getProducts,
          createProduct: createProduct,
          updateProduct: updateProduct,
          deleteProduct: deleteProduct,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
