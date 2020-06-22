
import 'package:chessboard/common/color-consts.dart';
import 'package:flutter/material.dart';

class WordsOnBoard extends StatelessWidget {

  static const DigitsFontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    // 棋盘上的路数指示，红方用大写，黑方用全角的小写字母
    final blackColumns = '１２３４５６７８９', redColumns = '九八七六五四三二一';
    final bChildren = <Widget>[], rChildren = <Widget>[];

    final digitsStyle = TextStyle(fontSize: DigitsFontSize);
    final riverTipStyle = TextStyle(fontSize: 28.0);

    for (var i = 0; i < 9; i++) {
      bChildren.add(Text(blackColumns[i], style: digitsStyle));
      rChildren.add(Text(redColumns[i], style: digitsStyle));

      // 每一个数字后边添加一个Expanded，用于平分布局空间
      if (i < 8) {
        bChildren.add(Expanded(child: SizedBox()));
        rChildren.add(Expanded(child: SizedBox()));
      }
    }

    final riverTips = Row(
      children: <Widget>[
        Expanded(child: SizedBox()),
        Text('楚河', style: riverTipStyle),
        Expanded(child: SizedBox(), flex: 2),
        Text('汉界', style: riverTipStyle),
        Expanded(child: SizedBox())
      ],
    );

    // 放置上、中、下三部分到一个列布局模式中，上和中、中和下之间用Expanded对象
    // 平分垂直方向多出来的布局空间
    return DefaultTextStyle(
      child: Column(
        children: <Widget>[
          Row(children: bChildren),
          Expanded(child: SizedBox()),
          riverTips,
          Expanded(child: SizedBox()),
          Row(children: rChildren)
        ],
      ),
      style: TextStyle(color: ColorConsts.BoardTips, fontFamily: 'QiTi'),
    );
  }

}