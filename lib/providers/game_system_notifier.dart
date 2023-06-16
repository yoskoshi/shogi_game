import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/models/game_system.dart';

final gameSystemProvider =
    StateNotifierProvider<GameSystemNotifier, GameSystem>(((ref) {
  return GameSystemNotifier();
}));

class GameSystemNotifier extends StateNotifier<GameSystem> {
  GameSystemNotifier() : super(const GameSystem());
  int index = 0;
  bool isHighLight = false;

  //駒の動かせる位置を指定
  void nextLocation(
      String text, int indexX, int indexY, List<List<String>> pieceTextList) {
    if (text == "歩" || text == "桂" || text == "銀" || text == "金" || text == "王") {
      nextLocationWithoutKyouAndKakuAndHisya(indexX, indexY, pieceTextList, text);
    } else if (text == "香") {
      kyoushaNextLocation(indexX, indexY, pieceTextList);
    } else if (text == "角" || text == "飛") {
      kakuAndHisyaNextLocation(indexX, indexY, pieceTextList, text);
    }
  }

  //
  void nextLocationWithoutKyouAndKakuAndHisya(int indexX, int indexY, List<List<String>> pieceTextList, String text) {
    List<int> installNextLocationX = [];
    List<int> installNextLocationY = [];
    if (text == "歩") {
      installNextLocationX = [indexX];
      installNextLocationY = [indexY - 1];
    } else if (text == "桂") {
      installNextLocationX = [indexX + 1, indexX - 1];
      installNextLocationY = [indexY - 2, indexY - 2];
    } else if (text == "銀") {
      installNextLocationX = [
        indexX + 1,
        indexX - 1,
        indexX + 1,
        indexX,
        indexX - 1,
      ];
      installNextLocationY = [
        indexY + 1,
        indexY + 1,
        indexY - 1,
        indexY - 1,
        indexY - 1,
      ];
    } else if (text == "金") {
      installNextLocationX = [
        indexX,
        indexX + 1,
        indexX - 1,
        indexX + 1,
        indexX,
        indexX - 1,
      ];

      installNextLocationY = [
        indexY + 1,
        indexY,
        indexY,
        indexY - 1,
        indexY - 1,
        indexY - 1,
      ];
    } else if (text == "王") {
      installNextLocationX = [
        indexX + 1,
        indexX,
        indexX - 1,
        indexX + 1,
        indexX - 1,
        indexX + 1,
        indexX,
        indexX - 1,
      ];
      installNextLocationY = [
        indexY + 1,
        indexY + 1,
        indexY + 1,
        indexY,
        indexY,
        indexY - 1,
        indexY - 1,
        indexY - 1,
      ];
    }

    for (int i = 0; i < initialInstallNextLocationLength(text); i++) {
      for (int j = 0; j < installNextLocationY.length; j++) {
        bool isNotAbleToMove = installNextLocationX[j] > 8 || installNextLocationX[j] < 0 || installNextLocationY[j] > 8 || installNextLocationY[j] < 0 || pieceTextList[installNextLocationY[j]][installNextLocationX[j]] !=
            " ";
        if (isNotAbleToMove) {
          installNextLocationX.removeAt(j);
          installNextLocationY.removeAt(j);
          break;
        }
      }
    }

    List<int> addNumberList = List.generate(20 - installNextLocationX.length, (index) => -1);
    installNextLocationX.addAll(addNumberList);
    installNextLocationY.addAll(addNumberList);
    state = state.copyWith(
        installLocationXList: installNextLocationX,
        installLocationYList: installNextLocationY);
  }

  int initialInstallNextLocationLength(String text) {
    int result = 0;
    if (text == "歩") {
      result = 1;
    } else if (text == "桂") {
      result = 2;
    } else if (text == "銀") {
      result = 5;
    } else if (text == "金") {
      result = 6;
    } else if (text == "王") {
      result = 8;
    }
    return result;
  }

  void kyoushaNextLocation(
      int indexX, int indexY, List<List<String>> pieceTextList) {
    List<int> installNextLocationX = List.generate(20, (index) => -1);
    List<int> installNextLocationY = List.generate(20, (index) => -1);
    for (int i = 0; i < 8; i++) {
      if (indexY - (i + 1) >= 0 &&
          pieceTextList[indexY - (i + 1)][indexX] == " ") {
        installNextLocationX[i] = indexX;
        installNextLocationY[i] = indexY - (i + 1);
      } else {
        break;
      }
    }
    state = state.copyWith(
        installLocationXList: installNextLocationX,
        installLocationYList: installNextLocationY);
  }

  void kakuAndHisyaNextLocation(int indexX, int indexY, List<List<String>> pieceTextList, String text) {
    List<int> installNextLocationX = [];
    List<int> installNextLocationY = [];
    if (text == "角") {
      //左上の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX - (i + 1) >= 0 && indexY - (i + 1) >= 0 && pieceTextList[indexY - (i + 1)][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY - (i + 1));
        } else {
          break;
        }
      }
      //右上の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX + (i + 1) <= 8 && indexY - (i + 1) >= 0 && pieceTextList[indexY - (i + 1)][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY - (i + 1));
        } else {
          break;
        }
      }
      //左下の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX - (i + 1) >= 0 && indexY + (i + 1) <= 8 && pieceTextList[indexY + (i + 1)][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY + (i + 1));
        } else {
          break;
        }
      }
      //右下の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX + (i + 1) <= 8 && indexY + (i + 1) <= 8 && pieceTextList[indexY + (i + 1)][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY + (i + 1));
        } else {
          break;
        }
      }
    } else if (text == "飛") {
      //上で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexY - (i + 1) >= 0 && pieceTextList[indexY - (i + 1)][indexX] == " ") {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY - (i + 1));
        } else {
          break;
        }
      }
      //左で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX - (i + 1) >= 0 && pieceTextList[indexY][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY);
        } else {
          break;
        }
      }
      //右で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexX + (i + 1) <= 8 && pieceTextList[indexY][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY);
        } else {
          break;
        }
      }
      //下で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        if (indexY + (i + 1) >= 0 && pieceTextList[indexY + (i + 1)][indexX] == " ") {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY + (i + 1));
        } else {
          break;
        }
      }
    }
    //highLightできるようにリストをソートする
    for (int i = 0; i < installNextLocationX.length - 1; i++) {
      for (int j = 0; j < installNextLocationX.length - 1 - i; j++) {
        if (installNextLocationY[j] < installNextLocationY[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
          int savedDataY = installNextLocationY[j];
          installNextLocationY[j] = installNextLocationY[j + 1];
          installNextLocationY[j + 1] = savedDataY;
        } else if (installNextLocationY[j] == installNextLocationY[j + 1] && installNextLocationX[j] < installNextLocationX[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
        }
      }
    }

    //リストの要素数を20にする
    List<int> addNumberList = List.generate(20 - installNextLocationX.length, (index) => -1);
    installNextLocationX.addAll(addNumberList);
    installNextLocationY.addAll(addNumberList);
    //リストを更新する
    state = state.copyWith(installLocationXList: installNextLocationX, installLocationYList: installNextLocationY);
  }

  void resetInstallLocationList() {
    final List<int> installLocationXList = List.generate(20, (index) => -1);
    final List<int> installLocationYList = List.generate(20, (index) => -1);

    state = state.copyWith(
        installLocationXList: installLocationXList,
        installLocationYList: installLocationYList);
  }

  void nextStep() {
    state = state.copyWith(step: state.step + 1);
  }

  void resetStep() {
    state = state.copyWith(step: 1);
  }

  void changeTurn() {
    if (state.isPlayersTurn) {
      state = state.copyWith(isPlayersTurn: false);
    } else {
      state = state.copyWith(isPlayersTurn: true);
    }
  }

  //動かせる場所を表示する
  Color? highLight(int indexX, int indexY, List<List<String>> pieceTextList) {
    if (state.step == 2) {
      for (int i = 0; i < state.installLocationXList.length; i++) {
        if (state.installLocationXList[i] == -1 && !isHighLight) {
          if (i == 0) {
            index = 0;
          } else {
            index = i - 1;
          }
          break;
        }
      }

      isHighLight = true;

      if (indexX == state.installLocationXList[index] &&
          indexY == state.installLocationYList[index]) {
        if (index >= 1) {
          index--;
        }
        return AppColor.white;
      } else {
        return null;
      }
    }
  }

  void resetIndex() {
    index = 0;
  }

  void updateIsHighLight() {
    isHighLight = false;
  }

  void updateSelectedPieceIndexXY(int indexX, int indexY) {
    state = state.copyWith(
        selectedPieceIndexX: indexX, selectedPieceIndexY: indexY);
  }
}
