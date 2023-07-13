import 'package:flutter/material.dart';
import 'package:top_100_movies/models/movie.dart';
import 'package:top_100_movies/views/widgets/movie_card.dart';
import '../models/movie.api.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'favorite.dart';

 class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
 }

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritePage(),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Favorite',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Profile',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];

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
    // print(_movies);
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
                      image: _movies[index].image 
                  );
                },
              ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
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
          FlashyTabBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),          
    );
  }
}
