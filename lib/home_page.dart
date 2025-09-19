import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning, Akshay 👋";
    } else if (hour < 17) {
      return "Good Afternoon, Akshay 👋";
    } else if (hour < 20) {
      return "Good Evening, Akshay 👋";
    } else {
      return "Good Night, Akshay 🌙";
    }
  }

  String _getBackgroundImage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "lib/assets/images/morning.png";
    } else if (hour < 17) {
      return "lib/assets/images/afternoon.png";
    } else if (hour < 20) {
      return "lib/assets/images/evening.png";
    } else {
      return "lib/assets/images/night.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();
    final bgImage = _getBackgroundImage();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bgImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
