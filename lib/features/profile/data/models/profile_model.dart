import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.uid,
    required super.name,
    super.avatarUrl,
    super.email,
    super.address,
    super.phone,
    super.bio,
  });

  factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    return ProfileModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'],
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatarUrl': avatarUrl,
      'email': email,
      'address': address,
      'phone': phone,
      'bio': bio,
    };
  }

  factory ProfileModel.fromEntity(Profile e) => ProfileModel(
        uid: e.uid,
        name: e.name,
        avatarUrl: e.avatarUrl,
        email: e.email,
        address: e.address,
        phone: e.phone,
        bio: e.bio,
      );
}
