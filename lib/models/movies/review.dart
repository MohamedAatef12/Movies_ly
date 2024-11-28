class Review {
  String author;
  String content;
  String createdAt;

  Review(
      {
        required this.author,
        required this.content,
        required this.createdAt,
      });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'] ?? 'Anonymous',
      content: map['content'] ?? 'No content',
      createdAt: map['created_at'] ?? '',
    );
  }
}