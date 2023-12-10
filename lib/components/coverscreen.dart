import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;

  const CoverScreen({
    super.key,
    required this.hasGameStarted,
  });

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.2),
            child: Text(
              'tap to play',
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          );
  }
}
