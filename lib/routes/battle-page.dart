import 'package:chessboard/cchess/cc-base.dart';
import 'package:chessboard/game/battle.dart';
import 'package:flutter/material.dart';
import '../board/board-widget.dart';

class BattlePage extends StatefulWidget {

  // 棋盘的纵横方向的边距
  static const BoardMarginV = 10.0,
      BoardMarginH = 10.0;

  @override
  State<StatefulWidget> createState() => _BattlePageState();

}

class _BattlePageState extends State<BattlePage> {

  onBoardTap(BuildContext context, int index) {
    print('board cross index: $index');

    final phase = Battle.shared.phase;
    // 仅Phase中的side指示一方能动棋
    if (phase.side != Side.Red) return;

    final tapedPiece = phase.pieceAt(index);

    // 之前已经有选中的棋子
    if (Battle.shared.focusIndex != -1
        && Side.of(phase.pieceAt(Battle.shared.focusIndex)) == Side.Red) {

      // 如果当前点击的棋子和之前已经选择的是同一个位置
      if (Battle.shared.focusIndex == index) return;

      // 之前已经选择的棋子和现在点击的棋子是同一边的，说明是选择另外一个棋子
      final focusPiece = phase.pieceAt(Battle.shared.focusIndex);
      if (Side.sameSide(focusPiece, tapedPiece)) {
        Battle.shared.select(index);
      } else if (Battle.shared.move(Battle.shared.focusIndex, index)) {
        // 现在点击的棋子和上一次选择棋子不同边，要么是吃子，要么是移动棋子到空白处
        // TODO: 处理游戏结果或吃子
      }
    } else {
      // 之前未选择棋子，现在点击就是选择棋子
      if (tapedPiece != Piece.Empty)
        Battle.shared.select(index);
    }

    setState(() {});
  }

  @override
  void initState() {

    super.initState();

    Battle.shared.init();
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery
        .of(context)
        .size;
    final boardHeight = windowSize.width - BattlePage.BoardMarginH * 2;

    return Scaffold(
      appBar: AppBar(title: Text('Battle')),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: BattlePage.BoardMarginH,
            vertical: BattlePage.BoardMarginV
        ),
        child: BoardWidget(width: boardHeight, onBoardTap: onBoardTap),
      ),
    );
  }
}

