import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_transisi/core/theme/app_colors.dart';
import 'package:test_transisi/presentation/viewmodels/auth/auth_view_model.dart';
import 'package:test_transisi/presentation/viewmodels/employee/employee_view_model.dart';
import 'package:test_transisi/presentation/views/pages/add_page.dart';
import 'package:test_transisi/presentation/views/pages/detail_page.dart';
import 'package:test_transisi/presentation/views/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<int> favoriteId = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeViewModel>().fetchEmployees();
    });
  }

  Future<void> handleLogout() async {
    final authVm = context.read<AuthViewModel>();

    authVm.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<EmployeeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: handleLogout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (userViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (userViewModel.employees.isEmpty) {
            return Center(child: Text("Data tidak ada"));
          }

          return ListView.builder(
            itemCount: userViewModel.employees.length,
            itemBuilder: (context, index) {
              final data = userViewModel.employees[index];

              return Container(
                padding: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(id: data.id),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              data.firstName[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.firstName} ${data.lastName}",
                                style: TextStyle(
                                  color: AppColors.typography,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                data.email,
                                style: TextStyle(
                                  color: AppColors.typography,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (favoriteId.contains(data.id)) {
                              favoriteId.remove(data.id);
                            } else {
                              favoriteId.add(data.id);
                            }
                          });
                        },
                        icon: Icon(
                          favoriteId.contains(data.id)
                              ? Icons.star
                              : Icons.star_outline,
                          size: 25,
                          color: favoriteId.contains(data.id)
                              ? AppColors.primary
                              : AppColors.typography,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(999),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPage()),
        ),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
