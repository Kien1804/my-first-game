import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/loginpage.dart';
import 'package:pixel_adventure/welcomepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('images/bakugo.png'),
      title: Text(
        'Pixel Adventure',
        style: TextStyle(
          color: Colors.pink,
          fontFamily: 'ro',
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black54,
      showLoader: true,
      loaderColor: Colors.pink,
      navigator: loginpage(),
      durationInSeconds: 5,
    );
  }
}
