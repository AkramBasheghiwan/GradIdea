import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';

import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/idea_validation_view_body.dart';

class IdeaValidationView extends StatelessWidget {
  const IdeaValidationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<IdeaValidationCubit>(),
      child: const IdaeValidationViewBody(),
    );
  }
}
