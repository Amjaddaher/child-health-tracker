import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  UserModel? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) throw Exception("فشل تسجيل الدخول");
      return UserModel.fromSupabase(user);
    } catch (e) {
      throw Exception("فشل تسجيل الدخول: ${e.toString()}");
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) throw Exception("فشل إنشاء الحساب");
      return UserModel.fromSupabase(user);
    } catch (e) {
      throw Exception("فشل إنشاء الحساب: ${e.toString()}");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw Exception("فشل تسجيل الخروج: ${e.toString()}");
    }
  }

  @override
  UserModel? getCurrentUser() {
    final user = client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabase(user);
  }
}
