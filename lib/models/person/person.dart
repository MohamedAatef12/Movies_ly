import 'dart:convert';

class Person {
  int id;
  String biography;
  String birthday;
  String name;
  String placeOfBirth;
  String profilePath;

  Person({
    required this.biography,
    required this.birthday,
    required this.id,
    required this.name,
    required this.placeOfBirth,
    required this.profilePath
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      id: map['id'] as int,
      name: map['name'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      profilePath: map['profile_path'] ?? '',
    );
  }
  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
