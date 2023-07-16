// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RecipeModel {
  final String title;
  final List<String> ingredients;
  final List<String> directions;
  final String link;
  final String source;
  final List<String> ner;
  final String cuisine;

  RecipeModel(
    this.title,
    this.ingredients,
    this.directions,
    this.link,
    this.source,
    this.ner,
    this.cuisine,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'ingredients': ingredients,
      'directions': directions,
      'link': link,
      'source': source,
      'cuisine': cuisine,
      'NER': ner,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      map['title'] as String,
      List<String>.from((map['ingredients'])),
      List<String>.from((map['directions'])),
      map['link'] as String,
      map['source'] as String,
      List<String>.from((map['NER'])),
      map['cuisine'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) =>
      RecipeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant RecipeModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.directions, directions) &&
        other.link == link &&
        other.source == source &&
        other.cuisine == cuisine &&
        listEquals(other.ner, ner);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        ingredients.hashCode ^
        directions.hashCode ^
        link.hashCode ^
        source.hashCode ^
        cuisine.hashCode ^
        ner.hashCode;
  }
}
