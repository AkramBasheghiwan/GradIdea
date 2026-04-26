//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_email.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/forget_password_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/login_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/mapper_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/signup_hr_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/signup_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/verify_email_otp.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/verify_email_view.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/main_layout_view.dart';
//import 'package:graduation_management_idea_system/feature/user/presentation/view/user_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnboardingView(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        );
      case AppRoutes.signUpUser:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignUpUserView(),
        );
      case AppRoutes.signUpExternalEntity:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignupHrView(),
        );
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetEmail(),
          //ForgotPasswordView(),
        );
      case AppRoutes.verifyEmail:
        return MaterialPageRoute(
          builder: (BuildContext context) => VerifyEmailOtp(
            email: settings.arguments as String,
          ), // تأكد من تمرير الإيميل كوسيط
          //VerifyEmailView(),
        );

      case AppRoutes.userView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutScreen(),
        );
      case AppRoutes.mapperView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MapperView(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
