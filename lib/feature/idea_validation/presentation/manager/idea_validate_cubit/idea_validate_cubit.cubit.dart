import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idae_validation_api_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/idea_validate_cubit/idea_validate_state.dart';

class IdeaValidateCubit extends Cubit<IdeaValidateState> {
  final IdeaValidationApiRepository apiService;

  IdeaValidateCubit({required this.apiService})
    : super(IdeaValidationInitial());

  Future<void> validateIdea(IdeaSubmit idea) async {
    emit(IdeaValidationLoading());

    final result = await apiService.validateStudentIdea(idea);

    result.fold(
      (failure) => emit(IdeaValidationError(failure.message)),
      (validationResult) =>
          emit(IdeaValidationSuccess(result: validationResult)),
    );
  }
}
