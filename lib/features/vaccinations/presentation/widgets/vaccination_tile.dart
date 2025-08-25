// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../domain/entities/vaccine_dose.dart';
// import '../bloc/vaccinations_event.dart';
// import '../bloc/vaccine_bloc.dart';
//
// class VaccinationTile extends StatelessWidget {
//   final Vaccination vaccination;
//   const VaccinationTile({Key? key, required this.vaccination}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(
//         vaccination.status == VaccinationStatus.administered
//             ? Icons.check_circle
//             : Icons.medical_services,
//       ),
//       title: Text('${vaccination.vaccineCode} — dose ${vaccination.doseNumber}'),
//       subtitle: Text(
//         'Scheduled: ${vaccination.scheduledDate?.toLocal().toString().split(' ').first ?? '-'}\n'
//             'Status: ${vaccination.status.name}',
//       ),
//       isThreeLine: true,
//       trailing: PopupMenuButton<String>(
//         onSelected: (a) => _onAction(context, a),
//         itemBuilder: (_) => const [
//           PopupMenuItem(value: 'mark', child: Text('Mark administered')),
//           PopupMenuItem(value: 'edit', child: Text('Edit')),
//           PopupMenuItem(value: 'delete', child: Text('Delete')),
//         ],
//       ),
//     );
//   }
//
//   void _onAction(BuildContext context, String action) {
//     final bloc = context.read<VaccinationsBloc>();
//     switch (action) {
//       case 'mark':
//         bloc.add(MarkVaccinationAdministeredEvent(vaccination.id, DateTime.now()));
//         break;
//       case 'edit':
//         bloc.add(UpdateVaccinationEvent(vaccination));
//         break;
//       case 'delete':
//         bloc.add(DeleteVaccinationEvent(vaccination.id));
//         break;
//     }
//   }
// }
