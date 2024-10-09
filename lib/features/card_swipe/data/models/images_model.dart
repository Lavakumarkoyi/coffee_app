import 'dart:convert';

import 'package:coffee_app/features/card_swipe/domain/entities/image_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageModel extends ImageEntity {
  String file;
  ImageModel({
    required this.file,
  }) : super(file: file);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
