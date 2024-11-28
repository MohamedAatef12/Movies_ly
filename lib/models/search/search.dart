import 'dart:convert';

class Search {
  int id;
  String title;
  String name;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  String firstAirDate;
  String mediaType;
  double voteAverage;
  List<int> genreIds;
  Search({
    required this.id,
    required this.title,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.releaseDate,
    required this.mediaType,
    required this.voteAverage,
    required this.genreIds,
  });


  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      id: map['id'] as int,
      title: map['title'] ?? '',
      name: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      mediaType: map['media_type'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }
  factory Search.fromJson(String source) => Search.fromMap(json.decode(source));
}

