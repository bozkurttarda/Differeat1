import 'dart:convert';

import 'package:recipepicker/state/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteManager {
  static const String favoriteKey = "favoriteKey";

  static Future<List<RecipeModel>> getFavoriteRecipes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final res = prefs.getString(favoriteKey);
      if (res == "") return [];
      final List data = jsonDecode(res!);

      List<RecipeModel> favs =
          data.map((data) => RecipeModel.fromJson(data)).toList();
      return favs;
    } catch (e) {
      return [];
    }
  }

  static Future<void> addFavorite(RecipeModel recipeModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favs = await getFavoriteRecipes();
      favs.add(recipeModel);
      await prefs.setString(favoriteKey, jsonEncode(favs));
    } catch (e) {
      print(e);
    }
  }

  static Future<void> removeFavorite(RecipeModel recipeModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favs = await getFavoriteRecipes();
      favs.removeWhere((element) => element.title == recipeModel.title);

      prefs.setString(favoriteKey, jsonEncode(favs));
    } catch (e) {
      print(e);
    }
  }
}
