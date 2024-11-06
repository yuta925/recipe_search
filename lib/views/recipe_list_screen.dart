import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/recipe_view_model.dart';
import 'recipe_card.dart';

class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({super.key});

  @override
  RecipeSearchScreenState createState() => RecipeSearchScreenState();
}

class RecipeSearchScreenState extends State<RecipeSearchScreen> {
  @override
  void initState() {
    super.initState();
    final recipeViewModel =
        Provider.of<RecipeViewModel>(context, listen: false);
    recipeViewModel.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List App'),
      ),
      body: recipeViewModel.recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipeViewModel.recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: recipeViewModel.recipes[index]);
              },
            ),
    );
  }
}
