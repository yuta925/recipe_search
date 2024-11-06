import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:recipe_search/views/recipe_list_screen.dart';
import 'view_model/recipe_view_model.dart';
import 'views/recipe_list_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeViewModel(),
      child: const MaterialApp(
        home: RecipeListScreen(),
      ),
    );
  }
}
