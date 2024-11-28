class Cast {
  String name;
  String character;
  String profilePath;
  int id;
  String job;


  Cast(
      {
        required this.name,
        required this.character,
        required this.profilePath,
        required this.id,
        required this.job,

      });

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'] ?? 'Anonymous',
      character: map['character'] ?? 'No character',
      profilePath: map['profile_path'] ?? '',
      id: map['id'] ?? '',
      job: map['job'] ?? '',

    );
  }
}
