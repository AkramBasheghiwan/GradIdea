import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/get_project_detail/get_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/get_project_detail/get_project_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/project_detail_view.dart';

class GetProjectDetaileViewBody extends StatelessWidget {
  const GetProjectDetaileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProjectCubit, GetProjectState>(
      builder: (context, state) {
        if (state is GetProjectLoading) {
          return const Scaffold(
            backgroundColor: AppColor.background,

            body: Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            ),
          );
        }
        if (state is GetProjectLoaded) {
          return ProjectDetailView(projects: state.project);
        }
        if (state is GetProjectError) {
          AppSnackBar.show(context: context, message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
