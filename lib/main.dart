import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/translations/app_translations.dart';
import 'features/auth/presentaion/bloc/auth_bloc.dart';
import 'features/auth/presentaion/bloc/auth_event.dart';
import 'features/chidlren/presentaion/bloc/children_bloc.dart';
import 'features/growth_tracking/presentation/bloc/measurement_bloc.dart';
import 'features/health_records/presentation/bloc/health_record_bloc.dart';
import 'features/reminders/presentation/bloc/reminder_bloc.dart';
import 'features/vaccinations/presentation/bloc/vaccine_bloc.dart';
import 'injection_container.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/auth/presentaion/pages/login_page.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
  scaffoldBackgroundColor: Colors.grey[50],
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    elevation: 4,
    margin: EdgeInsets.zero,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    prefixIconColor: Colors.grey[700],
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'your_supabase_api_key',
    anonKey: 'your_supabase_anonKey',
  );

  await initDependencies();

  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('locale');
  Locale? initialLocale;
  if (saved != null) {
    final parts = saved.split('_');
    if (parts.length == 2) initialLocale = Locale(parts[0], parts[1]);
  }

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()..add(CheckCurrentUserEvent())),
        BlocProvider<ChildrenBloc>(create: (_) => sl<ChildrenBloc>()),
        BlocProvider<MeasurementBloc>(create: (_) => sl<MeasurementBloc>()),
        BlocProvider<VaccinationBloc>(create: (_) => sl<VaccinationBloc>()),
        BlocProvider<HealthRecordBloc>(create: (_) => sl<HealthRecordBloc>()),
        BlocProvider<RemindersBloc>(create: (_) => sl<RemindersBloc>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Health Tracking",
        translations: AppTranslations(),
        locale: initialLocale ?? const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: appTheme,
        home: const LoginPage(), // or a splash / auth-check page
      ),
    );
  }
}
