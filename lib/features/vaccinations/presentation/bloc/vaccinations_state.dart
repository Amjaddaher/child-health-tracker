import 'package:equatable/equatable.dart';
import '../../domain/entities/vaccination.dart';

abstract class VaccinationState extends Equatable {
  const VaccinationState();

  @override
  List<Object?> get props => [];
}

class VaccinationInitial extends VaccinationState {}

class VaccinationLoading extends VaccinationState {}

class VaccinationLoaded extends VaccinationState {
  final List<Vaccination> vaccinations;
  const VaccinationLoaded(this.vaccinations);

  @override
  List<Object?> get props => [vaccinations];
}

class VaccinationError extends VaccinationState {
  final String message;
  const VaccinationError(this.message);

  @override
  List<Object?> get props => [message];
}

class VaccinationSuccess extends VaccinationState {
  final String message;
  const VaccinationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
