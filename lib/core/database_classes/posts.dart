class Posts {
  final String title;
  final String content;
  final String photoUrl;
  static const String photoUrlString = "photo_url";
  static const String contentString = "content";
  static const String titleString = "title";

  Posts({required this.title, required this.content, required this.photoUrl});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        title: json[titleString] ?? "",
        content: json[contentString],
        photoUrl:
            json[photoUrlString] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      titleString: title,
      contentString: content,
      photoUrlString: photoUrl
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Posts &&
        other.content == content &&
        other.title == title &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ photoUrl.hashCode;
}

List<Posts> parsePostsListItems(List<dynamic> jsoned) {
  return jsoned.map<Posts>((item) => Posts.fromJson(item)).toList();
}
