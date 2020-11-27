
import 'package:chessboard/board/board-paint.dart';
import 'package:chessboard/board/pieces-painter.dart';
import 'package:chessboard/cchess/phase.dart';
import 'package:chessboard/common/color-consts.dart';
import 'package:flutter/material.dart';

import 'words-on-board.dart';

class BoardWidget extends StatelessWidget {

  // 棋盘内边界 + 棋盘上的路数指定文字高度
  static const Padding = 5.0, DigitsHeight = 36.0;
  // 棋盘的宽高
  final double width, height;

  final Function(BuildContext, int) onBoardTap;

  BoardWidget({@required this.width, @required this.onBoardTap}):
      height = (width - Padding * 2) / 9 * 10 + (Padding + DigitsHeight) * 2;

  @override
  Widget build(BuildContext context) {
    final boardContainer = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConsts.BoardBackground
      ),
      child: CustomPaint(
        // 背景一层绘制棋盘上线格
        painter: BoardPainter(width: width),
        // 前景绘制棋子
        foregroundPainter: PiecesPainter(
          width: width,
          phase: Phase.defaultPhase()
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: Padding,
            // 因为棋子是放在交叉线上的，不是放置在格子内，所以棋子左右各有一半在格线之外
            // 这里先依据横盘的宽度计算出一个格子的边长，再依此决定垂直方向的边距
            horizontal: (width - Padding * 2) / 9 / 2 + Padding - WordsOnBoard.DigitsFontSize / 2,
          ),
          child: WordsOnBoard(),
        ),
      ),
    );
    // 用 GestureDetector 组件包裹我们的 board 组件，用于检测 board 上的点击事件
    return GestureDetector(child: boardContainer, onTapUp: (d) {
      final gridWidth = (width - Padding * 2) * 8 / 9;
      final squareSide = gridWidth / 8;
      final dx = d.localPosition.dx, dy = d.localPosition.dy;

      final row = (dy - Padding - DigitsHeight) ~/ squareSide;
      final column = (dx - Padding) ~/ squareSide;
      if (row < 0 || row > 9) return;
      if (column < 0 || column > 9) return;

      print('row: $row, column: $column');
      // 回调
      onBoardTap(context, row * 9 + column);
    });
  }


}