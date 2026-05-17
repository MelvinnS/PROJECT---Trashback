class ArticleModel {
  final String id;
  final String title;
  final String category;
  final String thumbnail;
  final String author;
  final String date;
  final int views;
  final int likesCount;
  final int comments;

  ArticleModel({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.author,
    required this.date,
    required this.views,
    required this.likesCount,
    required this.comments,
  });
}