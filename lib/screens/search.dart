import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipepicker/components/result_card.dart';
import 'package:recipepicker/contanst.dart';
import 'package:recipepicker/manager/recipe_manager.dart';
import 'package:recipepicker/screens/recipe.dart';
import 'package:recipepicker/state/app_state.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  Widget ingredientsChipList(AppState state) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 5,
      spacing: 8,
      children: [
        for (var item in state.selectedIngredients)
          Chip(
            deleteIcon: const Icon(Icons.close),
            onDeleted: () => state.removeIngredients(item),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              child: Text(item),
            ),
          ),
      ],
    );
  }

  Future searchOnTap(AppState state) async {
    if (state.selectedIngredients.isEmpty) {
      Fluttertoast.showToast(msg: "Enter an ingredient to search!");
      return;
    }
    state.updateLoading(true);
    final res = await RecipeManager().searchRecipe(
      state.selectedIngredients,
      state.selectedCuisines,
    );
    if (res.isEmpty) {
      Fluttertoast.showToast(msg: "No Result Found!");
    }
    Fluttertoast.showToast(msg: "${res.length} Result Found!");
    if (res.length > 32) {
      state.updateResults(res.sublist(0, 30));
    } else {
      state.updateResults(res);
    }
    state.updateLoading(false);
  }

  void addIconOnTap(AppState state) {
    if (state.searchTextController.text.isEmpty ||
        state.searchTextController.text == " ") {
      Fluttertoast.showToast(msg: "Empty text!");
      return;
    }
    state.addIngredients(
      state.searchTextController.text.toLowerCase(),
    );
    state.searchTextController.clear();
    state.searchTextFocusNode.unfocus();
  }

  Widget buildResultList(AppState appState, BuildContext context) {
    return ListView(
      children: [
        for (var item in appState.results)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Recipe(recipeModel: item),
                ),
              );
            },
            child: ResultCard(
              onFavTap: () async {
                if (appState.favorites.contains(item)) {
                  await appState.removeFavorite(item);
                } else {
                  await appState.addFavorite(item);
                }
              },
              item: item,
              isFavorite: appState.favorites.contains(item),
            ),
          )
      ],
    );
  }

  Widget buildCuisineList(AppState state) {
    return SizedBox(
      height: 45,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (var item in cuisines)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GestureDetector(
                onTap: () {
                  if (state.selectedCuisines.contains(item)) {
                    state.removeCuisine(item);
                  } else {
                    state.addCuisine(item);
                  }
                },
                child: Card(
                  color: state.selectedCuisines.contains(item)
                      ? Colors.green.shade300
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              buildCuisineList(state),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                focusNode: state.searchTextFocusNode,
                controller: state.searchTextController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => addIconOnTap(state),
                  ),
                  labelText: "Enter an ingredient...",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ingredientsChipList(state),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              if (state.loadingSearch)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => state.clearResult(),
                      child: const Text(
                        "Clear Results",
                      ),
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () => searchOnTap(state),
                      child: const Text(
                        "Search",
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Expanded(
                child: buildResultList(state, context),
              )
            ],
          ),
        );
      },
    );
  }
}
