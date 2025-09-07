class VideoModel {
  String videoId = "";
  String thumbnail = "";
  String link = "";
  String type = "";

  VideoModel.empty();

  VideoModel({
    required this.thumbnail,
    required this.link,
    required this.type,
  });

  VideoModel copyWith({
    String? videoId,
    String? thumbnail,
    String? link,
    String? type,
  }) {
    return VideoModel(
      thumbnail: thumbnail ?? this.thumbnail,
      link: link ?? this.link,
      type: type ?? this.type,
    )..videoId = videoId ?? this.videoId;
  }

  VideoModel.fromJson(Map<String, dynamic> json) {
    videoId = json["_id"] ?? json["id"] ?? videoId;
    thumbnail = json["thumbnail"] ?? thumbnail;
    link = json["link"] ?? link;
    type = json["type"] ?? type;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": videoId,
      "thumbnail": thumbnail,
      "link": link,
      "type": type,
    };
  }

  @override
  String toString() {
    return 'VideoModel{videoId: $videoId, thumbnail: $thumbnail, link: $link, type: $type}';
  }
}
