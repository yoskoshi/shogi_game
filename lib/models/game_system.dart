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
  }) = _GameSystem;
}
