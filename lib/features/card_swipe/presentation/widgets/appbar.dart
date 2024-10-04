import 'package:coffee_app/features/card_swipe/presentation/widgets/favorite_icon.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/saved_images.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  const Appbar({super.key, required this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      leading: Center(
        // margin: const EdgeInsets.only(left: 40.0), // Adjust the margin as needed
        child: InkWell(
          onTap: onHomeTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.home,
              size: 40,
              color: Colors.brown,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: const FavoriteIcon(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
