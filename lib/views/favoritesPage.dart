import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:top_100_movies/views/home.dart';
import 'package:provider/provider.dart';
import 'package:top_100_movies/models/movie.dart';
import 'package:top_100_movies/views/widgets/movie_card.dart';


class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyMovieState>();
    var appState = context.watch<MyFavState>();
    

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.movie_filter),
            SizedBox(width: 10),
            Text('My favorites Movies'),
          ],
        ),
      ),
      body: 
      ListView.builder(
        itemCount: appState.favorites.length,
        itemBuilder: (context, index) {
          var movie = appState.favorites[index];
          return ListTile(
            leading: Image.network(movie.image),
            title: Text(movie.title),
            subtitle: Text(movie.rating),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                appState.removeFavorite(movie);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (_currentIndex == 2) {
              Navigator.pushNamed(context, '/maps');
            } else if (_currentIndex == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          });
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
          // FlashyTabBarItem(
          //   icon: Icon(Icons.map),
          //   title: Text('Map'),
          // ),
          FlashyTabBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}

class MyMovieState extends ChangeNotifier {
  // var current = Movie.initial();
  // var history = <Movie>[];

  // GlobalKey? historyListKey;

  // var favorites = <Movie>[];

  // void removeFavorite(Movie movie) {
  //   favorites.remove(movie);
  //   notifyListeners();
  // }
  var current = Movie.initial();
  List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  void addFavorite(Movie movie) {
    _favorites.add(movie);
    notifyListeners();
  }

  void removeFavorite(Movie movie) {
    _favorites.remove(movie);
    notifyListeners();
  }

}