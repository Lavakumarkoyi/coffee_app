import 'dart:convert';
import 'dart:math';

import 'package:coffee_app/features/card_swipe/data/models/images_model.dart';
import 'package:coffee_app/features/card_swipe/domain/entities/image_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  late ImageModel testImageModel;
  setUp(() {
    testImageModel = ImageModel(
      file: "https://coffee.alexflipnote.dev/vsoditRhTkY_coffee.jpg",
    );
  });
  test('Image Model is subclass of entity', () {
    expect(testImageModel, isA<ImageEntity>());
  });

  test('return valid dart model from json', () async {
    final Map<String, dynamic> ImageMap = json.decode(readJson('helpers/dummy_data/dummy_image_json.json'));

    final result = ImageModel.fromMap(ImageMap);

    expect(result, equals(testImageModel));
  });
}
