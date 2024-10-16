import 'dart:convert';

import 'package:coffee_app/core/constants/api_urls.dart';
import 'package:coffee_app/core/error/exceptions.dart';
import 'package:coffee_app/features/card_swipe/data/models/images_model.dart';
import 'package:coffee_app/features/card_swipe/data/source/images_data_source.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDioClient mockDioClient;
  late ImagesRemoteDataSourceImpl imagesRemoteDataSourceImpl;

  setUp(() {
    mockDioClient = MockDioClient();
    imagesRemoteDataSourceImpl = ImagesRemoteDataSourceImpl(mockDioClient);
  });

  group('get coffee Images', () {
    const tUrl = '/random.json';
    test('success response on getting coffeeImages', () async {
      final responseData = readJson('helpers/dummy_data/dummy_image_json.json');

      final response = Response(
        data: json.decode(responseData),
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiUrls.rootUrl),
      );

      when(mockDioClient.get(
        tUrl,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => response);

      final result = await imagesRemoteDataSourceImpl.fetchImagesFromAPI();
      // print("Result .. $result");

      // Assert
      expect(result, isA<ImageModel>());
    });

    test('should raise server Exception when we got error from server', () {
      when(mockDioClient.get(
        tUrl,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: tUrl),
        error: 'Something went wrong',
        type: DioExceptionType.unknown,
      ));

      // Act & Assert
      final result = imagesRemoteDataSourceImpl.fetchImagesFromAPI();

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
