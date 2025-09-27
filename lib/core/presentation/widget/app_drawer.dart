import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=3',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.go(AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Products'),
            onTap: () => context.push(AppRoutes.products),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customers'),
            onTap: () => context.push(AppRoutes.customers),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
    );
  }
}
