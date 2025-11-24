import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lab_mis_2/models/food_model.dart';
import 'dart:convert';
import '../models/category_model.dart';
import '../models/recipe_model.dart';


class ApiService {
  Future<List<CategoryModel>> loadCategories({required int n}) async {
    final response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categoriesJson = data['categories'];

      List<CategoryModel> categories = categoriesJson
        .take(n)
        .map((json) => CategoryModel.fromJson(json))
        .toList();

      return categories;
    }
    return [];
  }

  Future<List<Food>> loadFoodsByCategory({required String category}) async{
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$category")
    );

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];
      List<Food> meals = mealsJson.map((json) => Food.fromJson(json)).toList();
      return meals;
    }
    return [];
  }

  Future<List<Food>> searchFoods({required String query}) async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=$query"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      List<Food> foods = mealsJson
          .map((json) => Food.fromJson(json))
          .toList();

      return foods;
    }
    return [];
  }

  Future<RecipeModel?> getRecipeDetails({required String id}) async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      if (mealsJson.isNotEmpty) {
        return RecipeModel.fromJson(mealsJson[0]);
      }
    }
    return null;
  }

  Future<RecipeModel?> getRandomRecipe() async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      if (mealsJson.isNotEmpty) {
        return RecipeModel.fromJson(mealsJson[0]);
      }
    }
    return null;
  }
}