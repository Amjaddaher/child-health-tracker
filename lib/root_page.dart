// lib/check_if_have_account.dart
import 'dart:async';

import 'package:doctor/features/auth/presentaion/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

import 'features/auth/presentaion/pages/login_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/auth/domain/entities/user_entity.dart';

class CheckIfHaveAccount extends StatefulWidget {
  const CheckIfHaveAccount({super.key});

  @override
  State<CheckIfHaveAccount> createState() => _CheckIfHaveAccountState();
}

class _CheckIfHaveAccountState extends State<CheckIfHaveAccount> {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();

    // Listen for auth changes (including session restore on startup)
    _authSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) {
          final session = data.session;
          if (session != null) {
            //  Convert Supabase User -> UserEntity
            final supaUser = session.user;
            final userEntity = UserEntity(
              id: supaUser.id,            // uuid from Supabase
              email: supaUser.email ?? '',
              // add other fields if you have in your UserEntity
            );

            Get.offAll(() => DashboardPage(user: userEntity));
          } else {
            Get.offAll(() =>  LoginPage());
          }
        });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
