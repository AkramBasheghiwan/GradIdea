import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/manager/profile_cubit/profle_cubit.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edite_profile_bloc_cunsumer.dart';
//import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edite_profilw_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: EditeProfileBlocCunsumer(),
    );
  }
}
