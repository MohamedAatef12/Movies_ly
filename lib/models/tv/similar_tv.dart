import 'dart:convert';

class SimilarTv {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
  double voteAverage;
  List<int> genreIds;


  SimilarTv({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.voteAverage,
    required this.genreIds,

  });

  factory SimilarTv.fromMap(Map<String, dynamic> map) {
    return SimilarTv(
      id: map['id'] as int,
      title: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),

    );
  }

  factory SimilarTv.fromJson(String source) => SimilarTv.fromMap(json.decode(source));
}