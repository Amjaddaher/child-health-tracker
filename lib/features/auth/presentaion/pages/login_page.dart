import 'package:doctor/features/auth/presentaion/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:doctor/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => DashboardPage(user: state.user)));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('common.error_with_message'.trParams({'msg': state.message}))),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(tag: 'app_logo', child: CircleAvatar(radius: 36, child: Text('Dr'))),
                        const SizedBox(height: 12),
                        Text('auth.login_title'.tr, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailCtl,
                          decoration: InputDecoration(labelText: 'auth.email'.tr, prefixIcon: const Icon(Icons.email)),
                          validator: (v) => v == null || v.isEmpty ? 'auth.enter_email'.tr : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passCtl,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'auth.password'.tr, prefixIcon: const Icon(Icons.lock)),
                          validator: (v) => v == null || v.isEmpty ? 'auth.enter_password'.tr : null,
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) return const CircularProgressIndicator();
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) return;
                                  context.read<AuthBloc>().add(SignInEvent(_emailCtl.text.trim(), _passCtl.text.trim()));
                                },
                                child: Text('auth.login_button'.tr),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('auth.no_account'.tr),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage())),
                              child: Text('auth.signup_button'.tr),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
