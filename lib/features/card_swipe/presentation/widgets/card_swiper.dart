import 'package:coffee_app/features/card_swipe/presentation/bloc/button/button_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class CoffeeSwiper extends StatefulWidget {
  const CoffeeSwiper({
    super.key,
  });

  @override
  State<CoffeeSwiper> createState() => _CoffeeSwiperState();
}

class _CoffeeSwiperState extends State<CoffeeSwiper> {
  final List<String> images = [
    "lib/Assets/images/arthur.png",
    "lib/Assets/images/cherbas.png",
    "lib/Assets/images/klueg.png",
    "lib/Assets/images/jhon.png",
    "lib/Assets/images/lucy.png"
  ];

  double _previousSwipeDirection = 0;
  String _swipeState = "center";

  final double threshold = 0.3;
  bool _isSwiping = false;

  bool onSwipe(CardSwiperDirection direction, BuildContext context, int previousIndex) {
    BlocProvider.of<CoffeeBloc>(context).add(FetchCoffeeImageEvent());
    if (direction == CardSwiperDirection.right) {
      BlocProvider.of<CoffeeBloc>(context).add(SaveImageToCacheEvent(imageIndex: previousIndex));
      BlocProvider.of<HeartButtonBloc>(context).add(ButtonExpandEvent());

      Future.delayed(const Duration(milliseconds: 400), () {
        BlocProvider.of<HeartButtonBloc>(context).add(ButtonShrinkEvent());
      });
    } else if (direction == CardSwiperDirection.left) {
      BlocProvider.of<CancelButtonBloc>(context).add(ButtonExpandEvent());

      Future.delayed(const Duration(milliseconds: 400), () {
        BlocProvider.of<CancelButtonBloc>(context).add(ButtonShrinkEvent());
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<CoffeeBloc, CoffeeState>(
      buildWhen: (previous, current) {
        return current is IntialCoffeeImagesState || current is CoffeeLoadingState;
      },
      builder: (context, state) {
        if (state is IntialCoffeeImagesState) {
          return LayoutBuilder(builder: (context, constraints) {
            double cardSize = constraints.maxHeight * 0.7;
            // cardSize = cardSize > 400 ? 400 : cardSize;
            cardSize = cardSize.clamp(200.0, 400.0);
            return SizedBox(
              height: cardSize,
              width: cardSize,
              child: CardSwiper(
                cardsCount: state.CoffeeImages.length,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      state.CoffeeImages[index],
                      fit: BoxFit.cover,
                      // height: cardSize,
                      // width: cardSize,
                    ),
                  );
                },
                isLoop: false,
                maxAngle: 120,
                scale: 0.9,
                numberOfCardsDisplayed: 3,
                allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                duration: const Duration(milliseconds: 500),
                backCardOffset: const Offset(0, -50),
                // padding: EdgeInsets.symmetric(
                //   vertical: constraints.maxHeight * 0.1,
                //   horizontal: constraints.maxWidth * 0.05,
                // ),
                onSwipe: (previousIndex, currentIndex, direction) {
                  return onSwipe(direction, context, previousIndex);
                },
              ),
            );
          });
          // print("${state.CoffeeImages}, $state");
          // return
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
