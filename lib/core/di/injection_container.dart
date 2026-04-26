// أضف هذا الـ import إذا كان كلاس NetworkInfo موجوداً في ملف منفصل
// import 'مسار_ملف_network_info_الخاص_بك';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/auth_injection.dart'
    as auth;
import 'package:graduation_management_idea_system/feature/projects/projects_injections.dart'
    as pro;

import 'package:graduation_management_idea_system/feature/user/presentation/view/user_injection.dart '
    as user;

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../network/network_info.dart';

final sl = GetIt.instance;

Future<void> initBaseScope() async {
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Supabase.instance.client);
  // 2. تسجيل كائنات الشبكة
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // 3. استدعاء حقن الميزات الأخرى
  auth.initAuthInjection(sl);
  user.initUserInjection(sl);
  pro.initProjectsinjectionScope(sl);
}

// ==========================================
// 2. نطاق الطالب (Student Scope)
// ==========================================
void initStudentScope() {
  sl.pushNewScope(scopeName: 'studentScope');
}

// ==========================================
// 3. نطاق المسؤول (Admin Scope)
// ==========================================
void initAdminScope() {
  sl.pushNewScope(scopeName: 'adminScope');
}

// ==========================================
// 4. نطاق رئيس القسم
// ملاحظة: قمت بتصحيح اسم الدالة لك (scope بدلاً من scop)
// ==========================================
void initHeadOfDepartScope() async {
  if (!sl.hasScope('headOfDepartScope')) {
    sl.pushNewScope(
      scopeName: 'headOfDepartScope',
      init: (scope) {
        // hod.initHodInjection(scope);
      },
    );
  }
}

// ==========================================
// 🧹 دالة مهمة جداً: تنظيف النطاقات عند تسجيل الخروج
// ==========================================
Future<void> dropAllRoleScopes() async {
  if (sl.hasScope('studentScope')) await sl.dropScope('studentScope');
  if (sl.hasScope('supervisorScope')) await sl.dropScope('supervisorScope');
  if (sl.hasScope('adminScope')) await sl.dropScope('adminScope');
  if (sl.hasScope('headOfDepartScope')) await sl.dropScope('headOfDepartScope');
}
