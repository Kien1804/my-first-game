// import 'dart:async';
//
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flame/input.dart';
// import 'package:flutter/painting.dart';
// import 'components/jump_button.dart';
// import 'package:pixel_adventure/components/level.dart';
// import 'package:pixel_adventure/components/player.dart';
// import 'the_end.dart';
// import 'package:flutter/material.dart';
//
// class PixelAdventure extends FlameGame
//     with
//         HasKeyboardHandlerComponents,
//         DragCallbacks,
//         HasCollisionDetection,
//         TapCallbacks {
//
//
//   @override
//   Color backgroundColor() => const Color(0xFF211F30);
//
//   late CameraComponent cam;
//   Player player = Player(character: 'Mask Dude');
//   late JoystickComponent joystick;
//   bool showControls = true;
//   bool playSounds = true;
//   double soundVolume = 1.0;
//   List<String> levelNames = ['Level-01', 'Level-02'];
//   int currentLevelIndex = 0;
//
//   @override
//   FutureOr<void> onLoad() async {
//     await images.loadAllImages();
//     _loadLevel();
//
//     if (showControls) {
//       addJoystick();
//       addJumpButton();
//     }
//
//     return super.onLoad();
//   }
//
//   @override
//   void update(double dt) {
//     if (showControls) {
//       updateJoystick();
//     }
//     super.update(dt);
//   }
//
//   void addJoystick() {
//     joystick = JoystickComponent(
//       priority: 999999999999999998,
//       knob: SpriteComponent(
//         sprite: Sprite(
//           images.fromCache('HUD/Knob.png'),
//         ),
//       ),
//       background: SpriteComponent(
//         sprite: Sprite(
//           images.fromCache('HUD/Joystick.png'),
//         ),
//       ),
//       margin: const EdgeInsets.only(left: 32, bottom: 32),
//     );
//
//     add(joystick);
//   }
//
//   void addJumpButton() {
//     JumpButton jumpButton = JumpButton()
//       ..priority = 999999999999999999; // Đặt priority cao hơn joystick
//
//     add(jumpButton);
//   }
//
//   void updateJoystick() {
//     switch (joystick.direction) {
//       case JoystickDirection.left:
//       case JoystickDirection.upLeft:
//       case JoystickDirection.downLeft:
//         player.horizontalMovement = -1;
//         break;
//       case JoystickDirection.right:
//       case JoystickDirection.upRight:
//       case JoystickDirection.downRight:
//         player.horizontalMovement = 1;
//         break;
//       default:
//         player.horizontalMovement = 0;
//         break;
//     }
//   }
//
//   void loadNextLevel() {
//     if (currentLevelIndex < levelNames.length - 1) {
//       currentLevelIndex++;
//     } else {
//       // Không còn level nào nữa, quay lại level đầu tiên
//       // currentLevelIndex = 0;
//       // Không còn level nào nữa chuyển đến trang theend
//       _navigateToTheEndScreen();
//       return;
//     }
//
//     _clearCurrentLevel(); // Xóa các đối tượng cũ
//     _loadLevel(); // Tải cấp độ mới
//   }
//
//   void _clearCurrentLevel() {
//     // Xóa tất cả các thành phần hiện tại trong game
//     children.where((c) => c is Level || c is CameraComponent).forEach((c) {
//       remove(c);
//     });
//   }
//
//   void _loadLevel() {
//     Future.delayed(
//       const Duration(seconds: 1),
//           () {
//         Level world = Level(
//           player: player,
//           levelName: levelNames[currentLevelIndex],
//         );
//
//         // Tạo camera mới
//         cam = CameraComponent.withFixedResolution(
//           world: world,
//           width: 640,
//           height: 360,
//         );
//         cam.viewfinder.anchor = Anchor.topLeft;
//
//         // Thêm camera và level mới vào trò chơi
//         addAll([cam, world]);
//       },
//     );
//   }
// }

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart'; // Đảm bảo bạn đã thêm import này
import 'components/jump_button.dart';
import 'package:pixel_adventure/components/level.dart';
import 'package:pixel_adventure/components/player.dart';
import 'the_end.dart'; // Đảm bảo bạn đã import màn hình "The End"

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  final GlobalKey<NavigatorState>
      navigatorKey; // Thay BuildContext bằng GlobalKey

  PixelAdventure(this.navigatorKey); // Nhận GlobalKey từ constructor

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = true;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level-01', 'Level-02', 'Level-03'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    _loadLevel();

    if (showControls) {
      addJoystick();
      addJumpButton();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 999999999999999998,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void addJumpButton() {
    JumpButton jumpButton = JumpButton()
      ..priority = 999999999999999999; // Đặt priority cao hơn joystick

    add(jumpButton);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
    } else {
      // Không còn level nào nữa, điều hướng đến màn hình "The End"
      _navigateToTheEndScreen();
      return;
    }

    _clearCurrentLevel(); // Xóa các đối tượng cũ
    _loadLevel(); // Tải cấp độ mới
  }

  void _clearCurrentLevel() {
    // Xóa tất cả các thành phần hiện tại trong game
    children.where((c) => c is Level || c is CameraComponent).forEach((c) {
      remove(c);
    });
  }

  void _loadLevel() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Level world = Level(
          player: player,
          levelName: levelNames[currentLevelIndex],
        );

        // Tạo camera mới
        cam = CameraComponent.withFixedResolution(
          world: world,
          width: 640,
          height: 360,
        );
        cam.viewfinder.anchor = Anchor.topLeft;

        // Thêm camera và level mới vào trò chơi
        addAll([cam, world]);
      },
    );
  }

  void _navigateToTheEndScreen() {
    // Sử dụng GlobalKey Navigator để điều hướng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => TheEndScreen()),
      );
    });
  }
}
