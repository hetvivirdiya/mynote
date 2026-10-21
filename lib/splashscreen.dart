
import 'dart:async';

import 'package:flutter/material.dart';

import 'mynote.dart';

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNotesSplashScreen(),
    );
  }
}

class MyNotesSplashScreen extends StatefulWidget {
  const MyNotesSplashScreen({super.key});

  @override
  State<MyNotesSplashScreen> createState() =>
      _MyNotesSplashScreenState();
}

class _MyNotesSplashScreenState extends State<MyNotesSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const mynote(),
        ),
      );
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF2EEFF),
              Color(0xFFFCFBFF),
              Color(0xFFEDF4FF),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return Stack(
              alignment: Alignment.topCenter,
              children: [

                Positioned(
                  top: height * 0.045,
                  left: 48,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9E4FF)
                          .withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // MyNotes logo image
                Positioned(
                  top: height * 0.19,
                  child: Image.asset(
                    'assets/img.png',
                    width: 180,
                    height: height * 0.32,
                    fit: BoxFit.contain,
                  ),
                ),

                // Subtitle
                Positioned(
                  top: height * 0.53,
                  child: const Column(
                    children: [
                      Text(
                        'Capture Ideas',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF424253),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Organize Your Thoughts',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF424253),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Animated loading indicator
                Positioned(
                  top: height * 0.762,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 6.28318,
                        child: child,
                      );
                    },
                    child: const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        value: 0.72,
                        backgroundColor: Color(0xFFD5D0FF),
                        valueColor:
                        AlwaysStoppedAnimation<Color>(
                          Color(0xFF5145F5),
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                ),

                // Bottom progress bar
                Positioned(
                  bottom: height * 0.013,
                  child: Container(
                    width: 102,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCD9FA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5945FF),
                            Color(0xFF4338F5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
