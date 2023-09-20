import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:top_100_movies/views/widgets/movie_card.dart';
import 'package:top_100_movies/models/movie.dart';
import 'package:top_100_movies/models/movie.api.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:top_100_movies/views/favoritesPage.dart';
import 'package:top_100_movies/views/home.dart';
import 'package:top_100_movies/views/widgets/movie_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  int _currentIndex = 2;

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
        title: Row(
          children: [
            Icon(Icons.movie_filter),
            SizedBox(width: 10),
            Text('My Top 100 Movies'),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FlutterMap(
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              nonRotatedChildren: [
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
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
            } else if (_currentIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            } else if (_currentIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapsPage()),
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
            icon: Icon(Icons.map),
            title: Text('Maps'),
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
