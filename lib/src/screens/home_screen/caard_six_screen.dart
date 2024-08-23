import 'package:flutter/material.dart';
import 'dart:async';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'package:meditation_app/src/themes/theme.dart';

class CardSixScreen extends StatefulWidget {
  const CardSixScreen({Key? key}) : super(key: key);

  @override
  _CardSixScreenState createState() => _CardSixScreenState();
}

class _CardSixScreenState extends State<CardSixScreen> with SingleTickerProviderStateMixin {
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
    )..forward(); // Start the animation when the page loads

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero).animate(
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
        _seconds = 0; // Reset seconds to zero when stopped
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
      message = 'Great Job!';
    } else {
      message = 'Excellent Work!!';
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Fade Animation
          FadeTransition(
            opacity: _opacityAnimation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgrounds/yogaa.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title with Fade and Slide Animation
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: AppText.normalText(
                          "BRIDGE POSE (Setu Bandhasana)",
                          fontSize: 30,
                          isBold: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Circular Image with Scale and Fade Animation
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/meditation_cards/yoga_6.webp',
                            width: 180.0,
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Instructions with Fade Animation
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: Text(
                        'Instructions:\n'
                            '1. Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\n'
                            '2. Place your arms at your sides with palms facing down.\n'
                            '3. Press your feet and arms into the floor as you lift your hips towards the ceiling.\n'
                            '4. Keep your thighs and feet parallel as you engage your glutes and core.\n'
                            '5. Hold the position for several breaths, then slowly lower your hips back to the floor.\n'
                            '6. Repeat as desired, focusing on the lift and contraction of your hips and core.',
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
                    // Timer Text with Scale and Fade Animation
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: Text(
                          timerText,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Start/Stop Button with AnimatedContainer
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
                      // Message with Fade and Slide Animation
                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
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
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
