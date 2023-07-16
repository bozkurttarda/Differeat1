import 'package:flutter/material.dart';
import 'package:recipepicker/state/recipe_model.dart';

class ResultCard extends StatelessWidget {
  final RecipeModel item;
  final bool isFavorite;
  final VoidCallback onFavTap;
  const ResultCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
          height: 120,
          alignment: Alignment.center,
          child: ListTile(
            trailing: IconButton(
              icon: isFavorite
                  ? const Icon(Icons.favorite_outlined)
                  : const Icon(Icons.favorite_border_outlined),
              onPressed: onFavTap,
            ),
            title: Text(
              "${item.title} - ${item.cuisine}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                item.directions.join("\n"),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )),
    );
  }
}
