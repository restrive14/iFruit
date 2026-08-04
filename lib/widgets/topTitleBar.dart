import 'package:flutter/material.dart';

class TopTitleBar extends StatelessWidget {
  final String title;

  const TopTitleBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.5, 0.5, 1],
          colors: const [
            Color(0xFF077707),
            Color(0xFF077707),
            Color(0xFF004400),
            Color(0xFF004400),
          ],
        ),
      ),
      child: Center(
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 28)),
      ),
    );
  }
}
