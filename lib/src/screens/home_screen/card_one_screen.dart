import 'package:flutter/material.dart';
import 'dart:async';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'package:meditation_app/src/themes/theme.dart';

class CardOneScreen extends StatefulWidget {
  const CardOneScreen({Key? key}) : super(key: key);




  //cfvgbnm
  @override
  _CardOneScreenState createState() => _CardOneScreenState();
}

class _CardOneScreenState extends State<CardOneScreen> with SingleTickerProviderStateMixin {
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
      message = 'You can do better!';
    } else {
      message = 'Hooray, Good to Go!!';
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
          SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title with Fade and Slide Animation
                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(_controller),
                          child: AppText.normalText(
                            "PLANK POSE (Phalakasana)",
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
                              'assets/images/meditation_cards/yoga_1.png',
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
                              '1. Start in a push-up position with your arms straight.\n'
                              '2. Ensure your body forms a straight line from head to heels.\n'
                              '3. Keep your core engaged and your hips level.\n'
                              '4. Hold the position for as long as you can.\n'
                              '5. Breathe deeply and maintain the posture.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
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
                            position: Tween<Offset>(
                              begin: Offset(0, 0.1),
                              end: Offset.zero,
                            ).animate(_controller),
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
          ),
        ],
      ),
    );
  }
}
