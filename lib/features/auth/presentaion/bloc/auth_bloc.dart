// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';

import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial()) {
    // Sign In
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase.execute(event.email, event.password);
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(AuthAuthenticated(user)),
      );
    });

    // Sign Up
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpUseCase.execute(event.email, event.password);
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(AuthAuthenticated(user)),
      );
    });

    // Sign Out
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await logoutUseCase.execute();
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (_) => emit(AuthUnauthenticated()),
      );
    });

    // Check Current User
    on<CheckCurrentUserEvent>((event, emit) {
      final result = getCurrentUserUseCase.execute();
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) {
          if (user == null) {
            emit(AuthUnauthenticated());
          } else {
            emit(AuthAuthenticated(user));
          }
        },
      );
    });
  }
}
