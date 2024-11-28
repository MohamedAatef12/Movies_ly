class CastTv {
  String name;
  String character;
  String profilePath;
  int creditId;
  String job;

  CastTv(
      {
        required this.name,
        required this.character,
        required this.profilePath,
        required this.creditId,
        required this.job,
      });

  factory CastTv.fromMap(Map<String, dynamic> map) {
    return CastTv(
        name: map['name'] ?? 'Anonymous',
        character: map['character'] ?? 'No character',
        profilePath: map['profile_path'] ?? '',
        creditId: map['id'] as int,
        job: map['job'] ?? '',
    );
  }
}