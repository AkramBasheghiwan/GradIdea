// lib/features/auth/auth_injection.dart

import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
import 'package:graduation_management_idea_system/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/auth/data/datasource/supabase_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:graduation_management_idea_system/feature/auth/data/repositories/auth_supabase_repository.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_cubit.dart';

import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/forgotPasswordCubit/forgot_password_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/login_sup_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_external_entity.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/sign_upcubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/manager/cubit/splash_cubit.dart';

void initAuthInjection(GetIt sl) {
  // ---------------------------------------------------------
  // 1. Data Sources (مصادر البيانات)
  // ---------------------------------------------------------

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<AuthSupabaseRemoteDataSource>(
    () => SupabaseAuthDataSourceImpl(
      supabase: sl(),
    ), // sl() سيجلب الـ SupabaseClient تلقائياً
  );
  // ---------------------------------------------------------
  // 2. Repositories (المستودعات)
  // ---------------------------------------------------------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<AuthSupabaseRepo>(
    () => AuthSupRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  //sl.registerFactory(() => SingUpCubit(authRepository: sl()));
  // sl.registerFactory(() => LoginCubit(authRepository: sl()));
  sl.registerFactory(() => ForgotPasswordCubits(authRepository: sl()));
  sl.registerFactory(() => VerifyOtpCubit(authRepository: sl()));
  sl.registerFactory(() => LoginSupCubit(authRepository: sl()));
  sl.registerFactory(() => SingUpCubit(authRepository: sl()));
  // sl.registerFactory(() => SignUpUserCubit(authRepository: sl()));
  // sl.registerFactory(() => SignUpExternalEntityCubit(authRepository: sl()));
  //sl.registerFactory(() => ForgotPasswordCubit(authRepository: sl()));
  sl.registerFactory(() => VerifyEmailCubit(authRepository: sl()));
  sl.registerFactory(() => SplashCubit(authRepository: sl()));
}
