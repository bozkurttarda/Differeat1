import 'package:flutter/material.dart';
import 'package:recipepicker/manager/favorite_manager.dart';
import 'package:recipepicker/state/recipe_model.dart';

// State Management
class AppState extends ChangeNotifier {
  bool loadingSearch = false;

  final searchTextFocusNode = FocusNode();
  final searchTextController = TextEditingController();
  int selectedBottomNavbarIndex = 0;

  List<String> selectedCuisines = [];
  List<String> selectedIngredients = []; // Ingredients added by user
  List<RecipeModel> results = []; // Recipes found by app
  List<RecipeModel> favorites = [];

  AppState() {
    FavoriteManager.getFavoriteRecipes().then((value) {
      favorites = [...value];
    });
  }

  addCuisine(String cuisine) {
    selectedCuisines.add(cuisine);
    notifyListeners();
  }

  removeCuisine(String cuisine) {
    final index = selectedCuisines.indexOf(cuisine);
    if (index != -1) {
      selectedCuisines.removeAt(index);
    }
    notifyListeners();
  }

  Future<void> addFavorite(RecipeModel val) async {
    try {
      await FavoriteManager.addFavorite(val);
      final items = await FavoriteManager.getFavoriteRecipes();
      favorites = [...items];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeFavorite(RecipeModel val) async {
    try {
      await FavoriteManager.removeFavorite(val);
      final items = await FavoriteManager.getFavoriteRecipes();
      favorites = [...items];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void updateLoading(bool val) {
    loadingSearch = val;
    notifyListeners();
  }

  void updateResults(List<RecipeModel> val) {
    results = [...val];
    notifyListeners();
  }

  void clearResult() {
    results.clear();
    notifyListeners();
  }

  void updateSelectedNavbarIndex(int val) {
    selectedBottomNavbarIndex = val;
    notifyListeners();
  }

  void addIngredients(String val) {
    selectedIngredients.add(val);
    notifyListeners();
  }

  void removeIngredients(String val) {
    selectedIngredients.remove(val);
    notifyListeners();
  }

  void clearIngredients() {
    selectedIngredients.clear();
    notifyListeners();
  }
}
