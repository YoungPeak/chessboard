
import 'package:chessboard/cchess/cc-base.dart';
import 'package:chessboard/common/color-consts.dart';
import 'package:chessboard/game/battle.dart';
import 'package:flutter/material.dart';
import '../board/board-widget.dart';
import '../main.dart';

class BattlePage extends StatefulWidget {

  // 棋盘的纵横方向的边距

  static double boardMargin = 10.0, screenPaddingH = 10.0;

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
                onPressed: () => Navigator.of(context).pop()
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
        horizontal: BattlePage.screenPaddingH,
        vertical: BattlePage.boardMargin
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConsts.BoardBackground
      ),
      child: BoardWidget(
        // 这里将screenPaddingH作为边距，放置在BoardWidget左右，这样棋盘将水平居中显示
        width: windowSize.width - BattlePage.screenPaddingH * 2,
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
      margin: EdgeInsets.symmetric(horizontal: BattlePage.screenPaddingH),
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

  // 对于底部的空间的弹性处理
  // 针对屏幕比较短的情况，点击一个按钮把着法列表弹出
  Widget buildFooter() {
    final size = MediaQuery.of(context).size;

    final manualText = '<暂无棋谱>';

    if (size.height / size.width > 16 / 9) {
      return buildManualPanel(manualText);
    } else {
      return buildExpandableManualPanel(manualText);
    }
  }

  Widget buildManualPanel(String text) {
    final manualStyle = TextStyle(
      fontSize: 18,
      color: ColorConsts.DarkTextSecondary,
      height: 1.5
    );

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(child: Text(text, style: manualStyle)),
      ),
    );
  }

  // 短屏幕显示一个按钮，点击它后弹出着法列表
  Widget buildExpandableManualPanel(String text) {

    final manualStyle = TextStyle(fontSize: 18, height: 1.5);

    return Expanded(
      child: IconButton(
        icon: Icon(Icons.expand_less, color: ColorConsts.DarkTextPrimary),
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('棋谱', style: TextStyle(color: ColorConsts.Primary)),
              content: SingleChildScrollView(child: Text(text, style: manualStyle)),
              actions: <Widget>[
                FlatButton(
                  child: Text('好的'),
                  onPressed: () => Navigator.of(context).pop()
                )
              ],
            );
          }
        ),
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

  void calcScreenPaddingH() {
    // 当屏幕的纵横比小于16/9时，限制棋盘的宽度
    final windowSize = MediaQuery.of(context).size;
    double height = windowSize.height, width = windowSize.width;

    if (height / width < 16.0 / 9.0) {
      width = height * 9 / 16;
      // 棋盘宽度之外的空间，分左右两边，由screenPaddingH来持有，布局时添加到BoardWidget外围水平边距
      BattlePage.screenPaddingH = (windowSize.width - width) / 2 - BattlePage.boardMargin;
    }
  }

  @override
  void initState() {

    super.initState();

    Battle.shared.init();
  }

  @override
  Widget build(BuildContext context) {

    calcScreenPaddingH();

    final header = createPageHeader();
    final board = createBoard();
    final operatorBar = createOperatorBar();
    final footer = buildFooter();

    return Scaffold(
      backgroundColor: ColorConsts.DarkBackground,
      body: Column(
        children: <Widget>[header, board, operatorBar, footer],
      ),
    );
  }
}

