import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/card_swipe/domain/usecase/images_usecase.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/internet/internet_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

var client = http.Client();

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final ImagesUsecase _coffeeImages;
  CoffeeBloc({required ImagesUsecase coffeeImages})
      : _coffeeImages = coffeeImages,
        super(CoffeeInitial()) {
    on<CoffeeImagesIntialEvent>(coffeeImagesIntialEvent);
    on<FetchCoffeeImageEvent>(fetchCoffeeImage);
    on<SaveImageToCacheEvent>(saveImageToCache);
    on<FetchAllCachedImagesEvent>(fetchAllLocalImages);
    on<FetchCachedImageCountEvent>(fetchCachedImageCount);
    on<NaviagetToSavedImagesPageEvent>(naviagetToSavedImagesPage);
    on<NavigateToHomePageEvent>(navigateToHomePage);
  }

  Future<List<String>> fetchCachedImages() async {
    final prefs = await SharedPreferences.getInstance();

    String? cachedImagesJson = prefs.getString('cachedImages');
    List<String> cachedImages = [];

    if (cachedImagesJson != null) {
      cachedImages = List<String>.from(jsonDecode(cachedImagesJson));
    }

    return cachedImages;
  }

  FutureOr<void> coffeeImagesIntialEvent(CoffeeImagesIntialEvent event, Emitter emit) async {
    emit(CoffeeLoadingState(CoffeeImages: const []));

    int Intial_card_count = 3;

    final List<String> imageUrls = [];

    for (int i = 0; i < Intial_card_count; i++) {
      final res = await _coffeeImages(NoParams());

      res.fold((left) => emit(ErrorState(left.message)), (right) => imageUrls.add(right.file));
    }

    emit(IntialCoffeeImagesState(CoffeeImages: imageUrls));
  }

  FutureOr<void> fetchCoffeeImage(FetchCoffeeImageEvent event, Emitter emit) async {
    if (state is IntialCoffeeImagesState) {
      final currentState = state as IntialCoffeeImagesState;

      final res = await _coffeeImages(NoParams());

      res.fold(
          (left) => emit(ErrorState(left.message)),
          (right) => emit(
              IntialCoffeeImagesState(CoffeeImages: List<String>.from(currentState.CoffeeImages)..add(right.file))));
    }
  }

  FutureOr<void> saveImageToCache(SaveImageToCacheEvent event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();

    if (state is IntialCoffeeImagesState) {
      final currentState = state as IntialCoffeeImagesState;

      List coffeeImages = currentState.CoffeeImages;

      String imageUrl = coffeeImages[event.imageIndex];

      List<String> cachedImages = await fetchCachedImages();

      if (!cachedImages.contains(imageUrl)) {
        cachedImages.add(imageUrl);
      }

      await prefs.setString('cachedImages', jsonEncode(cachedImages));

      cachedImages = await fetchCachedImages();

      emit(LikedImagesCountState(LikedImagesCount: cachedImages.length));
    }
  }

  FutureOr<void> fetchAllLocalImages(FetchAllCachedImagesEvent event, Emitter emit) async {
    List<String> cachedImages = await fetchCachedImages();

    emit(FetchImagesFromCache(cachedImages: cachedImages));
  }

  FutureOr<void> fetchCachedImageCount(FetchCachedImageCountEvent event, Emitter emit) async {
    List<String> cachedImages = await fetchCachedImages();

    emit(LikedImagesCountState(LikedImagesCount: cachedImages.length));
  }

  FutureOr<void> naviagetToSavedImagesPage(NaviagetToSavedImagesPageEvent event, Emitter emit) async {
    if ((state as FetchImagesFromCache).cachedImages.isNotEmpty) {
      emit(FetchImagesFromCache(cachedImages: (state as FetchImagesFromCache).cachedImages));
    }
  }

  FutureOr<void> navigateToHomePage(NavigateToHomePageEvent event, Emitter emit) async {
    emit(NavigateToHomePageState());
  }
}
