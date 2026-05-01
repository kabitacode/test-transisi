import 'dart:convert';
import 'package:test_transisi/services/base_api.dart';
import 'package:http/http.dart' as http;

class EmployeeApi extends BaseApi {
  Future<List<dynamic>> getEmployee({int page = 1}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/users?page=$page"),
      headers: headers,
    );
    return jsonDecode(response.body)['data'];
  }

  Future<Map<String, dynamic>> getDetail(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/users/$id"),
      headers: headers,
    );

    return jsonDecode(response.body)['data'];
  }

  Future<bool> createUser(
    String name,
    String job,
    String telp,
    String email,
    String web,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users"),
        headers: {...headers, "Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "job": job,
          "telp": telp,
          "email": email,
          "web": web,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
