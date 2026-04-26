// features/splash/cubit/splash_state.dart
import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class NavigateToOnboarding extends SplashState {}

class NavigateToAuth extends SplashState {}

class NavigateToEmailVerification extends SplashState {}

class NavigateToHome extends SplashState {
  final String role;
  const NavigateToHome(this.role);
  @override
  List<Object> get props => [role];
}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
  @override
  List<Object> get props => [message];
}
