part of 'coffee_bloc.dart';

sealed class CoffeeState {}

final class CoffeeInitial extends CoffeeState {}

final class CoffeeLoadingState extends CoffeeState {
  List CoffeeImages = [];

  CoffeeLoadingState({required this.CoffeeImages});
}

final class IntialCoffeeImagesState extends CoffeeState {
  List<String> CoffeeImages = [];

  IntialCoffeeImagesState({required this.CoffeeImages});
}

final class SavedImagetoCache extends CoffeeState {}

final class FetchImagesFromCache extends CoffeeState {
  List<String> cachedImages = [];

  FetchImagesFromCache({required this.cachedImages});
}

final class LikedImagesCountState extends CoffeeState {
  int LikedImagesCount = 0;

  LikedImagesCountState({required this.LikedImagesCount});
}

final class NavigateToHomePageState extends CoffeeState {}
