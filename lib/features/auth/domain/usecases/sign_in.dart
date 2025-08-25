// lib/features/auth/domain/usecases/login/login_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String email, String password) {
    return repository.signIn(email, password);
  }
}
