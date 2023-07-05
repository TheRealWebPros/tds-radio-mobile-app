class Post {
  dynamic id;
  String? logo;
  String? streamUrl;
  dynamic date;

  String? type;
  String? title;
  String? content;
  Embedded? embedded;

  Post({
    required this.id,
    this.date,
    this.type,
    required this.title,
    this.content,
    this.embedded,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      date: DateTime.parse(json['date']),
      embedded: json["_embedded"] == null
          ? null
          : Embedded.fromJson(json["_embedded"]),
    );
  }
}

class Embedded {
  Embedded({
    this.wpFeaturedmedia,
  });

  List<WpFeaturedmedia>? wpFeaturedmedia;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        wpFeaturedmedia: json["wp:featuredmedia"] == null
            ? null
            : List<WpFeaturedmedia>.from(
                json["wp:featuredmedia"].map(
                  (x) => WpFeaturedmedia.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "wp:featuredmedia": wpFeaturedmedia == null
            ? null
            : List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toJson())),
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.sourceUrl,
  });

  String? sourceUrl;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
        sourceUrl: json["source_url"] == null ? null : (json["source_url"]),
      );

  Map<String, dynamic> toJson() => {
        "source_url": sourceUrl == null ? null : (sourceUrl),
      };
}
