import 'package:equatable/equatable.dart';

import '../../../../domain/entities/validation_result_entity.dart';

class IdeaValidationState extends Equatable {
  const IdeaValidationState();

  @override
  List<Object> get props => [];
}

class IdeaValidationInitial extends IdeaValidationState {}

class IdeaValidationLoading extends IdeaValidationState {}

class IdeaValidationSuccess extends IdeaValidationState {
  final ValidationResultEntity result;
  final bool isAiLoading;
  final String? aiSuggestions;

  const IdeaValidationSuccess({
    required this.result,
    this.isAiLoading = false,
    this.aiSuggestions,
  });

  IdeaValidationSuccess copyWith({
    ValidationResultEntity? result,
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

class IdeaValidationError extends IdeaValidationState {
  final String message;
  const IdeaValidationError(this.message);
}
