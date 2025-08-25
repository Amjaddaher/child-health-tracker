import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination.dart';
import '../repositories/vaccine_repository.dart';

class MarkAdministered  {
  final VaccinationRepository repository;
  MarkAdministered(this.repository);

  Future<Either<Failure, Vaccination>> call(MarkAdministeredParams params) async {
    return await repository.markAdministered(
      id: params.id,
      administeredAt: params.administeredAt,
    );
  }
}

class MarkAdministeredParams {
  final String id;
  final DateTime administeredAt;
  const MarkAdministeredParams(this.id, this.administeredAt);
}
