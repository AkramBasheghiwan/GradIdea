part of 'fetch_supersior_cubit.dart';

sealed class FetchSupersiorState extends Equatable {
  const FetchSupersiorState();

  @override
  List<Object> get props => [];
}

final class FetchSupersiorInitial extends FetchSupersiorState {}

final class FetchSupersiorLoading extends FetchSupersiorState {}

final class FetchSupersiorLoaded extends FetchSupersiorState {
  final List<SupervisorEntity> supervsiorAvailable;

  const FetchSupersiorLoaded({required this.supervsiorAvailable});

  @override
  List<Object> get props => [supervsiorAvailable];
}

final class FetchSuperiorError extends FetchSupersiorState {
  final String message;

  const FetchSuperiorError({required this.message});

  @override
  List<Object> get props => [message];
}
