// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'coffee_bloc.dart';

sealed class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class CoffeeImagesIntialEvent extends CoffeeEvent {}

class FetchCoffeeImageEvent extends CoffeeEvent {}

class SaveImageToCacheEvent extends CoffeeEvent {
  int imageIndex;
  SaveImageToCacheEvent({
    required this.imageIndex,
  });
}

class NaviagetToSavedImagesPageEvent extends CoffeeEvent {}

class FetchAllCachedImagesEvent extends CoffeeEvent {}

class FetchCachedImageCountEvent extends CoffeeEvent {}

class NavigateToHomePageEvent extends CoffeeEvent {}
