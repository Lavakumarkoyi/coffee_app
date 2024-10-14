import 'package:coffee_app/core/network/dio_client.dart';
import 'package:coffee_app/features/card_swipe/data/repository/image_repository_impl.dart';
import 'package:coffee_app/features/card_swipe/data/source/images_data_source.dart';
import 'package:coffee_app/features/card_swipe/domain/repository/image_repository.dart';
import 'package:coffee_app/features/card_swipe/domain/usecase/images_usecase.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  initCoffeeImages();
  serviceLocator.registerLazySingleton<DioClient>(() => DioClient());
}

void initCoffeeImages() {
  serviceLocator.registerFactory<ImagesRemoteDataSource>(
    () => ImagesRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<CoffeeImageRepository>(
    () => CoffeeImageRepositoryImpl(
      imagesRemoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ImagesUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => CoffeeBloc(
      coffeeImages: serviceLocator(),
    ),
  );
}
