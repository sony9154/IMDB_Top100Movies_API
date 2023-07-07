

class Movie {
  final String id;
  final String title;
  final String image;
  final String rating;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
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
    return 'Movie{id: $id, title: $title, image: $image, rating: $rating}';
  }

}