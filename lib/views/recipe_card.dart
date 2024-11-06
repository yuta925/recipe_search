import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(recipe.categoryName),
        subtitle: Text("カテゴリID: ${recipe.categoryId}"),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () async {
          final url = recipe.categoryUrl;
          // ignore: deprecated_member_use
          if (await canLaunch(url)) {
            // ignore: deprecated_member_use
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}
