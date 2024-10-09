import 'package:coffee_app/core/error/failure.dart';
import 'package:coffee_app/features/card_swipe/domain/entities/image_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CoffeeImageRepository {
  Future<Either<Failure, ImageEntity>> fetchImages();
}
