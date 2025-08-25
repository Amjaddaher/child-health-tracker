import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination.dart';
import '../repositories/vaccine_repository.dart';

class UpdateVaccination {
  final VaccinationRepository repository;
  UpdateVaccination(this.repository);

  Future<Either<Failure, Vaccination>> call(UpdateVaccinationParams params) async {
    return await repository.updateVaccination(vaccination: params.vaccination);
  }
}

class UpdateVaccinationParams {
  final Vaccination vaccination;
  const UpdateVaccinationParams(this.vaccination);
}
