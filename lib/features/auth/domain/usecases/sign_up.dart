// lib/features/auth/domain/usecases/signup/signup_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String email, String password) {
    return repository.signUp(email, password);
  }
}
