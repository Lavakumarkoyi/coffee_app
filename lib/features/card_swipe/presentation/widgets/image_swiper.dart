// I have used this swiper package and it also didn't worked properly.

// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';

// class CoffeeSwiper extends StatefulWidget {
//   const CoffeeSwiper({super.key});

//   @override
//   State<CoffeeSwiper> createState() => _CoffeeSwiperState();
// }

// class _CoffeeSwiperState extends State<CoffeeSwiper> {
//   List images = [
//     "lib/Assets/images/arthur.png",
//     "lib/Assets/images/cherbas.png",
//     "lib/Assets/images/jhon.png",
//     "lib/Assets/images/klueg.png",
//     "lib/Assets/images/lucy.png"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Swiper(
//       itemBuilder: (context, index) {
//         final image = images[index];
//         return Image.asset(
//           image,
//           fit: BoxFit.fill,
//         );
//       },
//       indicatorLayout: PageIndicatorLayout.COLOR,
//       autoplay: true,
//       itemCount: images.length,
//       pagination: const SwiperPagination(),
//       control: const SwiperControl(),
//     );
//   }
// }
