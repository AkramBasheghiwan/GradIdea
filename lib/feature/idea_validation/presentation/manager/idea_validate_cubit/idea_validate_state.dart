import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';

class IdeaValidateState extends Equatable {
  const IdeaValidateState();

  @override
  List<Object> get props => [];
}

class IdeaValidationInitial extends IdeaValidateState {}

class IdeaValidationLoading extends IdeaValidateState {}

class IdeaValidationSuccess extends IdeaValidateState {
  final ValidationResponse result;
  final bool isAiLoading;
  final String? aiSuggestions;

  const IdeaValidationSuccess({
    required this.result,
    this.isAiLoading = false,
    this.aiSuggestions,
  });

  IdeaValidationSuccess copyWith({
    ValidationResponse? result,
    bool? isAiLoading,
    String? aiSuggestions,
  }) {
    return IdeaValidationSuccess(
      result: result ?? this.result,
      isAiLoading: isAiLoading ?? this.isAiLoading,
      aiSuggestions: aiSuggestions ?? this.aiSuggestions,
    );
  }
}

class IdeaValidationError extends IdeaValidateState {
  final String message;
  const IdeaValidationError(this.message);
}
