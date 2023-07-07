

class Movie {
  final String id;
  final String title;
  final String thumbnail;
  final String rating;

  Movie({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.rating,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      rating: json['rating'] as String,
    );
  }

  static List<Movie> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Movie.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, thumbnail: $thumbnail, rating: $rating}';
  }

}