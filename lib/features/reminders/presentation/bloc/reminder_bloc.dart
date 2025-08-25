import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/reminder_repository.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  final RemindersRepository repository;

  RemindersBloc(this.repository) : super(const RemindersInitial()) {
    on<RemindersFetch>(_onFetch);
    on<RemindersCreate>(_onCreateOrUpdate);
    on<RemindersUpdate>(_onCreateOrUpdate);
    on<RemindersDelete>(_onDelete);
    on<RemindersToggleComplete>(_onToggleComplete);
    on<RemindersGetById>(_onGetById);
  }

  Future<void> _onFetch(RemindersFetch event, Emitter<RemindersState> emit) async {
    emit(const RemindersLoading());
    final res = await repository.getByChild(event.childId);
    res.fold(
          (l) => emit(RemindersError(l.toString())),
          (r) => emit(RemindersLoaded(r)),
    );
  }

  Future<void> _onCreateOrUpdate(dynamic event, Emitter<RemindersState> emit) async {
    emit(const RemindersLoading());
    final result = event is RemindersCreate
        ? await repository.create(event.reminder)
        : await repository.update(event.reminder);

    result.fold(
          (l) => emit(RemindersError(l.toString())),
          (_) async {
        final listRes = await repository.getByChild(event.reminder.childId);
        listRes.fold(
              (l) => emit(RemindersError(l.toString())),
              (r) => emit(RemindersLoaded(r)),
        );
      },
    );
  }

  Future<void> _onDelete(RemindersDelete event, Emitter<RemindersState> emit) async {
    emit(const RemindersLoading());
    final res = await repository.delete(event.id);
    res.fold(
          (l) => emit(RemindersError(l.toString())),
          (_) => emit(const RemindersInitial()),
    );
  }

  Future<void> _onToggleComplete(RemindersToggleComplete event, Emitter<RemindersState> emit) async {
    emit(const RemindersLoading());
    final res = await repository.toggleComplete(event.id, completed: event.completed);
    res.fold(
          (l) => emit(RemindersError(l.toString())),
          (r) => emit(ReminderOperationSuccess(r)),
    );
  }

  Future<void> _onGetById(RemindersGetById event, Emitter<RemindersState> emit) async {
    emit(const RemindersLoading());
    final res = await repository.getById(event.id);
    res.fold(
          (l) => emit(RemindersError(l.toString())),
          (r) => emit(ReminderOperationSuccess(r)),
    );
  }
}
