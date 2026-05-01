import 'package:flutter/material.dart';
import 'package:test_transisi/models/employee_model.dart';
import 'package:test_transisi/services/api/employee_api.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeApi _api = EmployeeApi();

  List<EmployeeModel> employees = [];
  EmployeeModel? detail;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchEmployees({bool isLoadMoreData = false}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _api.getEmployee();

      final result = response
          .map((item) => EmployeeModel.fromJson(item))
          .toList();

      employees = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDetail(int id) async {
    isLoading = true;
    errorMessage = null;
    detail = null;
    notifyListeners();

    try {
      final data = await _api.getDetail(id);
      detail = EmployeeModel.fromJson(data);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addUser(
    String name,
    String job,
    String telp,
    String email,
    String web,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      final success = await _api.createUser(name, job, telp, email, web);

      if (success) {
        await fetchEmployees();
      }
      return success;
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
