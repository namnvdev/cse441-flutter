import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/routing/app_routes.dart';
import 'package:my_app/core/presentation/widget/app_drawer.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers & Menu')),
       drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bạn đã bấm:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.products),
              // onPressed: (Navigator.pushNamed(context, '/products'),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Xem sản phẩm'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}