
import 'cc-base.dart';

class Phase {
  // 当前行棋方
  String _side;
  // 中国象棋的棋子放在纵横线交叉点上，棋盘上总共有10行9列的交叉点位，一共90个位置
  List<String> _pieces;

  get side => _side;

  turnSide() => _side = Side.oppo(_side);

  String pieceAt(int index) => _pieces[index];

  Phase.defaultPhase() {
    //
    _side = Side.Red;
    _pieces = List<String>(90);

    // 从上到下，棋盘第一行
    _pieces[0 * 9 + 0] = Piece.BlackRook;
    _pieces[0 * 9 + 1] = Piece.BlackKnight;
    _pieces[0 * 9 + 2] = Piece.BlackBishop;
    _pieces[0 * 9 + 3] = Piece.BlackAdvisor;
    _pieces[0 * 9 + 4] = Piece.BlackKing;
    _pieces[0 * 9 + 5] = Piece.BlackAdvisor;
    _pieces[0 * 9 + 6] = Piece.BlackBishop;
    _pieces[0 * 9 + 7] = Piece.BlackKnight;
    _pieces[0 * 9 + 8] = Piece.BlackRook;

    // 从上到下，棋盘第三行
    _pieces[2 * 9 + 1] = Piece.BlackCanon;
    _pieces[2 * 9 + 7] = Piece.BlackCanon;

    // 从上到下，棋盘第四行
    _pieces[3 * 9 + 0] = Piece.BlackPawn;
    _pieces[3 * 9 + 2] = Piece.BlackPawn;
    _pieces[3 * 9 + 4] = Piece.BlackPawn;
    _pieces[3 * 9 + 6] = Piece.BlackPawn;
    _pieces[3 * 9 + 8] = Piece.BlackPawn;

    // 从上到下，棋盘第十行
    _pieces[9 * 9 + 0] = Piece.RedRook;
    _pieces[9 * 9 + 1] = Piece.RedKnight;
    _pieces[9 * 9 + 2] = Piece.RedBishop;
    _pieces[9 * 9 + 3] = Piece.RedAdvisor;
    _pieces[9 * 9 + 4] = Piece.RedKing;
    _pieces[9 * 9 + 5] = Piece.RedAdvisor;
    _pieces[9 * 9 + 6] = Piece.RedBishop;
    _pieces[9 * 9 + 7] = Piece.RedKnight;
    _pieces[9 * 9 + 8] = Piece.RedRook;

    // 从上到下，棋盘第八行
    _pieces[7 * 9 + 1] = Piece.RedCanon;
    _pieces[7 * 9 + 7] = Piece.RedCanon;

    // 从上到下，棋盘第七行
    _pieces[6 * 9 + 0] = Piece.RedPawn;
    _pieces[6 * 9 + 2] = Piece.RedPawn;
    _pieces[6 * 9 + 4] = Piece.RedPawn;
    _pieces[6 * 9 + 6] = Piece.RedPawn;
    _pieces[6 * 9 + 8] = Piece.RedPawn;

    // 其它位置全部填空
    for (var i = 0; i < 90; i++) {
      _pieces[i] ??= Piece.Empty;
    }
  }

  bool move(int from, int to) {
    if (!validateMove(from, to)) return false;

    // 修改棋盘
    _pieces[to] = _pieces[from];
    _pieces[from] = Piece.Empty;

    // 交换走棋方
    //_side = Side.oppo(_side);

    return true;

  }

  bool validateMove(int from, int to) {
    // TODO:
    return true;
  }
}