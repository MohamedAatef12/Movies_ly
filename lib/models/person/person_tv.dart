class PersonTv{
  String backdropPath;
  List<int> genreIds;
  int id;
  String overview;
  String posterPath;
  bool video;
  double voteAverage;
  String character;
  String creditId;
  String mediaType;
  String firstAirDate;
  String name;
  int episodeCount;

  PersonTv(
      {
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.overview,
        required this.posterPath,
        required this.video,
        required this.voteAverage,
        required this.character,
        required this.creditId,
        required this.mediaType,
        required this.firstAirDate,
        required this.name,
        required this.episodeCount,
      });

  factory PersonTv.fromMap(Map<String, dynamic> map) {
    return PersonTv(
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id'] as int,
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      character: map['character'] ?? '',
      creditId: map['credit_id'] ?? '',
      mediaType: map['media_type'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      name: map['name'] ?? '',
      episodeCount: map['episode_count'] ?? 0,

    );
  }
}
