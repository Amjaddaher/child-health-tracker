import 'package:doctor/features/vaccinations/presentation/bloc/vaccinations_event.dart';
import 'package:doctor/features/vaccinations/presentation/bloc/vaccinations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_vaccinations.dart';
import '../../domain/usecases/add_vaccination.dart';
import '../../domain/usecases/mark_dose_done.dart';
import '../../domain/usecases/update_vaccination.dart';
import '../../domain/usecases/delete_vaccination.dart';

class VaccinationBloc extends Bloc<VaccinationEvent, VaccinationState> {
  final GetVaccinations getVaccinations;
  final AddVaccination addVaccination;
  final UpdateVaccination updateVaccination;
  final DeleteVaccination deleteVaccination;
  final MarkAdministered markAdministered;

  VaccinationBloc({
    required this.getVaccinations,
    required this.addVaccination,
    required this.updateVaccination,
    required this.deleteVaccination,
    required this.markAdministered,
  }) : super(VaccinationInitial()) {
    on<LoadVaccinations>(_onLoadVaccinations);
    on<AddVaccinationEvent>(_onAddVaccination);
    on<UpdateVaccinationEvent>(_onUpdateVaccination);
    on<DeleteVaccinationEvent>(_onDeleteVaccination);
    on<MarkAdministeredEvent>(_onMarkAdministered);
  }

  Future<void> _onLoadVaccinations(
      LoadVaccinations event, Emitter<VaccinationState> emit) async {
    emit(VaccinationLoading());
    final result = await getVaccinations(GetVaccinationsParams(event.childId));
    result.fold(
          (failure) => emit(VaccinationError(failure.message)),
          (vaccinations) => emit(VaccinationLoaded(vaccinations)),
    );
  }

  Future<void> _onAddVaccination(
      AddVaccinationEvent event, Emitter<VaccinationState> emit) async {
    emit(VaccinationLoading());
    final result = await addVaccination(AddVaccinationParams(event.vaccination));
    result.fold(
          (failure) => emit(VaccinationError(failure.message)),
          (_) => emit(const VaccinationSuccess('Vaccination added successfully')),
    );
  }

  Future<void> _onUpdateVaccination(
      UpdateVaccinationEvent event, Emitter<VaccinationState> emit) async {
    emit(VaccinationLoading());
    final result =
    await updateVaccination(UpdateVaccinationParams(event.vaccination));
    result.fold(
          (failure) => emit(VaccinationError(failure.message)),
          (_) => emit(const VaccinationSuccess('Vaccination updated successfully')),
    );
  }

  Future<void> _onDeleteVaccination(
      DeleteVaccinationEvent event, Emitter<VaccinationState> emit) async {
    emit(VaccinationLoading());
    final result = await deleteVaccination(DeleteVaccinationParams(event.id));
    result.fold(
          (failure) => emit(VaccinationError(failure.message)),
          (_) => emit(const VaccinationSuccess('Vaccination deleted successfully')),
    );
  }

  Future<void> _onMarkAdministered(
      MarkAdministeredEvent event, Emitter<VaccinationState> emit) async {
    emit(VaccinationLoading());
    final result = await markAdministered(
      MarkAdministeredParams(event.id, event.administeredAt),
    );
    result.fold(
          (failure) => emit(VaccinationError(failure.message)),
          (_) => emit(const VaccinationSuccess('Marked as administered')),
    );
  }
}
