import 'package:flutter/material.dart';
import 'package:top_100_movies/models/movie.dart';
import 'package:top_100_movies/views/widgets/movie_card.dart';

import '../models/movie.api.dart';

 class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
 }

class _HomePageState extends State<HomePage> {

  List<Movie> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    getMovies();
  }

  Future<void> getMovies() async {
    _movies = await MovieApi.getMovies();
    setState(() {
      _isLoading = false;
    });
    print(_movies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.movie_filter),
          SizedBox(width: 10),
          Text('Top 100 Moviews'),
          ],
        ),
      ),
      body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                      id: _movies[index].id,
                      title: _movies[index].title,
                      rating: _movies[index].rating,
                      thumbnail: _movies[index].thumbnail);
                },
              ));
  }
}
