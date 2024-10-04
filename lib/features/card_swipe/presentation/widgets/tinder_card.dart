// I have tried this tinder_app library here and it worked fine, once I closed the app and start re running I got library errors, for which almost a couple of days were wasted, as I need to start again with a different new package.

// import 'package:flutter/material.dart';
// import 'package:flutter_tindercard_plus/flutter_tindercard_plus.dart';

// class TinderCard extends StatefulWidget {
//   const TinderCard({super.key});

//   @override
//   State<TinderCard> createState() => _TinderCardState();
// }

// class _TinderCardState extends State<TinderCard> with TickerProviderStateMixin {
//   List welcomeImages = [
//     "lib/Assets/images/arthur.png",
//     "lib/Assets/images/cherbas.png",
//     "lib/Assets/images/jhon.png",
//     "lib/Assets/images/klueg.png",
//     "lib/Assets/images/lucy.png"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     CardController cardController;

//     return Container(
//       height: 550, // Adjusted height to prevent overflow
//       width: screenWidth * 0.9, // Relative width
//       child: TinderSwapCard(
//         swipeUp: true,
//         swipeDown: true,
//         orientation: AmassOrientation.top,
//         totalNum: welcomeImages.length,
//         stackNum: 3,
//         swipeEdge: 4.0,
//         maxWidth: screenWidth * 0.9,
//         maxHeight: screenHeight * 0.45, // Reduced height to keep the card in bounds
//         minWidth: screenWidth * 0.85,
//         minHeight: screenHeight * 0.4, // Keep the minimum height relative to the screen
//         cardBuilder: (context, index) => Card(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.asset(welcomeImages[index], fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }
