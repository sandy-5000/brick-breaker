import 'package:flutter/material.dart';

class GBall extends StatelessWidget {
  final double x;
  final double y;
  final bool isGameOver;

  const GBall({
    super.key,
    required this.x,
    required this.y,
    required this.isGameOver,
  });

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: Container(
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
          );
  }
}
