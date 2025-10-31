class NewsModel {
  String? author;
  String? title;
  String? description;
  String? newsImageUrl;
  String? publishDate;
  String? content;

  NewsModel({
    this.author,
    this.title,
    this.description,
    this.newsImageUrl,
    this.publishDate,
    this.content,
  });

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      newsImageUrl:
          map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishDate:
          map['publishedAt'] != null ? map['publishedAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }
}
