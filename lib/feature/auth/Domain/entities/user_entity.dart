import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String role;
  final bool isEmailVerified;

  final String? specialization;

  final String? phone;
  final String? companyName;

  const UserEntity({
    required this.isEmailVerified,
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.specialization,
    this.phone,
    this.companyName,
  });

  @override
  List<Object?> get props => <Object?>[
    isEmailVerified,
    uid,
    email,
    role,
    specialization,
    phone,
    companyName,
  ];
}
