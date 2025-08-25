import 'package:equatable/equatable.dart';
import '../../domain/entities/vaccination.dart';

abstract class VaccinationEvent extends Equatable {
  const VaccinationEvent();

  @override
  List<Object?> get props => [];
}

class LoadVaccinations extends VaccinationEvent {
  final String childId;
  const LoadVaccinations(this.childId);

  @override
  List<Object?> get props => [childId];
}

class AddVaccinationEvent extends VaccinationEvent {
  final Vaccination vaccination;
  const AddVaccinationEvent(this.vaccination);

  @override
  List<Object?> get props => [vaccination];
}

class UpdateVaccinationEvent extends VaccinationEvent {
  final Vaccination vaccination;
  const UpdateVaccinationEvent(this.vaccination);

  @override
  List<Object?> get props => [vaccination];
}

class DeleteVaccinationEvent extends VaccinationEvent {
  final String id;
  const DeleteVaccinationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAdministeredEvent extends VaccinationEvent {
  final String id;
  final DateTime administeredAt;
  const MarkAdministeredEvent(this.id, this.administeredAt);

  @override
  List<Object?> get props => [id, administeredAt];
}
