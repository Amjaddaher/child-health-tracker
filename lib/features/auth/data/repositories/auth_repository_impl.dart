import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signIn(email, password);
      return Right(UserEntity(id: userModel.id, email: userModel.email));
    } catch (e) {
      return Left(AuthFailure("فشل تسجيل الدخول: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signUp(email, password);
      return Right(UserEntity(id: userModel.id, email: userModel.email));
    } catch (e) {
      return Left(AuthFailure("فشل إنشاء الحساب: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure("فشل تسجيل الخروج: ${e.toString()}"));
    }
  }

  @override
  Either<Failure, UserEntity?> getCurrentUser() {
    try {
      final userModel = remoteDataSource.getCurrentUser();
      if (userModel == null) return const Right(null);
      return Right(UserEntity(id: userModel.id, email: userModel.email));
    } catch (e) {
      return Left(AuthFailure("فشل الحصول على المستخدم الحالي: ${e.toString()}"));
    }
  }
}
