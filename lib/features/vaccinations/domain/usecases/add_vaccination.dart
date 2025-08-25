import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination.dart';
import '../repositories/vaccine_repository.dart';

class AddVaccination {
  final VaccinationRepository repository;
  AddVaccination(this.repository);

  Future<Either<Failure, Vaccination>> call(AddVaccinationParams params) async {
    return await repository.addVaccination(vaccination: params.vaccination);
  }
}

class AddVaccinationParams {
  final Vaccination vaccination;
  const AddVaccinationParams(this.vaccination);
}
