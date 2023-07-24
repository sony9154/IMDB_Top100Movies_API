import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_100_movies/models/movie.dart';
import 'package:top_100_movies/views/favoritesPage.dart';


 
class MovieCard extends StatefulWidget {

  final String id;
  final String title;
  final String image;
  final String rating;

  const MovieCard({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();

}

class _MovieCardState extends State<MovieCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyMovieState>();
    var pair = appState.current;
      IconData icon;
      icon = Icons.favorite;
      if (appState.favorites.contains(pair)) {
          icon = Icons.favorite;
      } 
      else {
          icon = Icons.favorite_border;
      }
   
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(widget.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  context.read<MyFavState>().toggleFavorite(Movie(id: widget.id, title: widget.title, rating: widget.rating, image: widget.image));
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.0),
                ),
                icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
                ),
                label: Text('Like'),
              ),
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.id,
                style: TextStyle(
                  fontSize: 19,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(widget.title),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(widget.rating),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}




class MyFavState extends ChangeNotifier {
  var current = Movie.initial();
  var history = <Movie>[];

  GlobalKey? historyListKey;

  var favorites = <Movie>[];

  void toggleFavorite(Movie? pair) {
    if (pair != null) {
      if (favorites.contains(pair)) {
        favorites.remove(pair);
        pair.isFavorite = false;
      } else {
        favorites.add(pair);
        pair.isFavorite = true;
      }
      current = pair;
      notifyListeners();
    }
  }

  void removeFavorite(Movie movie) {
    favorites.remove(movie);
    notifyListeners();
  }
  
}