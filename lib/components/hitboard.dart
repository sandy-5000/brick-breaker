import 'package:flutter/material.dart';

class HitBoard extends StatelessWidget {
  final double x;
  final double y;
  final double width;

  const HitBoard({
    super.key,
    required this.x,
    required this.y,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 10,
          width: MediaQuery.of(context).size.width * width / 2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
