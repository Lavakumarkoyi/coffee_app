import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/saved_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      buildWhen: (previous, current) {
        return current is LikedImagesCountState;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/wishlist');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 40,
                ),
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      (state is LikedImagesCountState) ? '${state.LikedImagesCount}' : '0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
