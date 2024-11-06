import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_search/models/recipe.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecipeService {
  final String apiKey = dotenv.env['RAKUTEN_API_KEY']!;

  Future<List<Recipe>> fetchRecipes(String ingredient) async {
    final response = await http.get(Uri.parse(
        'https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=$apiKey&categoryType=large'));
    debugPrint('response: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['recipes'] as List)
          .map((json) => Recipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
