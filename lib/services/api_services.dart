import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat.dart';

class ApiService {
  static const String baseUrl = "https://http.cat/";

  Future<Cat> getCat(int statusCode) async {
    final String url = '$baseUrl$statusCode';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Cat.fromJson({'statusCode': statusCode});
      } else {
        throw Exception('Failed to load cat image for status code $statusCode');
      }
    } catch (e) {
      throw Exception('Failed to load cat image for status code $statusCode');
    }
  }
}
