import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_foresight/data/models/nutrient.dart';
import 'package:food_foresight/data/models/recipe.dart';
import 'package:food_foresight/data/models/recipe_information.dart';

class RecipeRepository {
  final String apiKey;
  final String baseUrl = 'https://api.spoonacular.com/recipes';
  final Dio _dio = Dio();

  RecipeRepository(this.apiKey);

  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      final response = await _dio.get(
          'https://api.spoonacular.com/recipes/autocomplete?apiKey=$apiKey&number=10&query=$query');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } on SocketException catch (_) {
      throw Exception("Socket Exception: Check your internet connection");
    } catch (e) {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> getRandomRecipes() async {
    try {
      final response = await _dio.get(
        'https://api.spoonacular.com/recipes/random?apiKey=$apiKey&number=10',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['recipes'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load random recipes');
      }
    } on SocketException catch (_) {
      throw Exception("Socket Exception: Check your internet connection");
    } catch (e) {
      throw Exception('Failed to load random recipes');
    }
  }

  Future<RecipeInformation> getRecipeInformation(String id) async {
    try {
      final response = await _dio.get(
          'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey');

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        return RecipeInformation.fromJson(data);
      } else {
        throw Exception('Failed to load recipe details:');
      }
    } on SocketException catch (_) {
      throw Exception("Socket Exception: Check your internet connection");
    } catch (e) {
      throw Exception('Failed to load recipe details');
    }
  }

  Future<List<Nutrient>> getRecipeNutrients(String id) async {
    try {
      final response = await _dio.get(
          'https://api.spoonacular.com/recipes/$id/nutritionWidget.json?apiKey=$apiKey');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['nutrients'];
        return data.map((json) => Nutrient.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load nutrients:');
      }
    } on SocketException catch (_) {
      throw Exception("Socket Exception: Check your internet connection");
    } catch (e) {
      throw Exception('Failed to load nutrients $e');
    }
  }
}
