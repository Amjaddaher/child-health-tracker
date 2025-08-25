import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/child_model.dart';

abstract class ChildrenRemoteDataSource {
  Future<List<ChildModel>> getChildren();

  Future<void> addChild(ChildModel child);

  Future<void> deleteChild(String id);
}

class ChildrenRemoteDataSourceImpl implements ChildrenRemoteDataSource {
  final SupabaseClient client;

  ChildrenRemoteDataSourceImpl(this.client);

  @override
  Future<List<ChildModel>> getChildren() async {
    try {
      print(client.auth.currentUser!.id);
      final response = await client
          .from('children')
          .select()
          .eq('doctor_id', client.auth.currentUser!.id);
      return response.map((e) => ChildModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("فشل تحميل الأطفال: ${e.toString()}");
    }
  }

  @override
  Future<void> addChild(ChildModel child) async {
    try {
      print(child);

      await client.from('children').insert(child.toJson());
    } catch (e) {
      print(e);

      throw Exception("فشل إضافة الطفل: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteChild(String id) async {
    final client = Supabase.instance.client;
    if (client == null) throw Exception('Supabase client not initialized.');

    final tables = [
      'health_records',
      'health_record',
      'measurements',
      'reminders',
      'vaccinations',
    ];

    try {
      // 1) Delete dependents (skip tables that don't have child_id)
      for (final t in tables) {
        try {
          final resp = await client.from(t).delete().eq('child_id', id);
          print('delete from $t -> $resp');
          // If resp is null, we still continue because some tables might not exist/have child_id
          if (resp?.error != null) {
            final msg = resp!.error?.message ?? resp.error.toString();
            if (msg.toLowerCase().contains('column') && msg.toLowerCase().contains('child_id')) {
              print('Skipping $t — no child_id column: $msg');
              continue;
            }
            throw Exception('Error deleting from $t: $msg');
          }
        } catch (e) {
          final s = e.toString().toLowerCase();
          if (s.contains('child_id') && s.contains('does not exist')) {
            print('Skipping $t — missing column: $e');
            continue;
          }
          rethrow;
        }
      }

      // 2) Delete the child and request the deleted row back (avoid null-response / 204 issues)
      final childResp = await client
          .from('children')
          .delete()
          .eq('id', id)
          .select() // <-- ensures the deleted row is returned by PostgREST
          ;

      print('delete from children -> $childResp');

      // Diagnostics & checks
      if (childResp == null) {
        throw Exception(
            'Null response when deleting child. Possible network/auth issue or client bug. '
                'Check Supabase initialization, keys and network.'
        );
      }



      // If data is empty/null => nothing deleted (maybe id doesn't exist or permission blocked)
      final data = childResp;
      final deletedCount = (data is List) ? data.length : (data != null ? 1 : 0);

      if (deletedCount == 0) {
        throw Exception(
            'Delete executed but no rows returned/deleted. Possible causes:\n'
                '- child with id does not exist\n'
                '- Row-Level Security (RLS) / policy prevented deletion\n'
                '- using anon key with insufficient permissions\n'
                'Try querying the child first or use a service_role key for server-side deletes.'
        );
      }

      print('Child deleted successfully (deletedCount=$deletedCount).');
    } catch (e, st) {
      print('deleteChild failed: $e\n$st');
      throw Exception('فشل حذف الطفل: ${e.toString()}');
    }
  }


}
