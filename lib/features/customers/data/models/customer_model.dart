// customer_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    required super.address,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CustomerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      address: data['address'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'created_at': Timestamp.fromDate(createdAt),
        'updated_at': Timestamp.fromDate(updatedAt),
      };

  factory CustomerModel.fromEntity(Customer e) => CustomerModel(
        id: e.id,
        name: e.name,
        email: e.email,
        phone: e.phone,
        address: e.address,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );  
}
