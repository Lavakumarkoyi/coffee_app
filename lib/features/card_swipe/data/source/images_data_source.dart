import 'dart:convert';

import 'package:coffee_app/core/constants/api_urls.dart';
import 'package:coffee_app/core/error/exceptions.dart';
import 'package:coffee_app/core/network/dio_client.dart';
import 'package:coffee_app/features/card_swipe/data/models/images_model.dart';
import 'package:dio/dio.dart';

abstract interface class ImagesRemoteDataSource {
  Future<ImageModel> fetchImagesFromAPI();
}

class ImagesRemoteDataSourceImpl implements ImagesRemoteDataSource {
  final DioClient dioClient;
  ImagesRemoteDataSourceImpl(this.dioClient);
  @override
  Future<ImageModel> fetchImagesFromAPI() async {
    try {
      final Response response = await dioClient.get(ApiUrls.rootUrl);

      if (response.statusCode == 200) {
        return ImageModel.fromMap(response.data);
      } else {
        throw ServerException('Failed to load Image : ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Failed to fetch images");
    }
  }
}
