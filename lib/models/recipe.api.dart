import 'dart:convert';
import 'package:top_100_movies/models/recipe.dart';
import 'package:http/http.dart' as http;


// class RecipeApi {
//   static Future<List<Recipe>> getRecipe() async {
//     var uri = Uri.https('imdb-top-100-movies.p.rapidapi.com', '/');

//     final response = await http.get(uri, headers: {
//       "x-rapidapi-key": "9d91a29303msh49cfae3c45707e2p1bfbbdjsn69f349e971e8",
//       "x-rapidapi-host": "imdb-top-100-movies.p.rapidapi.com"
//     });

//     // Map data = jsonDecode(response.body);
//     List<Map<dynamic, dynamic>> data = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body)['items']);
//     List _temp = [];

//     for (var i in data) {
//       _temp.add(i['rank']['title']);
//     }

//     return Recipe.recipesFromSnapshot(_temp);
//   }
// }

class RecipeApi {
  static Future<List<Movie>> getMovies() async {
    var uri = Uri.https('imdb-top-100-movies.p.rapidapi.com', '/');

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "9d91a29303msh49cfae3c45707e2p1bfbbdjsn69f349e971e8",
      "x-rapidapi-host": "imdb-top-100-movies.p.rapidapi.com"
    });

    // Map<dynamic, dynamic> data = jsonDecode(response.body);
    List<dynamic> responseData = jsonDecode(response.body);
    List<Movie> movies = [];
 
    

    for (var i in responseData) {
      movies.add(Movie.fromJson(i));
    }

    return movies;
  }
}


