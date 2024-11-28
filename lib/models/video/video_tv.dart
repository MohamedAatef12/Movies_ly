class VideoTv {
  String id;
  String key;
  String name;
  String site;
  String type;
  int size;
  bool official;

  VideoTv({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    required this.size,
    required this.official ,
  });

  factory VideoTv.fromMap(Map<String, dynamic> map) {
    return VideoTv(
      id: map['id'].toString(),
      key: map['key'] ?? '' ,
      name: map['name'] ?? '',
      site: map['site'] ?? '',
      type: map['type'] ?? '',
      size: map['size'] ?? 0,
      official: map['official'] ?? false,
    );
  }
}