import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/router/app_router.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
//import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/dashboard_student.dart';
//import 'package:graduation_management_idea_system/feature/admin_dashboard/presentation/views/dashboard_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
//import 'package:graduation_management_idea_system/feature/projects/presentation/views/projects_upload_view.dart';
//import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/edite_profile_view.dart';
//import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/profile_view.dart';
//import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_detail_view_body.dart';
//import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/projects_upload_view_body.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
//import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
//import 'package:graduation_management_idea_system/feature/projects/presentation/views/search_projects_view.dart';
//import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
//import 'package:graduation_management_idea_system/feature/user/presentation/view/search_user_view.dart';
//import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
import 'package:graduation_management_idea_system/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://wsbfgktdnhhakeirnmmw.supabase.co',
    anonKey: 'sb_publishable_XdBL9CgokH2bOCiPeQqgew_BGy5D-e3',
  );
  await initBaseScope();
  await CacheHelper.init();
  runApp(const GMIS());
}

class GMIS extends StatelessWidget {
  const GMIS({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => sl<AuthCubit>(),

          child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar', '')],
            onGenerateRoute: AppRouter.onGenerateRoute,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),

            debugShowCheckedModeBanner: false,
            home: const SplashView(),
            // const ProjectDetailsViewBody(),
            //  EditProfileView(
            //   currentStep: 0,
            //   onBack: null,
            //   onNext: null,
            //   onSubmit: null,
            //   onPickImage: null,
            // ),
            //const ProfileView(),
            //const HomeView()
            //const SearchUserView(),
            //const SearchProjectsView(),

            // const DashboardView(),
            //VerifyEmailOtp(email: "basheghiwana@gmail.com"),

            //OnboardingView(),
            //  LoginView(),

            // HomePage(),
            // DashboardScreen(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BackdropFilter مع BottomSheet')),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 1. الخلفية التي سيتم تغبيشها
          Image.network(
            'https://cdn.pixabay.com/photo/2024/08/26/05/20/ai-generated-8998175_640.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: ClipRRect(
              // 2. لتحديد منطقة التأثير
              borderRadius: BorderRadius.circular(12.0),
              child: BackdropFilter(
                // 3. تطبيق الفلتر
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // 4. المحتوى الذي يظهر فوق الفلتر
                  width: 250.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.2),
                  ),
                  child: Center(
                    child: Text(
                      'Hello World',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: Colors.white.withValues(alpha: 200)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // children: [
      //   // محتوى ليكون في الخلفية
      //   Image.network(
      //     'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      //     fit: BoxFit.cover,
      //     height: double.infinity,
      //     width: double.infinity,
      //   ),
      //   Center(
      //     child: ElevatedButton(
      //       child: const Text('أظهر الـ BottomSheet'),
      //       onPressed: () {
      //         // استدعاء الدالة التي ستعرض الـ BottomSheet
      //         _showBlurredBottomSheet(context);
      //       },
      //     ),
      //   ),
      // ],
    );
  }

  void _showBlurredBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'قائمة الخيارات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'اختيار من المعرض',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'التقاط صورة',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'اختيار من المعرض',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'التقاط صورة',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'اختيار من المعرض',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'التقاط صورة',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.7),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showBlurredBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // 1. الخطوة الأهم: جعل الخلفية الافتراضية شفافة
    backgroundColor: Colors.transparent,
    builder: (context) {
      // نستخدم ClipRRect لحصر التأثير داخل حواف دائرية
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          // 2. تطبيق تأثير التغبيش (Blur)
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            // 3. هذا الـ Container هو "الزجاج المصنفر"
            // نعطيه لون شبه شفاف ليعطي انطباع الزجاج
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'قائمة الخيارات',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('اختيار من المعرض'),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('التقاط صورة'),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withValues(alpha: 0.7),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('إلغاء'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
