class Movie {
  final String title;
  final String? backDropPath;
  final String? posterPath;

  Movie({required this.title, this.backDropPath, this.posterPath});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      backDropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
    );
  }
}
