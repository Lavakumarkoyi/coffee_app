import 'package:coffee_app/core/network/dio_client.dart';
import 'package:coffee_app/features/card_swipe/data/source/images_data_source.dart';
import 'package:coffee_app/features/card_swipe/domain/repository/image_repository.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([
  CoffeeImageRepository,
  ImagesRemoteDataSource
], customMocks: [
  MockSpec<DioClient>(as: #MockDioClient),
])
void main() {}
