part of 'button_bloc.dart';

sealed class ButtonEvent extends Equatable {
  const ButtonEvent();

  @override
  List<Object> get props => [];
}

class ButtonExpandEvent extends ButtonEvent {}

class ButtonShrinkEvent extends ButtonEvent {}
