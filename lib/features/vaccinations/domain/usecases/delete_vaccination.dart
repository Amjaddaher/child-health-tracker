import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../repositories/vaccine_repository.dart';

class DeleteVaccination{
  final VaccinationRepository repository;
  DeleteVaccination(this.repository);

  Future<Either<Failure, Unit>> call(DeleteVaccinationParams params) async {
    return await repository.deleteVaccination(id: params.id);
  }
}

class DeleteVaccinationParams {
  final String id;
  const DeleteVaccinationParams(this.id);
}
