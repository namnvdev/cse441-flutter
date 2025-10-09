class Customer {
  final String id;  //primary key
  final String name;
  final String email;
  final String? phone;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  // /// Create from JSON (e.g., API response or local DB map)
  // factory Customer.fromJson(Map<String, dynamic> json) {
  //   return Customer(
  //     id: json['id'] ?? '',
  //     name: json['name'] ?? '',
  //     email: json['email'] ?? '',
  //     phone: json['phone'],
  //     address: json['address'] ?? '',
  //     createdAt: DateTime.parse(json['created_at']),
  //     updatedAt: DateTime.parse(json['updated_at']),
  //   );
  // }

  

  // /// Convert to JSON (for API request or local DB save)
  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //       'address': address,
  //       'created_at': createdAt.toIso8601String(),
  //       'updated_at': updatedAt.toIso8601String(),
  //     };

  // /// Clone with modifications
  // Customer copyWith({
  //   String? id,
  //   String? name,
  //   String? email,
  //   String? phone,
  //   String? address,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return Customer(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     phone: phone ?? this.phone,
  //     address: address ?? this.address,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, email: $email, phone: $phone, address: $address)';
  }
}
