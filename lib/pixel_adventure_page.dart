// import 'package:flutter/material.dart';
// import 'package:flame/game.dart';
// import 'package:pixel_adventure/pixel_adventure.dart';
//
// class PixelAdventurePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GameWidget(
//         game: PixelAdventure(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class PixelAdventurePage extends StatelessWidget {
  // Tạo GlobalKey cho Navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => GameWidget(
              game: PixelAdventure(
                  navigatorKey), // Truyền GlobalKey vào PixelAdventure
            ),
          );
        },
      ),
    );
  }
}
