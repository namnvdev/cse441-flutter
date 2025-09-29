import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/presentation/widget/app_drawer.dart';
import 'package:my_app/core/presentation/widget/customer_bottom_nav.dart';
import 'package:my_app/core/routing/app_routes.dart';
import 'package:my_app/features/customers/presentation/pages/customer_list_page.dart';
import 'package:my_app/features/home/presentation/pages/home_page.dart';
import 'package:my_app/features/products/domain/usecases/create_product.dart';
import 'package:my_app/features/products/domain/usecases/delete_product.dart';
import 'package:my_app/features/products/domain/usecases/update_product.dart';
import 'package:my_app/features/products/presentation/pages/product_list_page.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:my_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:my_app/features/products/domain/usecases/get_products.dart';
import 'package:my_app/features/profile/presentation/pages/profile_page.dart';

class AppGoRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes:[
       ShellRoute(
        builder: (context, state, child) { 
            int currentIndex = _getIndexForLocation(state.matchedLocation);
            return Scaffold(
              body: child,
            //  drawer: const AppDrawer(),
              bottomNavigationBar: CustomerBottomNav(initialIndex: currentIndex,),
            );            
        },
        routes:[
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
            GoRoute(
              path: AppRoutes.customers,
              builder: (context, state) => const CustomerListPage(),
            ),
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),  

          ],
      ),
    ],
  );
  static _getIndexForLocation(String path) {
    if (path.startsWith(AppRoutes.home)) return 0;
    else if (path.startsWith(AppRoutes.products)) return 1;
    else if (path.startsWith(AppRoutes.customers)) return 2;
    else  if (path.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

}
