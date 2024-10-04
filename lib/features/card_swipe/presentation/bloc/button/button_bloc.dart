import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonInitialState()) {
    on<ButtonExpandEvent>(buttonExpanded);
    on<ButtonShrinkEvent>(buttonShrink);
  }

  void buttonExpanded(ButtonExpandEvent event, Emitter emit) {
    emit(ButtonExpandedState());
  }

  void buttonShrink(ButtonShrinkEvent event, Emitter emit) {
    emit(ButtonShrinkState());
  }
}

class HeartButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  HeartButtonBloc() : super(ButtonInitialState()) {
    on<ButtonExpandEvent>((event, emit) {
      emit(ButtonExpandedState());
    });

    on<ButtonShrinkEvent>((event, emit) {
      emit(ButtonShrinkState());
    });
  }
}

class CancelButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  CancelButtonBloc() : super(ButtonInitialState()) {
    on<ButtonExpandEvent>((event, emit) {
      emit(ButtonExpandedState());
    });

    on<ButtonShrinkEvent>((event, emit) {
      emit(ButtonShrinkState());
    });
  }
}
