import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination.dart';


abstract class VaccinationRepository {
  Future<Either<Failure, List<Vaccination>>> getVaccinations({required String childId});
  Future<Either<Failure, Vaccination>> addVaccination({required Vaccination vaccination});
  Future<Either<Failure, Vaccination>> updateVaccination({required Vaccination vaccination});
  Future<Either<Failure, Unit>> deleteVaccination({required String id});
  Future<Either<Failure, Vaccination>> markAdministered({required String id, required DateTime administeredAt});
}