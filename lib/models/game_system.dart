import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_system.freezed.dart';

@freezed
class GameSystem with _$GameSystem {
  const factory GameSystem({
    @Default([
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
    ])
        List<int> installLocationXList,
    @Default([
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
    ])
        List<int> installLocationYList,
    @Default(1)
        int step,
    @Default(true)
        bool isPlayersTurn,
    @Default(-1)
        int selectedPieceIndexX,
    @Default(-1)
        int selectedPieceIndexY,
    @Default([
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
    ])
        List<String> selfPawnList,
    @Default([
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
    ])
        List<String> rivalPawnList,
    @Default(0)
        int rivalPawnListIndex,
    @Default(0)
        int selfPawnListIndex,
    @Default(false)
        bool isRival,
  }) = _GameSystem;
}
