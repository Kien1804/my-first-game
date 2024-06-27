import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30); //xóa Blackbar ở 2 bên
  late final CameraComponent cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() async{

    await images.loadAllImages(); //Load all images into cache

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft; // chỉnh màn hình game vào giữa

    addAll([cam,world]);


    return super.onLoad();
  }
}