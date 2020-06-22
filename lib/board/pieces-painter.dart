import 'package:chessboard/board/board-widget.dart';
import 'package:chessboard/board/painter-base.dart';
import 'package:chessboard/cchess/cc-base.dart';
import 'package:chessboard/cchess/phase.dart';
import 'package:chessboard/common/color-consts.dart';
import 'package:flutter/material.dart';

class PiecesPainter extends PainterBase {
  final Phase phase;
  double pieceSide;

  PiecesPainter({@required double width, @required this.phase})
      : super(width: width) {
    pieceSide = squareSide * 0.9;
  }
  @override
  void paint(Canvas canvas, Size size) {
    doPaint(canvas, thePaint,
        phase: phase,
        squareSide: squareSide,
        pieceSide: pieceSide,
        offsetX: BoardWidget.Padding + squareSide / 2,
        offsetY: BoardWidget.Padding + BoardWidget.DigitsHeight + squareSide / 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  static doPaint(
    Canvas canvas,
    Paint paint, {
    Phase phase,
    double gridWidth,
    double squareSide,
    double pieceSide,
    double offsetX,
    double offsetY,
  }) {
    final left = offsetX, top = offsetY;

    // 在Flutter中绘制阴影，需要先将阴影对象添加到一个Path中
    // 我们绘制棋子时，可以将每个棋子的阴影路径一次性添加到Path中，然后一次绘制所有棋子的阴影
    final shadowPath = Path();
    final piecesToDraw = <PiecePaintStub>[];

    for (var row = 0; row < 10; row++) {
      for (var column = 0; column < 9; column++) {
        final piece = phase.pieceAt(row * 9 + column);
        if (piece == Piece.Empty) continue;

        // 计算棋子的位置
        var pos = Offset(left + squareSide * column, top + squareSide * row);
        piecesToDraw.add(PiecePaintStub(piece: piece, pos: pos));
        
        // 为每一个棋子绘制一个圆形阴影
        shadowPath.addOval(Rect.fromCenter(center: pos, width: pieceSide, height: pieceSide));
      }
    }
    // 绘制黑色的厚度为2dp的棋子阴影
    canvas.drawShadow(shadowPath, Colors.black, 2, true);

    paint.style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: ColorConsts.PieceTextColor,
      fontSize: pieceSide * 0.8,
        fontFamily: 'QiTi',
      height: 1.0
    );

    // 绘制棋子
    piecesToDraw.forEach((pps) {
      paint.color = Piece.isRed(pps.piece) ? ColorConsts.RedPieceBorderColor : ColorConsts.BlackPieceBorderColor;

      // 绘制棋子的边界
      canvas.drawCircle(pps.pos, pieceSide / 2, paint);

      paint.color = Piece.isRed(pps.piece) ? ColorConsts.RedPieceColor : ColorConsts.BlackPieceColor;
      // 绘制棋子的内部圆
      canvas.drawCircle(pps.pos, pieceSide * 0.8 / 2, paint);

      final textSpan = TextSpan(text: Piece.Names[pps.piece], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr
      )..layout();

      // 计算字体的Metrics，包含相应字体的Baseline
      final metric = textPainter.computeLineMetrics()[0];
      // 测量文字的尺寸
      final textSize = textPainter.size;
      // 从顶上算，文字的Baseline在2/3高度线上
      final textOffset = pps.pos - Offset(textSize.width / 2,
          metric.baseline - textSize.height / 3);
      // 将文字绘制在Canvas上
      textPainter.paint(canvas, textOffset);
    });
  }

}

class PiecePaintStub {
  final String piece;
  final Offset pos; // 棋子呈现位置

  PiecePaintStub({this.piece, this.pos});
}
