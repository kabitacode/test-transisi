import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mmkv/mmkv.dart';
import 'package:provider/provider.dart';
import 'package:test_transisi/core/theme/app_theme.dart';
import 'package:test_transisi/presentation/viewmodels/auth/auth_view_model.dart';
import 'package:test_transisi/presentation/viewmodels/employee/employee_view_model.dart';
import 'package:test_transisi/presentation/views/pages/home_page.dart';
import 'package:test_transisi/presentation/views/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MMKV.initialize();
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()..init()),
        ChangeNotifierProvider(create: (_) => EmployeeViewModel()),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: auth.isLoggedIn ? HomePage() : LoginPage(),
          );
        },
      ),
    );
  }
}
