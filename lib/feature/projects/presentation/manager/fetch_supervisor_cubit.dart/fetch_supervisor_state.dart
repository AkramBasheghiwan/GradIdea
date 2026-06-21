part of 'fetch_supervisor_cubit.dart';

sealed class FetchSupervisorState extends Equatable {
  const FetchSupervisorState();

  @override
  List<Object> get props => [];
}

final class FetchSupervisorInitial extends FetchSupervisorState {}

final class FetchSupersiorLoading extends FetchSupervisorState {}

final class FetchSupersiorLoaded extends FetchSupervisorState {
  final List<SupervisorEntity> supervsiorAvailable;

  const FetchSupersiorLoaded({required this.supervsiorAvailable});

  @override
  List<Object> get props => [supervsiorAvailable];
}

final class FetchSuperiorError extends FetchSupervisorState {
  final String message;

  const FetchSuperiorError({required this.message});

  @override
  List<Object> get props => [message];
}
