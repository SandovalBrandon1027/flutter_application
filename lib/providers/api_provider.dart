import 'package:flutter/foundation.dart';
import '../models/cat.dart';
import '../services/api_services.dart';

class CatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Cat? _cat;
  bool _isLoading = false;

  Cat? get cat => _cat;
  bool get isLoading => _isLoading;

  Future<void> fetchCat(int statusCode) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cat = await _apiService.getCat(statusCode);
    } catch (e) {
      // Manejo de errores
      print('Error fetching cat: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
