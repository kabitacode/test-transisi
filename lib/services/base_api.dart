import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApi {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final String apiKey = dotenv.env['API_KEY']!;

  Map<String, String> get headers => {"x-api-key": apiKey};
}
