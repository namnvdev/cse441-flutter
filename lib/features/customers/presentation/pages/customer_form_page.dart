import 'package:flutter/material.dart';

import '../../domain/entities/customer.dart';
import '../../domain/usecases/add_customer.dart';
import '../../domain/usecases/update_customer.dart';



class CustomerFormPage extends StatefulWidget {
  final Customer? customer;
  final AddCustomer addUseCase;
  final UpdateCustomer updateUseCase;

  const CustomerFormPage({
    super.key,
    this.customer,
    required this.addUseCase,
    required this.updateUseCase,
  });

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  String? _phone;
  late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.customer?.name ?? '';
    _email = widget.customer?.email ?? '';
    _phone = widget.customer?.phone ?? '';
    _address = widget.customer?.address ?? '';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final now = DateTime.now();
    final newCustomer = Customer(
      id: widget.customer?.id ?? '',
      name: _name,
      email: _email,
      phone: _phone,
      address: _address,
      createdAt: widget.customer?.createdAt ?? now,
      updatedAt: now,
    );

    if (widget.customer == null) {
      await widget.addUseCase(newCustomer);
    } else {
      await widget.updateUseCase(newCustomer);
    }

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.customer != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Customer' : 'Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
                onSaved: (v) => _name = v!.trim(),
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v!.isEmpty || !v.contains('@') ? 'Enter valid email' : null,
                onSaved: (v) => _email = v!.trim(),
              ),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (v) => _phone = v?.trim(),
              ),
              TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) => v!.isEmpty ? 'Enter address' : null,
                onSaved: (v) => _address = v!.trim(),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: Icon(isEdit ? Icons.save : Icons.add),
                label: Text(isEdit ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
