// To parse this JSON data, do
//
//     final gratisMedia = gratisMediaFromJson(jsonString);

import 'dart:convert';

ImageModel imageMediaFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageMediaToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    required this.filename,
    required this.mimeType,
    required this.extension,
    required this.type,
  });

  String filename;
  String mimeType;
  String extension;
  String type;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        filename: json["filename"],
        mimeType: json["mime_type"],
        extension: json["extension"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "mime_type": mimeType,
        "extension": extension,
        "type": type,
      };

}
