import 'package:lab_mis_2/models/Ingredient.dart';

class RecipeModel {
  String id;
  String name;
  String category;
  String area;
  String instructions;
  String img;
  String? youtubeUrl;
  List<Ingredient> ingredients;

  RecipeModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.img,
    this.youtubeUrl,
    required this.ingredients,
  });

  RecipeModel.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        name = data['strMeal'],
        category = data['strCategory'] ?? '',
        area = data['strArea'] ?? '',
        instructions = data['strInstructions'] ?? '',
        img = data['strMealThumb'] ?? '',
        youtubeUrl = data['strYoutube'],
        ingredients = _parseIngredients(data);

  static List<Ingredient> _parseIngredients(Map<String, dynamic> data) {
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = data['strIngredient$i'];
      String? measure = data['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty && ingredient.trim().isNotEmpty) {
        ingredients.add(Ingredient(
          name: ingredient,
          measure: measure ?? '',
        ));
      }
    }
    return ingredients;
  }
}