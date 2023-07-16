import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipepicker/components/result_card.dart';
import 'package:recipepicker/screens/recipe.dart';
import 'package:recipepicker/state/app_state.dart';

// Create Favorite manager and create store for it.
class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        if (state.favorites.isEmpty) {
          return const Center(
            child: Text(
              "No Favorite Yet!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: state.favorites.length,
          itemBuilder: (context, index) {
            final item = state.favorites.elementAt(index);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Recipe(recipeModel: item),
                  ),
                );
              },
              child: ResultCard(
                onFavTap: () {
                  if (state.favorites.contains(item)) {
                    state.removeFavorite(item);
                  } else {
                    state.addFavorite(item);
                  }
                },
                item: item,
                isFavorite: true,
              ),
            );
          },
        );
      },
    );
  }
}
