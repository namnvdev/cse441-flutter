import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/presentation/widget/app_drawer.dart';
import 'package:my_app/core/routing/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter & Menu')),
      drawer: const AppDrawer(),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       const DrawerHeader(
      //         child: Text('Menu', style: TextStyle(fontSize: 20)),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.shopping_bag),
      //         title: const Text('Danh sách sản phẩm'),
      //         onTap: () => context.push(AppRoutes.products),
      //         // onTap: () => Navigator.pushNamed(context, '/products'),
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text('Bạn đã bấm:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              // onPressed: () => Navigator.pushNamed(context, '/products'),
              onPressed: () => context.push(AppRoutes.products),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Xem sản phẩm'),
            ),
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text("Sign out"),
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
