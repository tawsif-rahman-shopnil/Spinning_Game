import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:spinning_game/game_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool showButtons = false;
  String h5Link = "";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(_animationController);

    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      _animationController.stop();
      setState(() {
        showButtons = true;
      });
    });
  }

  Future<void> _loadH5Link() async {
    final String osLanguage = "your_os_language"; // Replace with actual data
    final String deviceID = "your_device_id"; // Replace with actual data
    final String installReferrer = "your_install_referrer"; // Replace with actual data
    print('OS language: $osLanguage');
    print('Device ID: $deviceID'); // Print deviceID for debugging
    print('Install Referrer: $installReferrer');
    final String apiUrl = "https://tac.mdebfx.top/api/init-data";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'os_language': osLanguage,
          'deviceId': deviceID,
          'installReferrer': installReferrer,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];
        final h5Link = data['h5_link'] ?? "";

        if (h5Link.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebViewScreen(h5Link),
            ),
          );
        }
      } else {
        // Handle error
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/text.png',
                width: 300,
                height: 100,
              ),
            ),
          ),
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
          if (showButtons)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: AssetImage('assets/onlnbtn.png'),
                    width: 280,
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        _loadH5Link();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: AssetImage('assets/oflnbtn.png'),
                    width: 250,
                    height: 80,
                    child: InkWell(
                      onTap: () {
                        // Placeholder for navigation to GameScreen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      },
                    ),
                  ),
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


class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
