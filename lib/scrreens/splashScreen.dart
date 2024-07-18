import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                Assets.splashIcon,
                height: 300, // Adjust the height as needed
              ),
            ),
            Text(
              "Flappy Bird",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Game',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "BY DIVYANSHU,NITIN,ARCHIT,DEEPAK",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Game',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      nextScreen: MyGame(),
      splashIconSize: 400,
      backgroundColor: Color(0xFFFFCC80),
    );
  }
}
