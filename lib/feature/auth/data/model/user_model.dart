import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

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
      companyName: map['external_name'],
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
      companyName: data['external_name'],
    );
  }
  factory UserModel.toFromEntittToModel(UserEntity user, bool isVerified) {
    return UserModel(
      isEmailVerified: isVerified,
      uid: user.uid,
      name: user.name,
      email: user.email,
      role: user.role,
      phone: user.phone,
      specialization: user.specialization,
      companyName: user.companyName,
    );
  }
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      isEmailVerified: user.isEmailVerified,
      uid: user.uid,
      name: user.name,
      email: user.email,
      role: user.role,
      phone: user.phone,
      specialization: user.specialization,
      companyName: user.companyName,
    );
  }
  UserModel copyWith({
    String? name,
    String? specialization,
    String? phone,
    String? companyName,
  }) {
    return UserModel(
      isEmailVerified: isEmailVerified,
      uid: uid,
      name: name ?? this.name,
      email: email,
      role: role,
      specialization: specialization ?? this.specialization,
      phone: phone ?? this.phone,
      companyName: companyName ?? this.companyName,
    );
  }

  Map<String, dynamic> toDocument(bool isVerified) {
    return {
      'is_email_verified': isVerified,
      'name': name,
      'email': email,
      'role': role,
      'specialization': specialization,
      'phone': phone,
      'external_name': companyName,
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
