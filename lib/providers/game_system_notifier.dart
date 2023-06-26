import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/models/game_system.dart';

import 'one_player_game_setting_notifier.dart';

final gameSystemProvider =
    StateNotifierProvider<GameSystemNotifier, GameSystem>(((ref) {
  final isFirstMove = ref
      .watch(onePlayerGameSettingProvider.select((value) => value.isFirstMove));
  return GameSystemNotifier(isFirstMove: isFirstMove);
}));

class GameSystemNotifier extends StateNotifier<GameSystem> {
  final bool isFirstMove;
  GameSystemNotifier({required this.isFirstMove}) : super(const GameSystem()) {
    decidedInitialTurn();
  }
  int index = 0;
  bool isHighLight = false;

  void decidedInitialTurn() {
    if (isFirstMove) {
      state = state.copyWith(isPlayersTurn: true);
    } else {
      state = state.copyWith(isPlayersTurn: false);
    }
  }

  //駒の動かせる位置を指定
  void nextLocation(
      String text,
      int indexX,
      int indexY,
      List<List<String>> pieceTextList,
      bool isRival,
      List<List<bool>> initialRivalAndSelfList) {
    if (text == "歩" ||
        text == "桂" ||
        text == "銀" ||
        text == "金" ||
        text == "王" ||
        text == "玉") {
      nextLocationWithoutKyouAndKakuAndHisya(indexX, indexY, pieceTextList,
          text, isRival, initialRivalAndSelfList);
    } else if (text == "香") {
      kyoushaNextLocation(
          indexX, indexY, pieceTextList, isRival, initialRivalAndSelfList);
    } else if (text == "角" || text == "飛") {
      kakuAndHisyaNextLocation(indexX, indexY, pieceTextList, text, isRival,
          initialRivalAndSelfList);
    }
  }

  //
  void nextLocationWithoutKyouAndKakuAndHisya(
      int indexX,
      int indexY,
      List<List<String>> pieceTextList,
      String text,
      bool isRival,
      List<List<bool>> initialRivalAndSelfList) {
    List<int> installNextLocationX = [];
    List<int> installNextLocationY = [];
    if (text == "歩" && !isRival) {
      installNextLocationX = [indexX];
      installNextLocationY = [indexY - 1];
    } else if (text == "歩" && isRival) {
      installNextLocationX = [indexX];
      installNextLocationY = [indexY + 1];
    } else if (text == "桂" && !isRival) {
      installNextLocationX = [indexX + 1, indexX - 1];
      installNextLocationY = [indexY - 2, indexY - 2];
    } else if (text == "桂" && isRival) {
      installNextLocationX = [indexX + 1, indexX - 1];
      installNextLocationY = [indexY + 2, indexY + 2];
    } else if (text == "銀" && !isRival) {
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
    } else if (text == "銀" && isRival) {
      installNextLocationX = [
        indexX + 1,
        indexX,
        indexX - 1,
        indexX + 1,
        indexX - 1
      ];
      installNextLocationY = [
        indexY + 1,
        indexY + 1,
        indexY + 1,
        indexY - 1,
        indexY - 1
      ];
    } else if (text == "金" && !isRival) {
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
    } else if (text == "金" && isRival) {
      installNextLocationX = [
        indexX + 1,
        indexX,
        indexX - 1,
        indexX + 1,
        indexX - 1,
        indexX,
      ];
      installNextLocationY = [
        indexY + 1,
        indexY + 1,
        indexY + 1,
        indexY,
        indexY,
        indexY - 1,
      ];
    } else if (text == "王" || text == "玉") {
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
        bool isNotAbleToMove;
        if (isRival) {
          isNotAbleToMove = installNextLocationX[j] > 8 ||
              installNextLocationX[j] < 0 ||
              installNextLocationY[j] > 8 ||
              installNextLocationY[j] < 0 ||
              (pieceTextList[installNextLocationY[j]]
                          [installNextLocationX[j]] !=
                      " " &&
                  initialRivalAndSelfList[installNextLocationY[j]]
                      [installNextLocationX[j]]);
        } else {
          isNotAbleToMove = installNextLocationX[j] > 8 ||
              installNextLocationX[j] < 0 ||
              installNextLocationY[j] > 8 ||
              installNextLocationY[j] < 0 ||
              (pieceTextList[installNextLocationY[j]]
                          [installNextLocationX[j]] !=
                      " " &&
                  !initialRivalAndSelfList[installNextLocationY[j]]
                      [installNextLocationX[j]]);
        }

        if (isNotAbleToMove) {
          installNextLocationX.removeAt(j);
          installNextLocationY.removeAt(j);
          break;
        }
      }
    }

    List<int> addNumberList =
        List.generate(20 - installNextLocationX.length, (index) => -1);
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
    } else if (text == "王" || text == "玉") {
      result = 8;
    }
    return result;
  }

  void kyoushaNextLocation(
      int indexX,
      int indexY,
      List<List<String>> pieceTextList,
      bool isRival,
      List<List<bool>> initialRivalAndSelfList) {
    List<int> installNextLocationX = List.generate(20, (index) => -1);
    List<int> installNextLocationY = List.generate(20, (index) => -1);
    if (isRival) {
      for (int i = 0; i < 8; i++) {
        if (indexY + (i + 1) <= 8 &&
            pieceTextList[indexY + (i + 1)][indexX] == " ") {
          installNextLocationX[i] = indexX;
          installNextLocationY[i] = indexY + (i + 1);
        } else if (pieceTextList[indexY + (i + 1)][indexX] != " " &&
            !initialRivalAndSelfList[indexY + (i + 1)][indexX]) {
          installNextLocationX[i] = indexX;
          installNextLocationY[i] = indexY + (i + 1);
          break;
        } else {
          break;
        }
      }
      installNextLocationY.sort((a, b) => b.compareTo(a));
    } else {
      for (int i = 0; i < 8; i++) {
        if (indexY - (i + 1) >= 0 &&
            pieceTextList[indexY - (i + 1)][indexX] == " ") {
          installNextLocationX[i] = indexX;
          installNextLocationY[i] = indexY - (i + 1);
        } else if (pieceTextList[indexY - (i + 1)][indexX] != " " &&
            initialRivalAndSelfList[indexY - (i + 1)][indexX]) {
          installNextLocationX[i] = indexX;
          installNextLocationY[i] = indexY - (i + 1);
          break;
        } else {
          break;
        }
      }
    }
    state = state.copyWith(
        installLocationXList: installNextLocationX,
        installLocationYList: installNextLocationY);
  }

  void kakuAndHisyaNextLocation(
      int indexX,
      int indexY,
      List<List<String>> pieceTextList,
      String text,
      bool isRival,
      List<List<bool>> initialRivalAndSelfList) {
    List<int> installNextLocationX = [];
    List<int> installNextLocationY = [];
    if (text == "角") {
      //左上の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (!isRival &&
                indexX - (i + 1) >= 0 &&
                indexY - (i + 1) >= 0 &&
                pieceTextList[indexY - (i + 1)][indexX - (i + 1)] != " " &&
                initialRivalAndSelfList[indexY - (i + 1)][indexX - (i + 1)]) ||
            (isRival &&
                indexX - (i + 1) >= 0 &&
                indexY - (i + 1) >= 0 &&
                pieceTextList[indexY - (i + 1)][indexX - (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY - (i + 1)][indexX - (i + 1)]);
        if (indexX - (i + 1) >= 0 &&
            indexY - (i + 1) >= 0 &&
            pieceTextList[indexY - (i + 1)][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY - (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY - (i + 1));
          break;
        } else {
          break;
        }
      }
      //右上の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (!isRival &&
                indexX + (i + 1) <= 8 &&
                indexY - (i + 1) >= 0 &&
                pieceTextList[indexY - (i + 1)][indexX + (i + 1)] != " " &&
                initialRivalAndSelfList[indexY - (i + 1)][indexX + (i + 1)]) ||
            (isRival &&
                indexX + (i + 1) <= 8 &&
                indexY - (i + 1) >= 0 &&
                pieceTextList[indexY - (i + 1)][indexX + (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY - (i + 1)][indexX + (i + 1)]);
        if (indexX + (i + 1) <= 8 &&
            indexY - (i + 1) >= 0 &&
            pieceTextList[indexY - (i + 1)][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY - (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY - (i + 1));
          break;
        } else {
          break;
        }
      }
      //左下の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (!isRival &&
                indexX - (i + 1) >= 0 &&
                indexY + (i + 1) <= 8 &&
                pieceTextList[indexY + (i + 1)][indexX - (i + 1)] != " " &&
                initialRivalAndSelfList[indexY + (i + 1)][indexX - (i + 1)]) ||
            (isRival &&
                indexX - (i + 1) >= 0 &&
                indexY + (i + 1) <= 8 &&
                pieceTextList[indexY + (i + 1)][indexX - (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY + (i + 1)][indexX - (i + 1)]);
        if (indexX - (i + 1) >= 0 &&
            indexY + (i + 1) <= 8 &&
            pieceTextList[indexY + (i + 1)][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY + (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY + (i + 1));
          break;
        } else {
          break;
        }
      }
      //右下の置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (!isRival &&
                indexX + (i + 1) <= 8 &&
                indexY + (i + 1) <= 8 &&
                pieceTextList[indexY + (i + 1)][indexX + (i + 1)] != " " &&
                initialRivalAndSelfList[indexY + (i + 1)][indexX + (i + 1)]) ||
            (isRival &&
                indexX + (i + 1) <= 8 &&
                indexY + (i + 1) <= 8 &&
                pieceTextList[indexY + (i + 1)][indexX + (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY + (i + 1)][indexX + (i + 1)]);
        if (indexX + (i + 1) <= 8 &&
            indexY + (i + 1) <= 8 &&
            pieceTextList[indexY + (i + 1)][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY + (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY + (i + 1));
          break;
        } else {
          break;
        }
      }
    } else if (text == "飛") {
      //上で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (indexY - (i + 1) >= 0 &&
                !isRival &&
                pieceTextList[indexY - (i + 1)][indexX] != " " &&
                initialRivalAndSelfList[indexY - (i + 1)][indexX]) ||
            (indexY - (i + 1) >= 0 &&
                isRival &&
                pieceTextList[indexY - (i + 1)][indexX] != " " &&
                !initialRivalAndSelfList[indexY - (i + 1)][indexX]);
        if (indexY - (i + 1) >= 0 &&
            pieceTextList[indexY - (i + 1)][indexX] == " ") {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY - (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY - (i + 1));
          break;
        } else {
          break;
        }
      }
      //左で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (indexX - (i + 1) >= 0 &&
                !isRival &&
                pieceTextList[indexY][indexX - (i + 1)] != " " &&
                initialRivalAndSelfList[indexY][indexX - (i + 1)]) ||
            (indexX - (i + 1) >= 0 &&
                isRival &&
                pieceTextList[indexY][indexX - (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY][indexX - (i + 1)]);
        if (indexX - (i + 1) >= 0 &&
            pieceTextList[indexY][indexX - (i + 1)] == " ") {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY);
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX - (i + 1));
          installNextLocationY.add(indexY);
          break;
        } else {
          break;
        }
      }
      //右で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (indexX + (i + 1) <= 8 &&
                !isRival &&
                pieceTextList[indexY][indexX + (i + 1)] != " " &&
                initialRivalAndSelfList[indexY][indexX + (i + 1)]) ||
            (indexX + (i + 1) <= 8 &&
                isRival &&
                pieceTextList[indexY][indexX + (i + 1)] != " " &&
                !initialRivalAndSelfList[indexY][indexX + (i + 1)]);
        if (indexX + (i + 1) <= 8 &&
            pieceTextList[indexY][indexX + (i + 1)] == " ") {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY);
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX + (i + 1));
          installNextLocationY.add(indexY);
          break;
        } else {
          break;
        }
      }
      //下で置ける所を候補に入れる
      for (int i = 0; i < 8; i++) {
        bool isEnemyPiece = (indexY + (i + 1) <= 8 &&
                !isRival &&
                pieceTextList[indexY + (i + 1)][indexX] != " " &&
                initialRivalAndSelfList[indexY + (i + 1)][indexX]) ||
            (indexX + (i + 1) <= 8 &&
                isRival &&
                pieceTextList[indexY + (i + 1)][indexX] != " " &&
                !initialRivalAndSelfList[indexY + (i + 1)][indexX]);
        if (indexY + (i + 1) <= 8 &&
            pieceTextList[indexY + (i + 1)][indexX] == " ") {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY + (i + 1));
        } else if (isEnemyPiece) {
          installNextLocationX.add(indexX);
          installNextLocationY.add(indexY + (i + 1));
          break;
        }
      }
    }
    //highLightできるようにリストをソートする
    for (int i = 0; i < installNextLocationY.length - 1; i++) {
      for (int j = 0; j < installNextLocationY.length - 1 - i; j++) {
        if (installNextLocationY[j] < installNextLocationY[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
          int savedDataY = installNextLocationY[j];
          installNextLocationY[j] = installNextLocationY[j + 1];
          installNextLocationY[j + 1] = savedDataY;
        } else if (installNextLocationY[j] == installNextLocationY[j + 1] &&
            installNextLocationX[j] < installNextLocationX[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
        }
      }
    }

    //リストの要素数を20にする
    List<int> addNumberList =
        List.generate(20 - installNextLocationX.length, (index) => -1);
    installNextLocationX.addAll(addNumberList);
    installNextLocationY.addAll(addNumberList);
    //リストを更新する
    state = state.copyWith(
        installLocationXList: installNextLocationX,
        installLocationYList: installNextLocationY);
  }

  void resetInstallLocationList() {
    final List<int> installLocationXList = List.generate(81, (index) => -1);
    final List<int> installLocationYList = List.generate(81, (index) => -1);

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

  //動かせる場所を表示する
  Color? highLight(int indexX, int indexY, List<List<String>> pieceTextList) {
    Color? appColor;
    if (state.step == 2 || state.step == 3) {
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
        appColor = AppColor.white;
      } else {
        appColor = null;
      }
    }
    return appColor;
  }

  void resetIndex() {
    index = 0;
  }

  void next2Step() {
    final step = state.step + 2;
    state = state.copyWith(step: step);
  }

  void updateIsHighLight() {
    isHighLight = false;
  }

  void updateSelectedPieceIndexXY(int indexX, int indexY) {
    state = state.copyWith(
        selectedPieceIndexX: indexX, selectedPieceIndexY: indexY);
  }

  void updateSelfPawn(String text) {
    List<String> selfPawn = [...state.selfPawnList];
    int index = 0;
    for (int i = 0; i < selfPawn.length; i++) {
      if (selfPawn[i] == " ") {
        index = i;
        break;
      }
    }
    selfPawn[index] = text;
    state = state.copyWith(selfPawnList: selfPawn, selfPawnListIndex: index);
  }

  void deleteSelfOrRivalPawn(int selectedIndex, bool isRival) {
    if (!isRival) {
      List<String> selfPawn = [...state.selfPawnList];
      selfPawn[selectedIndex] = " ";
      for (int i = selectedIndex; i < selfPawn.length; i++) {
        if (selfPawn[i + 1] != " ") {
          String savedData = selfPawn[i + 1];
          selfPawn[i + 1] = selfPawn[i];
          selfPawn[i] = savedData;
        } else {
          break;
        }
      }
      state = state.copyWith(selfPawnList: selfPawn);
    } else {
      List<String> rivalPawn = [...state.rivalPawnList];
      rivalPawn[selectedIndex] = " ";
      for (int i = selectedIndex; i < rivalPawn.length; i++) {
        if (rivalPawn[i + 1] != " ") {
          String savedData = rivalPawn[i + 1];
          rivalPawn[i + 1] = rivalPawn[i];
          rivalPawn[i] = savedData;
        } else {
          break;
        }
      }
      state = state.copyWith(rivalPawnList: rivalPawn);
    }
  }

  void updateRivalPawn(String text) {
    List<String> rivalPawn = [...state.rivalPawnList];
    int index = 0;
    for (int i = 0; i < rivalPawn.length; i++) {
      if (rivalPawn[i] == " ") {
        index = i;
        break;
      }
    }
    rivalPawn[index] = text;
    state = state.copyWith(rivalPawnList: rivalPawn, rivalPawnListIndex: index);
  }

  void updateIsRival(bool isRival) {
    state = state.copyWith(isRival: isRival);
  }

  void changeTurn() {
    if (state.isPlayersTurn) {
      state = state.copyWith(isPlayersTurn: false);
    } else {
      state = state.copyWith(isPlayersTurn: true);
    }
  }

  void installIndexWithoutPiecesPlaced(List<List<String>> pieceTextList,
      String text, bool isRival, List<List<bool>> initialRivalAndSelfList) {
    List<int> installNextLocationX = List.generate(81, (index) => -1);
    List<int> installNextLocationY = List.generate(81, (index) => -1);
    int index = 0;
    List<int> withoutNihuLowList = [];
    if (text == "歩" && !isRival) {
      //行に味方の歩があるかどうか判定し、無かったら二歩にならない行の候補をリストに入れる
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][i] == "歩" && !initialRivalAndSelfList[j][i]) {
            break;
          } else if (j == 8) {
            withoutNihuLowList.add(i);
          }
        }
      }

      if (withoutNihuLowList.isEmpty) {
        installNextLocationX = List.generate(81, (index) => -1);
        installNextLocationY = List.generate(81, (index) => -1);
      } else {
        //置いても二歩にならない場所をチョイス
        for (int i = 0; i < withoutNihuLowList.length; i++) {
          for (int j = 0; j < 9; j++) {
            if (pieceTextList[j][withoutNihuLowList[i]] == " ") {
              installNextLocationX[index] = withoutNihuLowList[i];
              installNextLocationY[index] = j;
              index++;
            }
          }
        }
      }
    } else if (text == "歩" && isRival) {
      //行に味方の歩があるかどうか判定し、無かったら二歩にならない行の候補をリストに入れる
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][i] == "歩" && initialRivalAndSelfList[j][i]) {
            break;
          } else if (j == 8) {
            withoutNihuLowList.add(i);
          }
        }
      }

      //置いても二歩にならない場所をチョイス
      for (int i = 0; i < withoutNihuLowList.length; i++) {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][withoutNihuLowList[i]] == " ") {
            installNextLocationX[index] = withoutNihuLowList[i];
            installNextLocationY[index] = j;
            index++;
          }
        }
      }
    } else if (text != "歩") {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][i] == " ") {
            installNextLocationX[index] = i;
            installNextLocationY[index] = j;
            index++;
          }
        }
      }
    }

    for (int i = 0; i < installNextLocationY.length - 1; i++) {
      for (int j = 0; j < installNextLocationY.length - 1 - i; j++) {
        if (installNextLocationY[j] < installNextLocationY[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
          int savedDataY = installNextLocationY[j];
          installNextLocationY[j] = installNextLocationY[j + 1];
          installNextLocationY[j + 1] = savedDataY;
        } else if (installNextLocationY[j] == installNextLocationY[j + 1] &&
            installNextLocationX[j] < installNextLocationX[j + 1]) {
          int savedDataX = installNextLocationX[j];
          installNextLocationX[j] = installNextLocationX[j + 1];
          installNextLocationX[j + 1] = savedDataX;
        }
      }
    }
    state = state.copyWith(
        installLocationXList: installNextLocationX,
        installLocationYList: installNextLocationY);
  }
}
