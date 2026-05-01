import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_transisi/core/theme/app_colors.dart';
import 'package:test_transisi/presentation/viewmodels/auth/auth_view_model.dart';
import 'package:test_transisi/presentation/views/pages/home_page.dart';
import 'package:test_transisi/presentation/views/widget/app_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    final authViewModel = context.read<AuthViewModel>();

    final result = await authViewModel.login(
      emailController.text,
      passwordController.text,
    );

    if (!mounted) return;

    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      final message = authViewModel.errorMessage ?? "Login Gagal.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
        ),
      );

      authViewModel.errorMessage = null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.primary.withValues(alpha: 0.8),
                    ),
                    child: const Icon(
                      Icons.person_4_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              AppInput(
                label: "Email",
                icon: Icons.email,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              AppInput(
                label: "Password",
                icon: Icons.password,
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(25),
                  ),
                ),
                onPressed: authViewModel.isLoading ? null : handleLogin,
                child: authViewModel.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
