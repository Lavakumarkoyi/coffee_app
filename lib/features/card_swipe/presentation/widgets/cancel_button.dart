// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffee_app/features/card_swipe/presentation/bloc/button/button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelButton extends StatefulWidget {
  // double buttonSize;
  CancelButton({
    super.key,
    // required this.buttonSize,
  });

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  bool isClicked = false;
  // double buttonSize = 50.0;
  void _onTap(context) {
    BlocProvider.of<CancelButtonBloc>(context).add(ButtonExpandEvent());

    // After 400ms, dispatch the shrink event
    Future.delayed(const Duration(milliseconds: 400), () {
      BlocProvider.of<CancelButtonBloc>(context).add(ButtonShrinkEvent());
      // context.read<ButtonBloc>().add(ButtonShrinkEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelButtonBloc, ButtonState>(
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () => {_onTap(context)},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: state.buttonSize,
              height: state.buttonSize,
              decoration: const BoxDecoration(
                color: Colors.brown,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
