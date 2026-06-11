import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/manager/profile_cubit/profile_state.dart';

import 'package:graduation_management_idea_system/feature/profile/presentation/manager/profile_cubit/profle_cubit.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/edite_profilw_view_body.dart';

class EditProfileBlocConsumer extends StatelessWidget {
  EditProfileBlocConsumer({super.key});

  final personalForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          AppSnackBar.show(
            context: context,
            message: state.message ?? 'تم تحديث الملف الشخصي بنجاح',
          );
          Navigator.pop(context);
        }

        if (state is ProfileError) {
          AppSnackBar.show(
            context: context,
            message: state.message ?? 'حدث خطاء اثناء تحديث الملف',
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();

        return EditProfileViewBody(
          isLoading: state is ProfileLoading,
          controllers: cubit.controllers,
          personalForm: personalForm,
          onSubmit: cubit.updateProfile,
        );
      },
    );
  }
}
