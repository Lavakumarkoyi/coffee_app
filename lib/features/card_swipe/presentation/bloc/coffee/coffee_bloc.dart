import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/internet/internet_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

var client = http.Client();

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final InternetBloc internetBloc;
  StreamSubscription? internetSubscription;

  CoffeeBloc({required this.internetBloc}) : super(CoffeeInitial()) {
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

    // print("Images intial event");

    try {
      List<String> coffeeImages = [];
      int i = 0;

      while (i < Intial_card_count) {
        var response = await client.get(
          Uri.parse('https://coffee.alexflipnote.dev/random.json'),
        );
        var newResponse = jsonDecode(response.body);

        coffeeImages.add(newResponse['file']);

        i = i + 1;
      }

      emit(IntialCoffeeImagesState(CoffeeImages: coffeeImages));
    } catch (e) {
      emit(IntialCoffeeImagesState(CoffeeImages: const []));
    }
  }

  FutureOr<void> fetchCoffeeImage(FetchCoffeeImageEvent event, Emitter emit) async {
    print("fetch called $state");
    if (state is IntialCoffeeImagesState) {
      print("intial coffeeImage state");
      final currentState = state as IntialCoffeeImagesState;

      try {
        var response = await client.get(
          Uri.parse('https://coffee.alexflipnote.dev/random.json'),
        );
        var newResponse = jsonDecode(response.body);

        final updatedCoffeeImages = List<String>.from(currentState.CoffeeImages)..add(newResponse['file']);

        // updatedCoffeeImages.removeAt(0);

        emit(IntialCoffeeImagesState(CoffeeImages: updatedCoffeeImages));
      } catch (e) {
        emit(IntialCoffeeImagesState(CoffeeImages: currentState.CoffeeImages));
      }
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

      print(cachedImages.length);

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
    // if ((state as IntialCoffeeImagesState).CoffeeImages.isNotEmpty) {
    //   emit(IntialCoffeeImagesState(CoffeeImages: (state as IntialCoffeeImagesState).CoffeeImages));
    // }

    emit(NavigateToHomePageState());
  }
}
