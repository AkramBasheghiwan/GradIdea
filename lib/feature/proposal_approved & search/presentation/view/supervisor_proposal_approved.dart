import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_icon_search_bar.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/domain/repository/proposal_approved_repository.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_approved/proposal_approve_cubit.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/view/widgets/supervisor_proposal_approved_body.dart';

class SupervisorProposalApproved extends StatelessWidget {
  const SupervisorProposalApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          title: Text(
            'استكشف المقترحات  الموافق عليها',
            style: AppTextStyle.headline24BoldStyle,
          ),
          centerTitle: false,
          actions: [BuildIconSearchBar(onpressed: () {})],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.h),
              const CustomBulidTabBar(
                tap: <Tab>[
                  Tab(
                    child: Text(
                      'تقنية معلومات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'علوم حاسوب',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'امن معلومات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProposalApprovedCubit(
                          sl<ProposalApprovedRepository>(),
                          'IT',
                        );
                        return cubit;
                      },

                      child: const ProposalApprovedBody(),
                    ),
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProposalApprovedCubit(
                          sl<ProposalApprovedRepository>(),
                          'IS',
                        );

                        return cubit;
                      },

                      child: const ProposalApprovedBody(),
                    ),
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProposalApprovedCubit(
                          sl<ProposalApprovedRepository>(),
                          'CS',
                        );

                        return cubit;
                      },

                      child: const ProposalApprovedBody(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
