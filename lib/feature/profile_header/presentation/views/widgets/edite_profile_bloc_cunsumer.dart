import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/manager/profile_cubit/profile_state.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/manager/profile_cubit/profle_cubit.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edite_profilw_view_body.dart';

class EditeProfileBlocCunsumer extends StatelessWidget {
  EditeProfileBlocCunsumer({super.key});

  final personalForm = GlobalKey<FormState>();
  final academicForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.updated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تحديث الملف الشخصي بنجاح')),
          );
        }

        if (state.loggedOut) {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<EditProfileCubit>();

        return EditProfileViewBody(
          currentStep: state.currentStep,
          controllers: cubit.controllers,
          personalForm: personalForm,
          academicForm: academicForm,

          onBack: cubit.previousStep,
          onPickImage: cubit.pickImage,

          onNext: () {
            if (state.currentStep == 0) {
              if (personalForm.currentState!.validate()) {
                cubit.nextStep();
              }
            } else if (state.currentStep == 1) {
              if (academicForm.currentState!.validate()) {
                cubit.nextStep();
              }
            }
          },

          onSubmit: cubit.updateProfile,
        );
      },
    );
  }
}
