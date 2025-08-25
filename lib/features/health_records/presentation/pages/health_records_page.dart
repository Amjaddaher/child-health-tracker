import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/health_record_bloc.dart';
import '../bloc/health_record_event.dart';
import '../bloc/health_record_state.dart';
import 'health_form_page.dart';
import '../../domain/entities/health_record.dart';

class HealthRecordPage extends StatefulWidget {
  final String childId;
  const HealthRecordPage({super.key, required this.childId});

  @override
  State<HealthRecordPage> createState() => _HealthRecordPageState();
}

class _HealthRecordPageState extends State<HealthRecordPage> {
  @override
  void initState() {
    super.initState();
    context.read<HealthRecordBloc>().add(LoadRecords(widget.childId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('health_record.appbar'.tr)),
      body: BlocBuilder<HealthRecordBloc, HealthRecordState>(builder: (context, state) {
        if (state is RecordsLoading) return const Center(child: CircularProgressIndicator());
        if (state is RecordsError) return Center(child: Text('common.error_with_message'.trParams({'msg': state.message})));
        if (state is RecordsLoaded) {
          if (state.records.isEmpty) return Center(child: Text('health_record.no_records'.tr));
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.records.length,
            itemBuilder: (context, index) {
              final HealthRecord record = state.records[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text('${record.details}', maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(record.date.toLocal().toString().split(' ').first, style: const TextStyle(color: Colors.grey)),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), tooltip: 'common.delete'.tr, onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('health_record.delete_confirm_title'.tr),
                        content: Text('health_record.delete_confirm_body'.trParams({
                          'details': record.details ?? '',
                          'date': record.date.toLocal().toString().split(' ').first
                        })),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('common.no'.tr)),
                          ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('common.yes'.tr)),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      context.read<HealthRecordBloc>().add(DeleteRecord(record.id, record.childId));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('health_record.deleted'.tr)));
                    }
                  }),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'health_record.add'.tr,
        onPressed: () {
          Get.to(() => HealthRecordFormPage(childId: widget.childId));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
