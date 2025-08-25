import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../home_page.dart';
import '../../../chidlren/presentaion/pages/children_page.dart';
import '../../../growth_tracking/presentation/bloc/measurement_bloc.dart';
import '../../../growth_tracking/presentation/bloc/measurement_event.dart';
import '../../../reminders/presentation/bloc/reminder_event.dart';
import '../../../vaccinations/presentation/bloc/vaccinations_event.dart';
import '../../../vaccinations/presentation/bloc/vaccine_bloc.dart';
import '../../../growth_tracking/presentation/pages/growth_page.dart';
import '../../../vaccinations/presentation/pages/vaccination_page.dart';
import '../../../health_records/presentation/pages/health_records_page.dart';
import '../../../reminders/presentation/pages/reminders_page.dart';
import '../../../reminders/presentation/bloc/reminder_bloc.dart';
import '../../../auth/domain/entities/user_entity.dart';

class DashboardPage extends StatefulWidget {
  final UserEntity user;
  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  String? _selectedChildId;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ChildrenPage(onChildSelected: (id) {
          setState(() {
            _selectedChildId = id;
            _selectedIndex = 1;
          });
          context.read<MeasurementBloc>().add(LoadMeasurements(id));
          context.read<VaccinationBloc>().add(LoadVaccinations(id));
          context.read<RemindersBloc>().add(RemindersFetch(id));
        });
      case 1:
        if (_selectedChildId == null) return Center(child: Text('dashboard.select_child_for_growth'.tr));
        return GrowthPage(childId: _selectedChildId!);
      case 2:
        if (_selectedChildId == null) return Center(child: Text('dashboard.select_child_for_vaccines'.tr));
        return VaccinationsPage(childId: _selectedChildId!);
      case 3:
        if (_selectedChildId == null) return Center(child: Text('dashboard.select_child_for_visits'.tr));
        return HealthRecordPage(childId: _selectedChildId!);
      case 4:
        if (_selectedChildId == null) return Center(child: Text('dashboard.select_child_for_reminders'.tr));
        return RemindersPage(childId: _selectedChildId!);
      default:
        return Center(child: Text('dashboard.unknown'.tr));
    }
  }

  Future<void> _changeLanguage(Locale locale, String saveValue) async {
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', saveValue);
  }

  Future<void> _showLanguageChooser() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Language'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.language), title: const Text('English'), onTap: () { _changeLanguage(const Locale('en', 'US'), 'en_US'); Navigator.of(context).pop(); }),
          ListTile(leading: const Icon(Icons.language), title: const Text('العربية'), onTap: () { _changeLanguage(const Locale('ar', 'AR'), 'ar_AR'); Navigator.of(context).pop(); }),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('dashboard.child_info'.tr),
          actions: [IconButton(tooltip: 'Change language', icon: const Icon(Icons.language), onPressed: _showLanguageChooser)],
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueAccent,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.blueAccent,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.child_care), label: 'dashboard.child_info'.tr),
            BottomNavigationBarItem(icon: const Icon(Icons.show_chart), label: 'dashboard.growth'.tr),
            BottomNavigationBarItem(icon: const Icon(Icons.vaccines), label: 'dashboard.vaccinations'.tr),
            BottomNavigationBarItem(icon: const Icon(Icons.medical_services), label: 'dashboard.visits'.tr),
            BottomNavigationBarItem(icon: const Icon(Icons.alarm), label: 'dashboard.reminders'.tr),
          ],
        ),
      ),
    );
  }
}
