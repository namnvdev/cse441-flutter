import 'package:go_router/go_router.dart';
import 'package:my_app/core/routing/app_routes.dart';
import 'package:my_app/features/home/presentation/pages/home_page.dart';
import 'package:my_app/features/products/domain/usecases/create_product.dart';
import 'package:my_app/features/products/domain/usecases/delete_product.dart';
import 'package:my_app/features/products/domain/usecases/update_product.dart';
import 'package:my_app/features/products/presentation/pages/product_list_page.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:my_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:my_app/features/products/domain/usecases/get_products.dart';

class AppGoRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.products,
        builder: (context, state) {
          final apiClient = ApiClient();
          final remoteDS = ProductRemoteDataSource(apiClient: apiClient);
          final repo = ProductRepositoryImpl(remoteDataSource: remoteDS);
          final getProducts = GetProducts(repo);
          final createProduct = CreateProduct(repo);
          final updateProduct = UpdateProduct(repo);
          final deleteProduct = DeleteProduct(repo);
          return ProductListPage(getProducts: getProducts, createProduct: createProduct, 
                                updateProduct: updateProduct, deleteProduct: deleteProduct);
        },
      ),
    ],
  );
}
