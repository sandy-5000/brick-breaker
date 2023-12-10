import 'package:flutter/material.dart';

class GBrick extends StatelessWidget {
  final double x;
  final double y;
  final double height;
  final double width;
  final bool hit;
  final double start;
  final double end;

  const GBrick({
    super.key,
    required this.x,
    required this.y,
    required this.height,
    required this.width,
    required this.hit,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return hit
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * height / 2,
                width: MediaQuery.of(context).size.width * width / 2,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}
