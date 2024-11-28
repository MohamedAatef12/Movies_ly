import 'dart:convert';


class Trending {
  int id;
  String title;
  String name;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  String firstAirDate;
  String lastAirDate;
  String mediaType;
  double voteAverage;
  List<int> genreIds;

  Trending({
    required this.id,
    required this.title,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.releaseDate,
    required this.mediaType,
    required this.voteAverage,
    required this.genreIds,


  });


  factory Trending.fromMap(Map<String, dynamic> map) {
    return Trending(
      id: map['id'] as int,
      title: map['title'] ?? '',
      name: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      lastAirDate: map['last_air_date'] ?? '',
      mediaType: map['media_type'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),



    );
  }
  factory Trending.fromJson(String source) => Trending.fromMap(json.decode(source));
}
