class MachinesMedia {
  final String photoId;
  final String photoName;
  final String photoPath;
  final bool isVideo;
  static const String photoIdString = "media_id";
  static const String photoNameString = "media_name";
  static const String photoPathString = "media_path";
  static const String isVideoString = "is_video";

  MachinesMedia(
      {required this.photoId,
      required this.photoName,
      required this.photoPath,
      required this.isVideo});

  factory MachinesMedia.fromJson(Map<String, dynamic> json) {
    return MachinesMedia(
        photoId: json[photoIdString] ?? "",
        photoName: json[photoNameString] ?? "",
        photoPath: json[photoPathString] ?? "",
        isVideo: json[isVideoString] == "0" ? false : true);
  }

  Map<String, dynamic> toJson() {
    return {
      photoIdString: photoId,
      photoNameString: photoName,
      photoPathString: photoPath,
      isVideoString: isVideo ? "1" : "0"
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MachinesMedia &&
        other.photoId == photoId &&
        other.photoName == photoName &&
        other.photoPath == photoPath &&
        other.isVideo == isVideo;
  }

  @override
  int get hashCode =>
      photoId.hashCode ^
      photoName.hashCode ^
      photoPath.hashCode ^
      isVideo.hashCode;
}

List<MachinesMedia> parseMachinesMediaListItems(List<dynamic> jsoned) {
  return jsoned
      .map<MachinesMedia>((item) => MachinesMedia.fromJson(item))
      .toList();
}
