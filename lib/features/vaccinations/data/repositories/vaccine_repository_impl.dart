

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/vaccination.dart';
import '../../domain/repositories/vaccine_repository.dart';
import '../datasources/vaccine_remote_ds.dart';
import '../models/vaccination_model.dart';


class VaccinationRepositoryImpl implements VaccinationRepository {
  final VaccinationRemoteDataSource remote;
  VaccinationRepositoryImpl(this.remote);


  @override
  Future<Either<Failure, List<Vaccination>>> getVaccinations({required String childId}) async {
    try {
      final res = await remote.getVaccinations(childId);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Vaccination>> addVaccination({required Vaccination vaccination}) async {
    try {
      final res = await remote.addVaccination(_toModel(vaccination));
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Unit>> deleteVaccination({required String id}) async {
    try {
      await remote.deleteVaccination(id);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Vaccination>> markAdministered({required String id, required DateTime administeredAt}) async {
    try {
      final res = await remote.markAdministered(id, administeredAt);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Vaccination>> updateVaccination({required Vaccination vaccination}) async {
    try {
      final res = await remote.updateVaccination(_toModel(vaccination));
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  VaccinationModel _toModel(Vaccination v) => VaccinationModel(
    id: v.id,
    childId: v.childId,
    vaccineName: v.vaccineName,
    doseNumber: v.doseNumber,
    scheduledAt: v.scheduledAt,
    administeredAt: v.administeredAt,
    location: v.location,
    notes: v.notes,
    status: v.status,
  );
}