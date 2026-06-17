part of 'ai_suggestion_cubit.dart';

sealed class AiSuggestionState extends Equatable {
  const AiSuggestionState();

  @override
  List<Object> get props => [];
}

final class AiSuggestionInitial extends AiSuggestionState {}

final class AiSuggestionLoading extends AiSuggestionState {}

final class AiSuggestionLoaded extends AiSuggestionState {
  final String message;
  const AiSuggestionLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

final class AiSuggestionError extends AiSuggestionState {
  final String message;
  const AiSuggestionError({required this.message});

  @override
  List<Object> get props => [message];
}
