import 'package:brick_breaker/utils/brick.dart';

List<List<Brick>> getBricks(List<int> rows) {
  const gap = 0.02;
  const brickHeight = 0.05;
  final n = rows.length;
  return List.generate(n, (i) {
    final cols = rows[i];
    final double brickWidth = (2.0 - (cols + 1) * gap) / cols;
    return List.generate(cols, (index) {
      final x = 2 * (1 - gap) * index / (cols - 1) + gap - 1.0;
      final start = x * (2 - brickWidth) / 2 - brickWidth / 2;
      final end = start + brickWidth;
      return Brick(
        x: x,
        y: gap + (gap + brickHeight) * i - 1.0,
        width: brickWidth,
        height: brickHeight,
        hit: false,
        start: start,
        end: end,
      );
    });
  });
}
