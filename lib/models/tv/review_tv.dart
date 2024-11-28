class ReviewTv {
  String author;
  String content;
  String createdAt;

  ReviewTv(
      {
        required this.author,
        required this.content,
        required this.createdAt,
      });

  factory ReviewTv.fromMap(Map<String, dynamic> map) {
    return ReviewTv(
      author: map['author'] ?? 'Anonymous',
      content: map['content'] ?? 'No content',
      createdAt: map['created_at'] ?? '',
    );
  }
}