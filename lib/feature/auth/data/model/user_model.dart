import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.isEmailVerified,
    required super.uid,
    required super.name,
    required super.email,
    required super.role,
    super.specialization,
    super.phone,
    super.companyName,
  });

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
    User user,
  ) {
    final data = document.data()!;
    return UserModel(
      isEmailVerified: user.emailVerified,
      uid: document.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      // قراءة آمنة للحقول الاختيارية
      specialization: data['specialization'],
      phone: data['phone'],
      companyName: data['companyName'],
    );
  }

  factory UserModel.fromSupabaseMap(Map<String, dynamic> map, bool isVerified) {
    return UserModel(
      uid: map['id'],
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      isEmailVerified: isVerified,
      role: map['role'] ?? AppRoles.user,
      specialization: map['specialization'],
      phone: map['phone'],
      companyName: map['company_name'],
    );
  }

  factory UserModel.fromJsion(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      isEmailVerified: data['isEmailVerified'] ?? false,
      uid: document.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      // قراءة آمنة للحقول الاختيارية
      specialization: data['specialization'],
      phone: data['phone'],
      companyName: data['companyName'],
    );
  }
  // factory UserModel.fromSupabaseMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     uid: map['id'], // في Supabase، المعرف غالباً ما يكون 'id'
  //     email: map['email'] ?? '',
  //     name: map['name'] ?? '',
  //     isEmailVerified: map['email_confirmed_at'] != null,
  //     role: map['role'] ?? AppRoles.user,
  //     specialization: map['specialization'],
  //     phone: map['phone'],
  //     companyName: map['company_name'],
  //     // أضف أي حقول أخرى
  //   );
  // }
  Map<String, dynamic> toDocument() {
    return {
      'isEmailVerified': isEmailVerified,
      'name': name,
      'email': email,
      'role': role,
      'specialization': specialization,
      'phone': phone,
      'companyName': companyName,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
