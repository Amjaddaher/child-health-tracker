// lib/features/auth/presentation/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Login
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// SignUp
class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Logout
class SignOutEvent extends AuthEvent {}

// Check Current User
class CheckCurrentUserEvent extends AuthEvent {}
