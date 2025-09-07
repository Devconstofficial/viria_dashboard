class BackgroundVideoModel {
  String videoId = "";
  String thumbnail = "";
  String title = "";
  String link = "";
  String type = "video/mp4";
  String? hlsLink;
  String? audio;
  int? width;
  int? height;
  String? addedBy;

  BackgroundVideoModel.empty();

  BackgroundVideoModel({
    required this.title,
    required this.link,
    this.thumbnail = "",
    this.type = "video/mp4",
    this.hlsLink,
    this.audio,
    this.width,
    this.height,
    this.addedBy,
  });

  BackgroundVideoModel copyWith({
    String? videoId,
    String? thumbnail,
    String? title,
    String? link,
    String? type,
    String? hlsLink,
    String? audio,
    int? width,
    int? height,
    String? addedBy,
  }) {
    return BackgroundVideoModel(
      title: title ?? this.title,
      link: link ?? this.link,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
      hlsLink: hlsLink ?? this.hlsLink,
      audio: audio ?? this.audio,
      width: width ?? this.width,
      height: height ?? this.height,
      addedBy: addedBy ?? this.addedBy,
    )..videoId = videoId ?? this.videoId;
  }

  BackgroundVideoModel.fromJson(Map<String, dynamic> json) {
    videoId = json["_id"] ?? json["id"] ?? videoId;
    thumbnail = json["thumbnail"] ?? thumbnail;
    title = json["title"] ?? title;
    link = json["link"] ?? link;
    type = json["type"] ?? type;
    hlsLink = json["hlsLink"];
    audio = json["audio"];
    width = json["width"];
    height = json["height"];
    addedBy = json["addedBy"]?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": videoId,
      "thumbnail": thumbnail,
      "title": title,
      "link": link,
      "type": type,
      "hlsLink": hlsLink,
      "audio": audio,
      "width": width,
      "height": height,
      "addedBy": addedBy,
    };
  }

  @override
  String toString() {
    return 'BackgroundVideoModel{videoId: $videoId, title: $title, link: $link, type: $type, thumbnail: $thumbnail, hlsLink: $hlsLink, audio: $audio, width: $width, height: $height, addedBy: $addedBy}';
  }
}
