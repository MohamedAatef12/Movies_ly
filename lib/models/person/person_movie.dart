class PersonMovie {
  String backdropPath;
  List<int> genreIds;
  int id;
  String overview;
  String posterPath;
  String releaseDate;
  bool video;
  double voteAverage;
  int voteCount;
  String character;
  String title;
  PersonMovie(
      {
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.overview,
        required this.posterPath,
        required this.releaseDate,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
        required this.character,
        required this.title,
      });

  factory PersonMovie.fromMap(Map<String, dynamic> map) {
    return PersonMovie(
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id'] as int,
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
      character: map['character'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
