import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double wheelRotationAngle = 360.0;
  bool isSpinning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuint, // You can experiment with different curves
      ),
    )..addListener(() {
      setState(() {
        wheelRotationAngle = _animation.value * 360.0;
      });
    });
  }

  void _spinWheel() {
    if (!isSpinning) {
      setState(() {
        isSpinning = true;
      });

      _animationController.forward(from: 0.0);

      Timer(Duration(seconds: 1), () {
        setState(() {
          isSpinning = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF0A1826), // Set background color to #16202C
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (replace 'assets/logo.png' with your logo asset)
              Image.asset('assets/text.png', width: 300, height: 100),
              SizedBox(height: 20),
              Container(
                width: 450,
                height: 450,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Wheel Image
                    Transform.rotate(
                      angle: wheelRotationAngle * (pi / 180.0),
                      child: Image.asset('assets/wheel.png',
                          width: 350, height: 350),
                    ),
                    // Picker Image
                    Positioned(
                      top: -200, // Adjust the top position as needed
                      child: Image.asset('assets/picker.png',
                          width: 500, height: 500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Image Button
              InkWell(
                onTap: _spinWheel,
                child: Image.asset('assets/btn.png', width: 280, height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
