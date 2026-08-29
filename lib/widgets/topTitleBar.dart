import 'package:flutter/material.dart';

class TopTitleBar extends StatelessWidget {
  final String? title;

  const TopTitleBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleStyle =
        Theme.of(context).textTheme.titleLarge ??
        TextStyle(color: Colors.white, fontSize: 24, height: 1.5);
    final primaryColor = theme.primary;
    final lightColor = primaryColor.withValues(alpha: 0.8);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.5, 0.5, 1],
          colors: [primaryColor, primaryColor, lightColor, lightColor],
        ),
      ),
      child: Center(
        child: Text(
          title ?? '',
          style: titleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
