import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/presentation/widget/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Menu')),
      drawer: const AppDrawer(),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://fastly.picsum.photos/id/162/200/200.jpg?hmac=zGko1eZn0l_BsdOerR5_Ae53SRjRigypWkxLtzfKE6A'),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('john.doe@example.com'),
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