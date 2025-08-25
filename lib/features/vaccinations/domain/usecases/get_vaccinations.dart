import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination.dart';
import '../repositories/vaccine_repository.dart';

class GetVaccinations{
  final VaccinationRepository repository;
  GetVaccinations(this.repository);

  Future<Either<Failure, List<Vaccination>>> call(GetVaccinationsParams params) async {
    return await repository.getVaccinations(childId: params.childId);
  }
}

class GetVaccinationsParams {
  final String childId;
  const GetVaccinationsParams(this.childId);
}
