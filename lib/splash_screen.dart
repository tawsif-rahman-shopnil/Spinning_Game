import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spinning_game/game_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool showButtons = false; // Track whether to show the buttons

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Adjust duration as needed
    );

    _animation = Tween<double>(
      begin: 1.0, // Initial scale of the wheel
      end: 0.5, // Final scale of the wheel
    ).animate(_animationController);

    _animationController.forward(); // Use forward instead of repeat

    Timer(Duration(seconds: 3), () {
      _animationController.stop();
      setState(() {
        showButtons = true; // Set the state to trigger the appearance of buttons
      });
    });

    // Removed the auto-navigation to GameScreen after 7 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo at the top
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/text.png', // Replace with your logo asset
                width: 300,
                height: 100,
              ),
            ),
          ),
          // Animated Wheel Image
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Center(
                child: Transform.scale(
                  scale: _animation.value,
                  child: Transform.rotate(
                    angle: _animationController.value * 6.0,
                    child: Image.asset('assets/wheel.png', width: 800, height: 800),
                  ),
                ),
              );
            },
          ),
          // Buttons
          if (showButtons)
            Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align buttons at the bottom
              children: [
                SizedBox(height: 20), // Add spacing between buttons and wheel
                ElevatedButton(
                  onPressed: () {
                    // Handle the first button press
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Text('Button 1'),
                ),
                SizedBox(height: 10), // Add some additional spacing
                ElevatedButton(
                  onPressed: () {
                    // Handle the second button press
                  },
                  child: Text('Button 2'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
