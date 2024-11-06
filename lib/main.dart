import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'view_model/recipe_view_model.dart';
import 'views/recipe_list_screen.dart';

Future<void> main() async {
  await dotenv.load(); // .envファイルの読み込み
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeViewModel()),
      ],
      child: MaterialApp(
        title: 'Recipe List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RecipeSearchScreen(),
      ),
    );
  }
}
