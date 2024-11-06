import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(Uri.encodeFull(recipe.categoryUrl));
      await launchUrl(url, mode: LaunchMode.externalApplication);
      debugPrint('Could not launch URL: ${recipe.categoryUrl}');
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(recipe.categoryName),
        subtitle: Text("カテゴリID: ${recipe.categoryId.toString()}"),
        trailing: const Icon(Icons.arrow_forward),
        onTap: _launchUrl,  // タップしたときにURLを開く
      ),
    );
  }
}
