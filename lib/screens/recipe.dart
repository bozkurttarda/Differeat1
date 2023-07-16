import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipepicker/state/recipe_model.dart';

class Recipe extends StatelessWidget {
  final RecipeModel recipeModel;
  const Recipe({
    super.key,
    required this.recipeModel,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeModel.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 25,
          left: 12,
          right: 12,
          bottom: 50,
        ),
        children: [
          Text(
            recipeModel.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 35),
          Text(
            recipeModel.ingredients.map((e) => '- $e').join('\n'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 45),
          Text(
            recipeModel.directions.join('\n\n'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: recipeModel.link));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipeModel.link,
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
