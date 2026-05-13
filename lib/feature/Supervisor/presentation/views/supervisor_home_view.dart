import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/views/widgets/build_header.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/views/widgets/build_hero_card.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/views/widgets/build_quick_action.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/views/widgets/build_state_gride.dart';

import '../../../../core/utils/app_colors.dart';

class SupervisorHomeView extends StatelessWidget {
  const SupervisorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              const BuildHeader(),

              SizedBox(height: 22.h),

              const BuildHeroCard(),

              SizedBox(height: 24.h),

              const BuildStateGride(),

              SizedBox(height: 24.h),

              const BuildQuickAction(),
            ],
          ),
        ),
      ),
    );
  }
}
