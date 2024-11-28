import 'dart:convert';

class Tv {
  int id;
  String name;
  String overview;
  String posterPath;
  double voteAverage;
  String firstAirDate;
  String backdropPath;
  List<int> genreIds;

  Tv({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.firstAirDate,
    required this.backdropPath,
    required this.genreIds,
  });
  factory Tv.fromMap(Map<String, dynamic> map) {
    return Tv(
      id: map['id'] as int,
      name: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
      firstAirDate: map['first_air_date'] ?? '',
    );
  }
  factory Tv.fromJson(String source) => Tv.fromMap(json.decode(source));
}
