import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idae_validation_api_repo.dart';

part 'ai_suggestion_state.dart';

class AiSuggestionCubit extends Cubit<AiSuggestionState> {
  final IdeaValidationApiRepository repository;
  AiSuggestionCubit({required this.repository}) : super(AiSuggestionInitial());

  Future<void> fetchAiSuggestions({
    required IdeaSubmit idea,
    required List<SimilarPaperMatch> similarProjectlist,
  }) async {
    emit(AiSuggestionLoading());

    final result = await repository.getAiSuggestions(
      studentIdea: idea,
      oldProjects: similarProjectlist,
    );

    result.fold(
      (failure) => emit(
        AiSuggestionError(message: failure.message),
      ), // يمكنك إضافة معالجة للخطأ هنا
      (suggestions) => emit(AiSuggestionLoaded(message: suggestions)),
    );
  }
}
