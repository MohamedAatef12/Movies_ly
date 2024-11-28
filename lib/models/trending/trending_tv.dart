import 'dart:convert';

class TrendingTv {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
  double voteAverage;
  List<int> genreIds;
  TrendingTv({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.voteAverage,
    required this.genreIds,
  });


  factory TrendingTv.fromMap(Map<String, dynamic> map) {
    return TrendingTv(
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

  factory TrendingTv.fromJson(String source) => TrendingTv.fromMap(json.decode(source));

}
