import 'package:flutter/material.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash.png",
                width: Sizes.size100 + Sizes.size80,
                height: Sizes.size100 + Sizes.size80,
              ),
              Gaps.v32,
              const Text(
                "아카이브노트",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
