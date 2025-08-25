import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemindersRemoteDataSource {
  Future<List<Map<String, dynamic>>> getRemindersByChild(String childId);
  Future<Map<String, dynamic>> insertReminder(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateReminder(int id, Map<String, dynamic> changes);
  Future<void> deleteReminder(int id);
  Future<Map<String, dynamic>?> getReminderById(int id);
}

class RemindersRemoteDataSourceImpl implements RemindersRemoteDataSource {
  final SupabaseClient supabase;
  RemindersRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<Map<String, dynamic>>> getRemindersByChild(String childId) async {
    final resp = await supabase
        .from('reminders')
        .select()
        .eq('child_id', childId)
        .order('due_at', ascending: true);
    print(resp);

    return (resp as List).cast<Map<String, dynamic>>();
  }

  @override
  Future<Map<String, dynamic>> insertReminder(Map<String, dynamic> data) async {
    try{
      final resp = await supabase
          .from('reminders')
          .insert(data)
          .select()
          .single();
      print(data);
      print(resp);

      return resp;
    }
    catch(E){
      print(data);
      print(E);
      throw Exception(E);
    }
  }

  @override
  Future<Map<String, dynamic>> updateReminder(int id, Map<String, dynamic> changes) async {
    final resp = await supabase
        .from('reminders')
        .update(changes)
        .eq('id', id)
        .select()
        .single();

    return resp;
  }

  @override
  Future<void> deleteReminder(int id) async {
    await supabase.from('reminders').delete().eq('id', id);
  }

  @override
  Future<Map<String, dynamic>?> getReminderById(int id) async {
    try {
      final resp = await supabase
          .from('reminders')
          .select()
          .eq('id', id)
          .single();

      return resp as Map<String, dynamic>?;
    } catch (e) {
      // Supabase throws PostgrestException if not found (406/404)
      return null;
    }
  }
}
