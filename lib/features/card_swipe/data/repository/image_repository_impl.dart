// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffee_app/core/error/exceptions.dart';
import 'package:fpdart/src/either.dart';

import 'package:coffee_app/core/error/failure.dart';
import 'package:coffee_app/features/card_swipe/data/models/images_model.dart';
import 'package:coffee_app/features/card_swipe/data/source/images_data_source.dart';
import 'package:coffee_app/features/card_swipe/domain/repository/image_repository.dart';

class CoffeeImageRepositoryImpl implements CoffeeImageRepository {
  final ImagesRemoteDataSource imagesRemoteDataSource;
  CoffeeImageRepositoryImpl({
    required this.imagesRemoteDataSource,
  });
  @override
  Future<Either<Failure, ImageModel>> fetchImages() async {
    try {
      final ImageModel Image = await imagesRemoteDataSource.fetchImagesFromAPI();
      print("From repository , $Image");
      return right(Image);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
