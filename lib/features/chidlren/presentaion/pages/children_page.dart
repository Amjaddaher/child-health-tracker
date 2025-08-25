// lib/features/children/presentaion/pages/children_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../../auth/presentaion/bloc/auth_bloc.dart';
import '../../../auth/presentaion/bloc/auth_event.dart';
import '../../../auth/presentaion/bloc/auth_state.dart';
import '../../../auth/presentaion/pages/login_page.dart';
import '../bloc/children_bloc.dart';
import '../bloc/children_state.dart';
import '../../domain/entity/child.dart';
import '../widgets/child_card..dart';

class ChildrenPage extends StatefulWidget {
  final Function(String)? onChildSelected;
  const ChildrenPage({super.key, this.onChildSelected});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChildrenBloc>().add(LoadChildren());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate to login and clear stack
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('common.error_with_message'.trParams({'msg': state.message}))),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('children.title'.tr),
          actions: [
            IconButton(
              tooltip: 'auth.logout'.tr,
              icon: const Icon(Icons.logout),
              onPressed: _confirmLogout,
            ),
          ],
        ),
        body: BlocBuilder<ChildrenBloc, ChildrenState>(
          builder: (context, state) {
            if (state is ChildrenLoading) return const Center(child: CircularProgressIndicator());
            if (state is ChildrenError) return Center(child: Text('common.error_with_message'.trParams({'msg': state.message})));
            if (state is ChildrenLoaded) {
              if (state.children.isEmpty) {
                return Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.child_care, size: 72, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text('children.no_data'.tr),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(onPressed: _showAddChildSheet, icon: const Icon(Icons.add), label: Text('children.add'.tr)),
                  ]),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.children.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final child = state.children[i];
                  final details = '${child.weight?.toStringAsFixed(1) ?? '-'} kg · ${child.height?.toStringAsFixed(0) ?? '-'} cm';
                  return ChildCard(
                    name: child.name,
                    details: details,
                    avatarLetter: child.name.isNotEmpty ? child.name[0] : null,
                    onTap: () {
                      if (widget.onChildSelected != null) widget.onChildSelected!(child.id!);
                    },
                    onDelete: () => context.read<ChildrenBloc>().add(DeleteChildEvent(child.id!)),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: _showAddChildSheet, child: const Icon(Icons.add)),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final should = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('auth.logout_confirm_title'.tr),
        content: Text('auth.logout_confirm_body'.tr),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('common.no'.tr)),
          ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('common.yes'.tr)),
        ],
      ),
    );

    if (should == true) {
      context.read<AuthBloc>().add(SignOutEvent());
      // AuthBloc listener above will handle navigation on success/failure snackbar on error
    }
  }

  void _showAddChildSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _AddChildForm(onSave: (child) {
          context.read<ChildrenBloc>().add(AddChildEvent(child));
          Navigator.of(context).pop();
        }),
      ),
    );
  }
}

class _AddChildForm extends StatefulWidget {
  final void Function(Child) onSave;
  const _AddChildForm({required this.onSave});

  @override
  State<_AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends State<_AddChildForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _weight = TextEditingController();
  final _height = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('children.add_dialog_title'.tr, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(controller: _name, decoration: InputDecoration(labelText: 'children.name'.tr), validator: (v) => v == null || v.isEmpty ? 'required'.tr : null),
          const SizedBox(height: 8),
          TextFormField(controller: _weight, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'children.weight'.tr)),
          const SizedBox(height: 8),
          TextFormField(controller: _height, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'children.height'.tr)),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text('common.cancel'.tr))),
            const SizedBox(width: 8),
            Expanded(child: ElevatedButton(onPressed: _save, child: Text('children.save'.tr))),
          ]),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _save() {
    print(Supabase.instance.client.auth.currentUser!.id);
    print('++++++++++++++++');
    if (!_formKey.currentState!.validate()) return;
    final newChild = Child(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _name.text.trim(),
      weight: double.tryParse(_weight.text),
      height: double.tryParse(_height.text),
      headCircumference: null,
      notes: '',
      doctorId: Supabase.instance.client.auth.currentUser!.id.toString(),
    );
    widget.onSave(newChild);
  }
}
