import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/manager/profile_cubit/profle_cubit.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/edite_profile_bloc_cunsumer.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<EditProfileCubit>()..setUser(UserModel.fromEntity(user)),
      child: EditProfileBlocConsumer(),
    );
  }
}
