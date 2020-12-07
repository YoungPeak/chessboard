import 'package:chessboard/cchess/cc-base.dart';
import 'package:chessboard/common/color-consts.dart';
import 'package:chessboard/game/battle.dart';
import 'package:flutter/material.dart';
import '../board/board-widget.dart';
import '../main.dart';

class BattlePage extends StatefulWidget {

  // 棋盘的纵横方向的边距
  static const BoardMarginV = 10.0,
      BoardMarginH = 10.0;

  @override
  State<StatefulWidget> createState() => _BattlePageState();

}

class _BattlePageState extends State<BattlePage> {

  Widget createPageHeader() {
    final titleStyle = TextStyle(fontSize: 28, color: ColorConsts.DarkTextPrimary);
    final subTitleStyle = TextStyle(fontSize: 16, color: ColorConsts.DarkTextSecondary);

    return Container(
      margin: EdgeInsets.only(top: ChessRoadApp.StatusBarHeight),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back, color: ColorConsts.DarkTextPrimary),
                onPressed: (){},
              ),
              Expanded(child: SizedBox()),
              Text('单机对战', style: titleStyle),
              Expanded(child: SizedBox()),
              IconButton(
                icon: Icon(Icons.settings, color: ColorConsts.DarkTextPrimary),
                onPressed: (){},
              )
            ],
          ),
          Container(
            height: 4,
            width: 180,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: ColorConsts.BoardBackground,
              borderRadius: BorderRadius.circular(2)
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('[游戏状态]', maxLines: 1, style: subTitleStyle),
          )
        ],
      ),
    );
  }

  Widget createBoard() {
    final windowSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: BattlePage.BoardMarginH,
        vertical: BattlePage.BoardMarginV
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConsts.BoardBackground
      ),
      child: BoardWidget(
        // 棋盘的宽度已经扣除了部分边界
        width: windowSize.width - BattlePage.BoardMarginH * 2,
        onBoardTap: onBoardTap,
      ),
    );
  }

  Widget createOperatorBar() {
    final buttonStyle = TextStyle(color: ColorConsts.Primary, fontSize: 20);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConsts.BoardBackground
      ),
      margin: EdgeInsets.symmetric(horizontal: BattlePage.BoardMarginH),
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Expanded(child: SizedBox()),
          FlatButton(child: Text('新对局', style: buttonStyle), onPressed: (){}),
          Expanded(child: SizedBox()),
          FlatButton(child: Text('悔棋', style: buttonStyle), onPressed: (){}),
          Expanded(child: SizedBox()),
          FlatButton(child: Text('分析局面', style: buttonStyle), onPressed: (){}),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }

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

    final header = createPageHeader();
    final board = createBoard();
    final operatorBar = createOperatorBar();

    return Scaffold(
      backgroundColor: ColorConsts.DarkBackground,
      body: Column(
        children: <Widget>[header, board, operatorBar],
      ),
    );
  }
}

