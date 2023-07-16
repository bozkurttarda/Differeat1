import 'dart:math';

import 'package:recipepicker/contanst.dart';

String getCuisine(String title) {
  for (var element in cuisines) {
    final listOfMeals = cuisineTitleMap[element] ?? [];

    for (var meal in listOfMeals) {
      if (title.toLowerCase().contains(meal)) return element;
    }
  }
  // Create an instance of Random class
  var random = Random();

  // Generate a random integer within a range
  int max = cuisines.length;
  int randomNumber = random.nextInt(max);

  return cuisines.elementAt(randomNumber);
}
