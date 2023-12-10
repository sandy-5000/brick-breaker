import 'dart:async';
import 'dart:math';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/components/coverscreen.dart';
import 'package:brick_breaker/components/gameover.dart';
import 'package:brick_breaker/components/hitboard.dart';
import 'package:brick_breaker/utils/brick.dart';
import 'package:brick_breaker/utils/brick_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasGameStarted = false;
  bool isGameOver = false;

  double ballX = 0;
  double ballY = 0;
  final ballSpeed = 0.012;
  var direction = 315.5;

  double boardX = 0;
  final boardY = 0.97;
  double boardWidth = 0.4;
  final boardSpeed = 0.1;
  double safeStart = 0;
  double safeEnd = 0;

  final List<int> bricksInRow = List.of([2, 3, 4, 5, 6, 5, 4, 3, 2]);

  List<Brick> brickList = List.of([]);
  List<GBrick> gbricks = List.of([]);

  void startGame() {
    if (hasGameStarted) {
      return;
    }
    safeStart = -boardWidth / 2;
    safeEnd = boardWidth / 2;
    hasGameStarted = true;
    setState(() {
      brickList = getBricks(bricksInRow).expand((i) => i).toList();
      setBricks();
    });
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        changeDirection();
        if (isBallOut()) {
          timer.cancel();
          isGameOver = true;
        }
      });
    });
  }

  void resetGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      direction = 315.5;
      boardX = 0;
      isGameOver = false;
      hasGameStarted = false;
    });
  }

  void setBricks() {
    gbricks = brickList.map((brick) {
      return GBrick(
        x: brick.x,
        y: brick.y,
        height: brick.height,
        width: brick.width,
        hit: brick.hit,
        start: brick.start,
        end: brick.end,
      );
    }).toList();
  }

  bool isBallOut() {
    if (ballY >= 1.0) {
      return true;
    }
    return false;
  }

  int getMin(double left, double right, double top, double bottom) {
    final xAxis = left < right ? left : right;
    final yAxis = top < bottom ? top : bottom;
    return xAxis < yAxis ? 1 : -1;
  }

  int hitBrick() {
    for (Brick brick in brickList) {
      if (brick.hit) {
        continue;
      }
      if (brick.start <= ballX &&
          ballX <= brick.end &&
          ballY <= brick.y + brick.height) {
        brick.hit = true;
        setBricks();
        return getMin(
          ballX - brick.start,
          brick.end - ballX,
          (brick.y - ballY).abs(),
          (brick.y + brick.height - ballY).abs(),
        );
      }
    }
    return 0;
  }

  void changeDirection() {
    final hitAnyBrick = hitBrick();
    if (ballX - ballSpeed <= -1 || ballX - ballSpeed >= 1 || hitAnyBrick == 1) {
      final isDown = direction > 180.0;
      if (isDown) {
        direction -= 180.0;
        direction = 180 - direction;
        direction += 180.0;
      } else {
        direction = 180.0 - direction;
      }
    }
    if (ballY - ballSpeed <= -1 || hitAnyBrick == -1) {
      final isLeft = direction > 90.0 && direction < 270.0;
      if (isLeft) {
        direction -= 90.0;
        direction = 180 - direction;
        direction += 90.0;
      } else {
        direction = 360.0 - direction;
      }
    }
    if (ballY + ballSpeed >= boardY && safeStart <= ballX && ballX <= safeEnd) {
      direction = 190.0 + 160.0 * (ballX - safeStart) / (boardWidth);
    }
    final double xDirections = cos(direction * (pi / 180.0));
    ballX += xDirections * ballSpeed;
    final double yDirections = sin(direction * (pi / 180.0));
    ballY += yDirections * ballSpeed;
  }

  void moveLeft() {
    setState(() {
      if (boardX - boardSpeed <= -1) {
        return;
      }
      boardX -= boardSpeed;
      setSafe();
    });
  }

  void moveRight() {
    setState(() {
      if (boardX + boardSpeed >= 1) {
        return;
      }
      boardX += boardSpeed;
      setSafe();
    });
  }

  void setSafe() {
    safeStart = boardX * (2 - boardWidth) / 2 - boardWidth / 2;
    safeEnd = safeStart + boardWidth;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                CoverScreen(
                  hasGameStarted: hasGameStarted,
                ),
                ...gbricks,
                GBall(
                  x: ballX,
                  y: ballY,
                  isGameOver: isGameOver,
                ),
                HitBoard(
                  x: boardX,
                  y: boardY,
                  width: boardWidth,
                ),
                GameOver(
                  isGameOver: isGameOver,
                  restartGame: resetGame,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
