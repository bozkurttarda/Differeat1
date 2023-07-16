import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipepicker/state/recipe_model.dart';

class RecipeManager {
  Future<List<RecipeModel>> readData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/dataset.json');
      final List data = jsonDecode(response);
      List<RecipeModel> results =
          data.map((data) => RecipeModel.fromMap(data)).toList();

      return results;
    } catch (e) {
      return [];
    }
  }

  Future<List<RecipeModel>> searchRecipe(
    List<String> ingredients,
    List<String> selectedCuisines,
  ) async {
    try {
      final items = await readData();

      // Filter ingredients
      final results = items.where((element) {
        final ingredientText = element.ingredients.join('\n');
        bool val = true;

        for (var i = 0; i < ingredients.length; i++) {
          if (!ingredientText.contains(ingredients[i])) {
            val = false;
          }
        }
        return val;
      }).toList();

      return results
          .where((element) => selectedCuisines
              .map((e) => e.toLowerCase())
              .contains(element.cuisine.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
