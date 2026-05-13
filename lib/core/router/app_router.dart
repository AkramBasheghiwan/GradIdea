//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/feature/Student_home/presentation/views/student_main_layout.dart';
import 'package:graduation_management_idea_system/feature/admin_dashboard/presentation/views/main_layout_admin.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/idea_validation_views.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/search_projects_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/uploud_proposal_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/student_project_proposals_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_email.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/forget_password_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/login_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/mapper_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/signup_hr_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/signup_view.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/verify_email_otp_view.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/views/verify_email_view.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/student_projects_view.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/project_archieve_view.dart';

import 'package:graduation_management_idea_system/feature/projects/presentation/views/project_detail_view.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/projects_upload_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/supervisor_projects_proposal_view.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/view/supervisor_proposal_approved.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/view/splash_view.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/views/main_layout_supervisor.dart';

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
          builder: (BuildContext context) => VerifyEmailOtpView(
            email: settings.arguments as String,
          ), // تأكد من تمرير الإيميل كوسيط
          //VerifyEmailView(),
        );
      case AppRoutes.dashboardStudent:
        return MaterialPageRoute(
          builder: (BuildContext context) => const StudentMainLayout(),
        );
      case AppRoutes.userView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutScreen(),
        );
      case AppRoutes.mapperView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MapperView(),
        );
      case AppRoutes.projectDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              ProjectDetailView(projects: settings.arguments as ProjectEntity),
        );
      case AppRoutes.aiValidationIdea:
        return MaterialPageRoute(
          builder: (BuildContext context) => const IdeaValidationView(),
        );
      case AppRoutes.uploudProject:
        final ProjectEntity? project = settings.arguments as ProjectEntity?;
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              ProjectsUploadView(projects: project),
        );
      case AppRoutes.uploudProposal:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UploudProposalView(),
        );
      case AppRoutes.exploureProjects:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProjectsArchiveView(),
        );
      case AppRoutes.exploureProposal:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SupervisorProposalApproved(),
        );
      case AppRoutes.myProject:
        return MaterialPageRoute(
          builder: (BuildContext context) => const StudentProjectView(),
        );
      case AppRoutes.myproposal:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              const StudentProjectProposalsView(),
        );
      case AppRoutes.proposalDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) => Container(),
        );
      case AppRoutes.reviewProposal:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              const SuperVisorProjectsProposalView(),
        );
      case AppRoutes.supervisorHome:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutSupervisor(),
        );
      case AppRoutes.searchProjects:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchProjectsView(),
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
