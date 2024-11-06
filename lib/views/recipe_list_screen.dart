import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_search/views/recipe_card.dart';
import '../view_model/recipe_view_model.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  RecipeSearchScreenState createState() => RecipeSearchScreenState();
}

class RecipeSearchScreenState extends State<RecipeListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final recipeViewModel = Provider.of<RecipeViewModel>(context, listen: false);
    recipeViewModel.fetchCategories("large"); // デフォルトでlargeカテゴリを取得

    // 検索ボックスの入力が変わるたびにフィルタリング
    _searchController.addListener(() {
      recipeViewModel.filterRecipes(_searchController.text);
    });
  }

  void _fetchCategory(String categoryType) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context, listen: false);
    recipeViewModel.fetchCategories(categoryType);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Categories'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            switch (index) {
              case 0:
                _fetchCategory("large");
                break;
              case 1:
                _fetchCategory("medium");
                break;
              case 2:
                _fetchCategory("small");
                break;
            }
          },
          tabs: const [
            Tab(text: 'large'),
            Tab(text: 'medium'),
            Tab(text: 'small'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for ingredients',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryList(recipeViewModel),
                _buildCategoryList(recipeViewModel),
                _buildCategoryList(recipeViewModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(RecipeViewModel recipeViewModel) {
    return recipeViewModel.recipes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: recipeViewModel.recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipeViewModel.recipes[index]);
      },
    );
  }
}
