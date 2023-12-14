import 'package:bon_appetit/screen/screen_sign.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ScreenSign(),
      ));
    });
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://lottie.host/aa594794-6e6d-4bd9-8e2f-36db8a8ca114/P5pNpqSOOZ.json',
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
