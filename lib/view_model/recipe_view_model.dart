import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_search/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeViewModel extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = []; // フィルタリングされたリスト
  List<Recipe> get recipes => _filteredRecipes; // フィルタ済みリストを公開

  Future<void> fetchCategories(String categoryType) async {
    final apiKey = dotenv.env['RAKUTEN_API_KEY'];
    final url = Uri.parse(
        'https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=$apiKey&categoryType=$categoryType');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _recipes = (data['result'][categoryType] as List)
          .map((json) => Recipe.fromJson(json))
          .toList();
      _filteredRecipes = _recipes; // 初期状態では全レシピを表示
      notifyListeners();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // 検索ボックスに入力した文字列でレシピをフィルタリングする
  void filterRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = _recipes; // 空欄なら全て表示
    } else {
      _filteredRecipes = _recipes
          .where((recipe) =>
          recipe.categoryName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // リスナーに通知
  }
}
