import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double wheelRotationAngle = 0.0;
  double pickerRotationAngle = 0.0;

  void _spinWheel() {
    setState(() {
      // Rotate the wheel by a random angle
      wheelRotationAngle = wheelRotationAngle + 45.0;
      // Keep the picker stationary
      pickerRotationAngle = pickerRotationAngle - 45.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Wheel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 450,
              height: 450,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Picker Image
                  Transform.rotate(
                    angle: pickerRotationAngle * (3.14 / 180), // Convert to radians
                    child: Image.asset('assets/picker.png', width: 20, height: 20),
                  ),
                  // Wheel Image
                  Transform.rotate(
                    angle: wheelRotationAngle * (3.14 / 180), // Convert to radians
                    child: Image.asset('assets/wheel.png'), // Replace with your wheel image asset
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('Spin the Wheel'),
            ),
          ],
        ),
      ),
    );
  }
}
