import 'package:doctor/features/reminders/domain/usecases/create_reminder.dart';
import 'package:doctor/features/reminders/domain/usecases/delete_reminder.dart';
import 'package:doctor/features/reminders/domain/usecases/get_reminder.dart';
import 'package:doctor/features/reminders/domain/usecases/get_reminder_by_id.dart';
import 'package:doctor/features/reminders/domain/usecases/toggle.dart';
import 'package:doctor/features/reminders/domain/usecases/update_reminder.dart';
import 'package:doctor/features/reminders/presentation/bloc/reminder_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ================== Auth Feature ==================
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentaion/bloc/auth_bloc.dart';

// ================== Children Feature ==================
import 'features/chidlren/data/datasource/children_remote_datasource.dart';
import 'features/chidlren/data/repositories/children_repository_impl.dart';
import 'features/chidlren/domain/repositories/children_repository.dart';
import 'features/chidlren/domain/usecase/add_children.dart';
import 'features/chidlren/domain/usecase/delete_child.dart';
import 'features/chidlren/domain/usecase/get_children.dart';
import 'features/chidlren/presentaion/bloc/children_bloc.dart';
// ================== Growth Tracking Feature ==================

import 'features/growth_tracking/data/datasources/measurement_remote_ds.dart';
import 'features/growth_tracking/data/repositories/measurement_repository_impl.dart';
import 'features/growth_tracking/domain/repositories/measurement_repository.dart';
import 'features/growth_tracking/domain/usecases/add_measurement.dart';
import 'features/growth_tracking/domain/usecases/delete_measurement.dart';
import 'features/growth_tracking/domain/usecases/get_measurement.dart';
import 'features/growth_tracking/presentation/bloc/measurement_bloc.dart';

// ================== Health Records Feature ==================
import 'features/health_records/data/datasources/health_record_remote_ds.dart';
import 'features/health_records/data/repositories/health_record_repository_impl.dart';
import 'features/health_records/domain/repositories/health_record_repository.dart';
import 'features/health_records/domain/usecases/add_visit.dart';
import 'features/health_records/domain/usecases/delete_visit.dart';
import 'features/health_records/domain/usecases/get_visits.dart';
import 'features/health_records/presentation/bloc/health_record_bloc.dart';

// ================== Vaccinations Feature ==================
import 'features/reminders/data/datasources/reminder_remote_ds.dart';
import 'features/reminders/data/repositories/reminder_repository_impl.dart';
import 'features/reminders/domain/repositories/reminder_repository.dart';
import 'features/vaccinations/data/datasources/vaccine_remote_ds.dart';
import 'features/vaccinations/data/repositories/vaccine_repository_impl.dart';
import 'features/vaccinations/domain/repositories/vaccine_repository.dart';
import 'features/vaccinations/domain/usecases/add_vaccination.dart';
import 'features/vaccinations/domain/usecases/delete_vaccination.dart';
import 'features/vaccinations/domain/usecases/get_vaccinations.dart';
import 'features/vaccinations/domain/usecases/mark_dose_done.dart';
import 'features/vaccinations/domain/usecases/update_vaccination.dart';
import 'features/vaccinations/presentation/bloc/vaccine_bloc.dart';
//
//

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton(() => supabase);

  /// HealthRecordBloc

  /// ================== Reminders Feature ==================
  // Bloc
  sl.registerFactory(() => RemindersBloc(sl()));
  // Usecases
  sl.registerLazySingleton(() => CreateReminder(sl()));
  sl.registerLazySingleton(() => UpdateReminder(sl()));
  sl.registerLazySingleton(() => DeleteReminder(sl()));
  sl.registerLazySingleton(() => GetRemindersByChildUseCase(sl()));
  sl.registerLazySingleton(() => GetReminderByIdUseCase(sl()));
  sl.registerLazySingleton(() => ToggleCompleteReminderUseCase(sl()));

  /// ================== Vaccinations Feature ==================
  sl.registerLazySingleton<VaccinationRemoteDataSource>(
        () => SupabaseVaccinationRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<VaccinationRepository>(
        () => VaccinationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetVaccinations(sl()));
  sl.registerLazySingleton(() => AddVaccination(sl()));
  sl.registerLazySingleton(() => UpdateVaccination(sl()));
  sl.registerLazySingleton(() => DeleteVaccination(sl()));
  sl.registerLazySingleton(() => MarkAdministered(sl()));
  sl.registerFactory(
        () => VaccinationBloc(
      getVaccinations: sl(),
      addVaccination: sl(),
      updateVaccination: sl(),
      deleteVaccination: sl(),
      markAdministered: sl(),
    ),
  );

  /// ================== Health Records Feature ==================
  ///
  sl.registerLazySingleton<HealthRecordRemoteDataSource>(
        () => HealthRecordRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HealthRecordRepository>(
        () => HealthRecordRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => AddHealthRecord(sl()));
  sl.registerLazySingleton(() => DeleteHealthRecord(sl()));
  sl.registerLazySingleton(() => GetHealthRecords(sl()));
  sl.registerFactory(
        () => HealthRecordBloc(
      getHealthRecords: sl(),
      deleteHealthRecord: sl(),
      addHealthRecord: sl(),
    ),
  );

  /// ================== Growth Tracking Feature ==================
  sl.registerLazySingleton<MeasurementRemoteDataSource>(
        () => MeasurementRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MeasurementRepository>(
        () => MeasurementRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RemindersRemoteDataSource>(
        () => RemindersRemoteDataSourceImpl(sl()), // e.g. HttpClient / Supabase / etc
  );

  sl.registerLazySingleton<RemindersRepository>(
        () => RemindersRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetMeasurements(sl()));
  sl.registerLazySingleton(() => AddMeasurement(sl()));
  sl.registerLazySingleton(() => DeleteMeasurement(sl()));
  sl.registerFactory(
        () => MeasurementBloc(
      getMeasurements: sl(),
      addMeasurement: sl(),
      deleteMeasurement: sl(),
    ),
  );

  /// ================== Children Feature ==================
  sl.registerLazySingleton<ChildrenRemoteDataSource>(
        () => ChildrenRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ChildrenRepository>(
        () => ChildrenRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetChildren(sl()));
  sl.registerLazySingleton(() => AddChild(sl()));
  sl.registerLazySingleton(() => DeleteChild(sl()));
  sl.registerFactory(
        () => ChildrenBloc(getChildren: sl(), addChild: sl(), deleteChild: sl()),
  );

  /// ================== Auth Feature ==================
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerFactory(
        () => AuthBloc(
      loginUseCase: sl(),
      signUpUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );


}
