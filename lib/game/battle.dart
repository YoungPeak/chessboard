import '../cchess/phase.dart';

/// 该类类将集中管理横盘上的棋子、对战结果、引擎调用等事务。
/// 该类是个单例对象。
class Battle {

  static Battle _instance;

  Phase _phase;
  // 分别记录当前位置和前一个位置
  int _focusIndex, _blurIndex;

  static get shared {
    _instance ??= Battle();
    return _instance;
  }

  init() {
    _phase = Phase.defaultPhase();
    _focusIndex = _blurIndex = -1;
  }
  // 点击选中一个棋子，使用focusIndex来标记此位置
  // 棋子绘制时，将在这个位置绘制棋子选中效果
  select(int pos) {
    _focusIndex = pos;
    _blurIndex = -1;
  }
  // 从 from 到 to 位置移动棋子，使用focusIndex和blurIndex来标记from和to
  // 棋子绘制时，将在这两个位置分别绘制棋子的移动前的位置和当前位置
  move(int from, int to) {
    if (!_phase.move(from, to)) return false;

    _blurIndex = from;
    _focusIndex = to;

    return true;
  }

  clear() {
    _blurIndex = _focusIndex = -1;
  }

  get phase => _phase;

  get focusIndex => _focusIndex;

  get blurIndex => _blurIndex;
}