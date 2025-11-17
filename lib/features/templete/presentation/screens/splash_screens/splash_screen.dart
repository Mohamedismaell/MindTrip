import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2, milliseconds: 500),
      () {
        if (mounted) {
          context.go('/sp1');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //! Back Ground
          Opacity(
            opacity: .12,
            child: Image.asset(
              'assets/images/on_boarding/Pattern.jpg',

              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/on_boarding/high_quality_logo.png',
                // width: 236,
                height: 236,
              ),
              Lottie.asset(
                'assets/images/animation/Loading.json',
                height: 130,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
