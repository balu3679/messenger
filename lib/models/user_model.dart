import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String company;
  final String notes;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.company,
    required this.notes,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      company: map['company'] ?? '',
      notes: map['notes'] ?? '',
      createdAt: map['created_at'] != null
          ? (map['created_at'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
