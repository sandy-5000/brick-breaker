import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final bool isGameOver;
  final restartGame;

  const GameOver({
    super.key,
    required this.isGameOver,
    required this.restartGame,
  });

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, 0.3),
                child: const Text(
                  "G A M E  O V E R",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: restartGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.deepPurple,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
