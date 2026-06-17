//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/widgets/notifications_view.dart';
import 'package:graduation_management_idea_system/core/widgets/pdf_viewer_page.dart';
import 'package:graduation_management_idea_system/core/widgets/private_policy_view.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/main_layout_hod_screan.dart';
import 'package:graduation_management_idea_system/feature/Student/presentation/views/student_main_layout.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/main_layout_admin.dart';
import 'package:graduation_management_idea_system/feature/app_setting/presentation/views/app_setting_view.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/idea_validation.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/edite_profile_view.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/search_projects_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/uploud_proposal_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/proposal_detail.view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/student_my_proposals_view.dart';
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
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/student_get_my_projects_view.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/project_archieve_view.dart';

import 'package:graduation_management_idea_system/feature/projects/presentation/views/project_detail_view.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/projects_upload_view.dart';
// import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/hod_projects_proposal_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/supervisor_review_proposal_view.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/view/explore_proposal_appeoved.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/view/splash_view.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/views/main_layout_supervisor.dart';

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
        final ProjectProposals? proposals =
            settings.arguments as ProjectProposals?;
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              UploudProposalView(proposals: proposals),
        );
      case AppRoutes.exploureProjects:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProjectsArchiveView(),
        );
      case AppRoutes.exploureProposal:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ExploreProposaleApproved(),
        );
      case AppRoutes.myProject:
        return MaterialPageRoute(
          builder: (BuildContext context) => const StudentProjectView(),
        );
      case AppRoutes.myproposal:
        return MaterialPageRoute(
          builder: (BuildContext context) => const StudentMyProposalView(),
        );
      case AppRoutes.proposalDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) => ProposalDetailView(
            proposals: settings.arguments as ProjectProposals,
          ),
        );
      case AppRoutes.reviewProposal:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              const SupervisorReviewProposalView(),
        );
      case AppRoutes.supervisorHome:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutSupervisor(),
        );
      case AppRoutes.searchProjects:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchProjectsView(),
        );
      case AppRoutes.pdfviewer:
        final String pdfUrl = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => PdfViewerPage(pdfUrl: pdfUrl),
        );
      case AppRoutes.editeProfile:
        final UserEntity user = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (BuildContext context) => EditProfileView(user: user),
        );
      case AppRoutes.dashboardHead:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutHODScreen(),
        );
      case AppRoutes.appSetting:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AppSettingView(),
        );
      case AppRoutes.dashboardAdmin:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainLayoutScreen(),
        );
      case AppRoutes.privacypolicy:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PrivacyPolicyView(),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (context) => const NotificationsView(),
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
