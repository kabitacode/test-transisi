import 'package:flutter/material.dart';
import 'package:test_transisi/core/theme/app_colors.dart';
import 'package:test_transisi/presentation/viewmodels/employee/employee_view_model.dart';
import 'package:test_transisi/presentation/views/widget/app_input.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  final telpController = TextEditingController();
  final emailController = TextEditingController();
  final webController = TextEditingController();

  Future<void> handleSubmit() async {
    final contextViewModel = context.read<EmployeeViewModel>();

    if (nameController.text.isEmpty || jobController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Inputan belum diisi.")));
      return;
    }

    final data = await contextViewModel.addUser(
      nameController.text,
      jobController.text,
      telpController.text,
      emailController.text,
      webController.text,
    );
    if (!mounted) return;

    if (data) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Successfully add user")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error add user")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    telpController.dispose();
    emailController.dispose();
    webController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contextViewModel = context.watch<EmployeeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () =>
              () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: TextButton(
              onPressed: contextViewModel.isLoading ? null : handleSubmit,
              child: contextViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: contextViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {},
                          child: const Icon(
                            Icons.camera_alt,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppInput(
                    label: "Name",
                    icon: Icons.person,
                    controller: nameController,
                  ),
                  AppInput(
                    label: "Job",
                    icon: Icons.work,
                    controller: jobController,
                  ),
                  AppInput(
                    label: "Telphone",
                    icon: Icons.phone,
                    controller: telpController,
                  ),
                  AppInput(
                    label: "Email",
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  AppInput(
                    label: "Web",
                    icon: Icons.web,
                    controller: webController,
                  ),
                ],
              ),
            ),
    );
  }
}
