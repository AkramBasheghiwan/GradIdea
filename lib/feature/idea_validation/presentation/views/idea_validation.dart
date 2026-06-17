import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_suggestion_cubit/cubit/ai_suggestion_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/idea_validate_cubit/idea_validate_cubit.cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/idea_validation_viewa_body.dart';

class IdeaValidationView extends StatelessWidget {
  const IdeaValidationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<IdeaValidateCubit>()),
        BlocProvider(create: (context) => sl<AiSuggestionCubit>()),
      ],

      child: const IdaeValidationViewsBody(),
    );
  }
}
