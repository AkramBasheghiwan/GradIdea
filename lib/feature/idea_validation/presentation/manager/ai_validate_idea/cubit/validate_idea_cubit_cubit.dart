import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/idea_validation_repo.dart';

class IdeaValidationCubit extends Cubit<IdeaValidationState> {
  final IdeaValidationRepositoryImp repository;

  IdeaValidationCubit({required this.repository})
    : super(IdeaValidationInitial());

  Future<void> validateIdea(String idea) async {
    if (idea.trim().isEmpty) return;

    emit(IdeaValidationLoading());

    final result = await repository.validateStudentIdea(idea);

    result.fold(
      (failure) => emit(IdeaValidationError(failure.message)),
      (validationResult) =>
          emit(IdeaValidationSuccess(result: validationResult)),
    );
  }

  Future<void> fetchAiSuggestions({
    required String idea,
    required List<SimilarProjectEntity> similarProjectlist,
  }) async {
    final currentState = state;
    if (currentState is IdeaValidationSuccess) {
      emit(currentState.copyWith(isAiLoading: true));

      final result = await repository.getAiSuggestions(
        studentIdea: idea,
        oldProjects: similarProjectlist,
      );

      result.fold(
        (failure) => emit(
          currentState.copyWith(isAiLoading: false),
        ), // يمكنك إضافة معالجة للخطأ هنا
        (suggestions) => emit(
          currentState.copyWith(isAiLoading: false, aiSuggestions: suggestions),
        ),
      );
    }
  }
}
