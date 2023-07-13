

class Movie {
  final String id;
  final String title;
  final String image;
  final String rating;
  bool isFavorite; // 新增 isFavorite 屬性

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    this.isFavorite = false, // 預設值為 false
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

  static initial() {}
  
  //實現 == 運算符，以便在比較兩個 Movie 物件
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          rating == other.rating &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ rating.hashCode ^ image.hashCode;

}