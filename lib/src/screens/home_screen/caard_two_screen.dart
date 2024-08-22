import 'package:flutter/material.dart';
import 'dart:async';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'package:meditation_app/src/themes/theme.dart';

class CardTwoScreen extends StatefulWidget {
  const CardTwoScreen({Key? key}) : super(key: key);

  @override
  _CardTwoScreenState createState() => _CardTwoScreenState();
}

class _CardTwoScreenState extends State<CardTwoScreen> with SingleTickerProviderStateMixin {
  bool _isTimerRunning = false;
  int _seconds = 0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();  // Start the animation when the page loads

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _startStopTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
      setState(() {
        _isTimerRunning = false;
        _seconds = 0;  // Reset seconds to zero when stopped
      });
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      setState(() {
        _isTimerRunning = true;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String timerText = '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';
    final String message;
    if (_seconds < 10) {
      message = '';
    } else if (_seconds < 30) {
      message = 'You can do better!';
    } else {
      message = 'Hooray, Good to Go!!';
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/backgrounds/yogaa.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          // Content
          SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: AppText.normalText(
                            "WARRIOR I (Virabhadrasana I)",
                            fontSize: 30,
                            isBold: true,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Circular Image
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/meditation_cards/yogaa_2.jpg',
                                width: 180.0,
                                height: 180.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Instructions
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: Text(
                            'Instructions:\n'
                                '1. Start in Mountain Pose: Stand tall with feet hip-width apart and arms at your sides.\n'
                                '2. Step Back: Step your left foot back, keeping your right foot forward and heel aligned with the arch of your left foot.\n'
                                '3. Bend the Front Knee: Bend your right knee to align it with your ankle, keeping it behind your toes.\n'
                                '4. Raise Your Arms: Lift both arms overhead with palms facing each other or touching, and stretch your fingers upward.\n'
                                '5. Align Your Hips: Rotate your left hip forward and right hip back to face forward.\n'
                                '6. Hold and Breathe: Maintain the pose for several breaths, then switch sides.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),

                        const SizedBox(height: 40),
                        AnimatedScale(
                          scale: _isTimerRunning ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            timerText,
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          decoration: BoxDecoration(
                            color: _isTimerRunning ? Colors.redAccent : Colors.greenAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: _startStopTimer,
                            child: Text(_isTimerRunning ? 'Stop' : 'Start'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Use the AnimatedContainer color
                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (_seconds > 0) ...[
                          const SizedBox(height: 20),
                          AnimatedOpacity(
                            opacity: _seconds > 10 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              message,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.orange,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                height: 1.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
