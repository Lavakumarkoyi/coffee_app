import 'package:coffee_app/core/error/failure.dart';
import 'package:coffee_app/core/usecase/usecase.dart';
import 'package:coffee_app/features/card_swipe/domain/entities/image_entity.dart';
import 'package:coffee_app/features/card_swipe/domain/repository/image_repository.dart';
import 'package:fpdart/src/either.dart';

class ImagesUsecase implements UseCase<ImageEntity, NoParams> {
  final CoffeeImageRepository coffeeImageRepository;
  const ImagesUsecase(this.coffeeImageRepository);
  @override
  Future<Either<Failure, ImageEntity>> call(NoParams params) async {
    // TODO: implement call
    return await coffeeImageRepository.fetchImages();
  }
}

class NoParams {}
