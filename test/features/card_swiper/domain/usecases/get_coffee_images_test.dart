import 'package:coffee_app/core/error/failure.dart';
import 'package:coffee_app/features/card_swipe/domain/entities/image_entity.dart';
import 'package:coffee_app/features/card_swipe/domain/usecase/images_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ImagesUsecase getImagesUsecase;
  late MockCoffeeImageRepository mockCoffeeImageRepository;

  setUp(() {
    mockCoffeeImageRepository = MockCoffeeImageRepository();
    getImagesUsecase = ImagesUsecase(mockCoffeeImageRepository);
  });

  setUpAll(() {
    provideDummy<Either<Failure, ImageEntity>>(Left(Failure('Dummy failure', 400)));
  });

  final coffeeImage = ImageEntity(
    file: '',
  );

  test('should get coffeeImage from repository', () async {
    // Arrange

    when(mockCoffeeImageRepository.fetchImages()).thenAnswer(
      (_) async => Right(coffeeImage),
    );

    //Act
    final result = await getImagesUsecase(NoParams());

    //Assert
    expect(result, Right(coffeeImage));
  });

  test('should return Failure when there is an error', () async {
    // Arrange
    when(mockCoffeeImageRepository.fetchImages()).thenAnswer((_) async => Left(Failure("Something went wrong", 500)));

    // Act
    final result = await getImagesUsecase(NoParams());

    // Assert

    expect(result, isA<Left<Failure, ImageEntity>>());
  });
}
