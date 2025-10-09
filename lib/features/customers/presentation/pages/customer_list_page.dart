import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/data/customer_remote_datasource.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';

import '../../domain/usecases/add_customer.dart';
import '../../domain/usecases/update_customer.dart';
import '../../domain/usecases/delete_customer.dart';
import '../../domain/usecases/get_all_customer.dart';
import 'customer_form_page.dart';


class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {  
    final _auth = FirebaseAuth.instance;

  // late final _remote = FirebaseRemoteDataSource<CustomerModel>(
  //   collectionName: 'customers',
  //   fromFirestore: (doc) => CustomerModel.fromFirestore(doc),
  //   toFirestore: (model) => model.toJson(),
  // );
  late final _remote = CustomerRemoteDataSourceImpl();
  late final _repo = CustomerRepositoryImpl(_remote);

  late final _getAllCustomers = GetAllCustomers(_repo);
  late final _addCustomer = AddCustomer(_repo);
  late final _updateCustomer = UpdateCustomer(_repo);
  late final _deleteCustomer = DeleteCustomer(_repo);

  List<Customer> _customers = [];

  
  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  Future<void> _initAuth() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }
    await _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    final customers = await _getAllCustomers();
    setState(() => _customers = customers);
  }

  Future<void> _delete(String id) async {
    await _deleteCustomer(id);
    await _loadCustomers();
  }
Future<void> _openForm([Customer? customer]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerFormPage(
          customer: customer,
          addUseCase: _addCustomer,
          updateUseCase: _updateCustomer,
        ),
      ),
    );
    if (result == true) _loadCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCustomers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: _customers.isEmpty
          ? const Center(child: Text('No customers found.'))
          : ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final c = _customers[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(c.name[0].toUpperCase())),
                  title: Text(c.name),
                  subtitle: Text('${c.email}\n${c.phone ?? "No phone"}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openForm(c),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _delete(c.id.toString()),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}