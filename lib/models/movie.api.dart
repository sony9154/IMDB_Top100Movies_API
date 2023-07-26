import 'dart:convert';
import 'package:top_100_movies/models/movie.dart';
import 'package:http/http.dart' as http;



class MovieApi {
  static Future<List<Movie>> getMovies() async {
    
    var uri = Uri.https('raw.githubusercontent.com', '/sony9154/top100MovieJSON/main/top100movies.json');
    final response = await http.get(uri, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });

    List<dynamic> responseData = jsonDecode(response.body);
    List<Movie> movies = [];
 
    for (var i in responseData) {
      movies.add(Movie.fromJson(i));
    }

    return movies;
  }
}


