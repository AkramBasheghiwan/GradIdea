import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';

import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UpdatePeofileRepository {
  Future<Either<Failure, Unit>> updateProfile(UserEntity user);
}

class UpdateProfileRepositoryImpl implements UpdatePeofileRepository {
  final SupabaseClient supabase;

  UpdateProfileRepositoryImpl(this.supabase);

  @override
  Future<Either<Failure, Unit>> updateProfile(UserEntity user) async {
    try {
      log('==============================');
      log('🚀 Start Update Profile');
      log('👤 User ID: ${user.uid}');

      final confertUser = UserModel.toFromEntittToModel(user, true);

      final users = supabase.auth.currentUser;

      final isVerified = users?.emailConfirmedAt != null;

      final data = confertUser.toDocument(isVerified);

      log('📤 Data To Update:');
      log(data.toString());

      final result = await supabase
          .from(AppConstatnce.userCollection)
          .update(data)
          .eq('id', user.uid)
          .select();

      log('✅ Update Success');
      log('📥 Updated Row: $result');

      return const Right(unit);
    } on SocketException catch (e, stackTrace) {
      log('❌ SocketException');
      log(e.toString());
      log(stackTrace.toString());

      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on PostgrestException catch (e, stackTrace) {
      log('❌ PostgrestException');
      log('Message: ${e.message}');
      log('Code: ${e.code}');
      log('Details: ${e.details}');
      log('Hint: ${e.hint}');
      log(stackTrace.toString());

      throw ServerException(_handlePostgrestException(e));
    } catch (e, stackTrace) {
      log('❌ Unknown Error');
      log(e.toString());
      log(stackTrace.toString());

      throw ServerException('حدث خطأ أثناء تحديث الدور: $e');
    }
  }

  String _handlePostgrestException(PostgrestException exception) {
    switch (exception.code) {
      case '42501':
        return 'ليس لديك الصلاحية (RLS) للوصول إلى هذه البيانات أو تعديلها.';
      case 'PGRST116':
        return 'لم يتم العثور على البيانات المطلوبة.';
      case '23505':
        return 'هذه البيانات موجودة مسبقاً.';
      default:
        return 'حدث خطأ في الخادم: ${exception.message}';
    }
  }
}
