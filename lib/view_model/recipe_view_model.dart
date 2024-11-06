import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import 'dart:convert';

class RecipeViewModel extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  Future<void> fetchCategories() async {
    final apiKey = dotenv.env['RAKUTEN_API_KEY'];
    final url = Uri.parse(
        'https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _recipes = (data['result']['large'] as List)
          .map((json) => Recipe.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
