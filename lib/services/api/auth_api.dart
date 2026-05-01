import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_transisi/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthApi extends BaseApi {
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: headers,
      body: {
        "email": email,
        "password": password
      }
    );
    debugPrint('response $response');

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data['token'];
    } else {
      throw Exception(data['error']);
    }
  }
}