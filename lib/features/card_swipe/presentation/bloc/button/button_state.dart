part of 'button_bloc.dart';

abstract class ButtonState {
  final double buttonSize;

  ButtonState(this.buttonSize);
}

class ButtonInitialState extends ButtonState {
  ButtonInitialState() : super(50.0);
}

class ButtonExpandedState extends ButtonState {
  ButtonExpandedState() : super(80.0);
}

class ButtonShrinkState extends ButtonState {
  ButtonShrinkState() : super(50.0);
}
