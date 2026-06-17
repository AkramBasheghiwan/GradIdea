import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/app_secrets.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/router/app_router.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/view/splash_view.dart';
import 'package:graduation_management_idea_system/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
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
            title: 'GradIdea',
            theme: ThemeData(
              fontFamily: 'Cairo',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),

            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          ),
        );
      },
    );
  }
}
