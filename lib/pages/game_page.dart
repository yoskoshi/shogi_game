import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/providers/game_system_notifier.dart';
import 'package:shogi_game/providers/one_player_game_setting_notifier.dart';
import 'package:shogi_game/providers/two_player_game_setting_notifier.dart';

class GamePage extends ConsumerStatefulWidget {
  final BattleNumber battleNumber;
  const GamePage({Key? key, required this.battleNumber}) : super(key: key);

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  final pieceTextList = [
    ["香", "桂", "銀", "金", "玉", "金", "銀", "桂", "香"],
    [" ", "飛", " ", " ", " ", " ", " ", "角", " "],
    ["歩", "歩", "歩", "歩", "歩", "歩", "歩", "歩", "歩"],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    ["歩", "歩", "歩", "歩", "歩", "歩", "歩", "歩", "歩"],
    [" ", "角", " ", " ", " ", " ", " ", "飛", " "],
    ["香", "桂", "銀", "金", "王", "金", "銀", "桂", "香"],
  ];
  final initialRivalAndSelfList = [
    [true, true, true, true, true, true, true, true, true],
    [false, true, false, false, false, false, false, true, false],
    [true, true, true, true, true, true, true, true, true],
    [false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false],
  ];
  int index = -1;
  int selectedIndex = 0;
  bool isRivalPiecePlaced = false;
  Color selfPawnColor = Colors.transparent;
  Color rivalPawnColor = Colors.transparent;
  int selectedIndexX = -1, selectedIndexY = -1;
  @override
  Widget build(BuildContext context) {
    final isPlayersTurn =
        ref.watch(gameSystemProvider.select((value) => value.isPlayersTurn));
    final selfPawn =
        ref.watch(gameSystemProvider.select((value) => value.selfPawnList));
    final rivalPawn =
        ref.watch(gameSystemProvider.select((value) => value.rivalPawnList));
    final rivalPawnListIndex = ref
        .watch(gameSystemProvider.select((value) => value.rivalPawnListIndex));
    final selfPawnListIndex = ref
        .watch(gameSystemProvider.select((value) => value.selfPawnListIndex));
    final step = ref.watch(gameSystemProvider.select((value) => value.step));
    final gameSystemNotifier = ref.read(gameSystemProvider.notifier);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImagePath.tatamiImagePath),
              fit: BoxFit.cover,
            )),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 390,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(ImagePath.shogiTableImagePath),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    if (isPlayersTurn)
                      Text(
                        displayFirstTurn(widget.battleNumber),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    if (!isPlayersTurn)
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(180 / 360),
                        child: Text(
                          disPlaySecondTurn(widget.battleNumber),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    Expanded(child: Container()),
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(180 / 360),
                      child: Expanded(
                        child: Text(
                          frontName(widget.battleNumber),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                  ],
                ),
              ),
              if (selfPawnListIndex != -1) ...{
                const SizedBox(height: 130),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < rivalPawnListIndex + 1; i++) ...{
                        if (rivalPawn[i] != " ") ...{
                          GestureDetector(
                            onTap: () {
                              if (step == 1) {
                                gameSystemNotifier
                                    .installIndexWithoutPiecesPlaced(
                                        pieceTextList,
                                        rivalPawn[i],
                                        true,
                                        initialRivalAndSelfList);
                                rivalPawnColor = const Color(0xFFFFFFFF);
                                selectedIndex = i;
                                isRivalPiecePlaced = true;
                                gameSystemNotifier.next2Step();
                              }
                              if (step == 3) {
                                rivalPawnColor = Colors.transparent;
                                gameSystemNotifier.resetInstallLocationList();
                                gameSystemNotifier.updateIsHighLight();
                                gameSystemNotifier.resetIndex();
                                gameSystemNotifier.resetStep();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              color: i == selectedIndex
                                  ? rivalPawnColor
                                  : Colors.transparent,
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: Text(
                                  rivalPawn[i],
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        },
                        const SizedBox(width: 8),
                      }
                    ],
                  ),
                ),
              },
              Expanded(child: Container()),
              if (selfPawnListIndex != -1) ...{
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < selfPawnListIndex + 1; i++) ...{
                        if (selfPawn[i] != " ") ...{
                          GestureDetector(
                            onTap: () {
                              if (step == 1) {
                                gameSystemNotifier
                                    .installIndexWithoutPiecesPlaced(
                                        pieceTextList,
                                        selfPawn[i],
                                        false,
                                        initialRivalAndSelfList);
                                selfPawnColor = const Color(0xFFFFFFFF);
                                selectedIndex = i;
                                isRivalPiecePlaced = false;
                                gameSystemNotifier.next2Step();
                              }
                              if (step == 3) {
                                selfPawnColor = Colors.transparent;
                                gameSystemNotifier.resetInstallLocationList();
                                gameSystemNotifier.updateIsHighLight();
                                gameSystemNotifier.resetIndex();
                                gameSystemNotifier.resetStep();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              color: i == selectedIndex
                                  ? selfPawnColor
                                  : Colors.transparent,
                              child: Text(
                                selfPawn[i],
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        },
                        const SizedBox(width: 8),
                      }
                    ],
                  ),
                ),
              },
              const SizedBox(height: 100),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Text(
                    backName(widget.battleNumber),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                  Expanded(child: Container()),
                  Column(children: const [
                    Text(
                      AppText.haveTime,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "10:00",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ]),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 15, bottom: 15),
            child: Column(
              children: [
                Expanded(child: Container()),
                for (int i = 0; i < 9; i++) ...{
                  Row(
                    children: [
                      for (int j = 0; j < 9; j++) ...{
                        _board(
                          pieceTextList[i][j],
                          ref,
                          j,
                          i,
                        ),
                      }
                    ],
                  )
                },
                Expanded(child: Container()),
              ],
            ),
          ),
        ],
      )),
    );
  }

  String frontName(BattleNumber battleNumber) {
    final twoPlayerSecondName = ref.watch(
        twoPlayersGameSettingProvider.select((value) => value.secondMoveName));
    if (battleNumber == BattleNumber.onePlayer) {
      return AppText.cpu;
    } else {
      return twoPlayerSecondName;
    }
  }

  String backName(BattleNumber battleNumber) {
    final onePlayerName =
        ref.watch(onePlayerGameSettingProvider.select((value) => value.name));
    final twoPlayersFirstName = ref.watch(
        twoPlayersGameSettingProvider.select((value) => value.firstMoveName));
    if (battleNumber == BattleNumber.onePlayer) {
      return onePlayerName;
    } else {
      return twoPlayersFirstName;
    }
  }

  String displayFirstTurn(BattleNumber battleNumber) {
    final onePlayerName =
        ref.watch(onePlayerGameSettingProvider.select((value) => value.name));
    final twoPlayersFirstName = ref.watch(
        twoPlayersGameSettingProvider.select((value) => value.firstMoveName));
    if (battleNumber == BattleNumber.onePlayer) {
      return "$onePlayerNameの番です";
    } else {
      return "$twoPlayersFirstNameの番です";
    }
  }

  String disPlaySecondTurn(BattleNumber battleNumber) {
    final twoPlayersSecondName = ref.watch(
        twoPlayersGameSettingProvider.select((value) => value.secondMoveName));
    if (battleNumber == BattleNumber.onePlayer) {
      return "${AppText.cpu}の番です";
    } else {
      return "$twoPlayersSecondNameの番です";
    }
  }

  Widget _board(String text, WidgetRef ref, int indexX, int indexY) {
    final gameSystemNotifier = ref.read(gameSystemProvider.notifier);
    final step = ref.watch(gameSystemProvider.select((value) => value.step));
    final isRival =
        ref.watch(gameSystemProvider.select((value) => value.isRival));
    return GestureDetector(
      onTap: () {
        if (step == 1 && pieceTextList[indexY][indexX] != " ") {
          gameSystemNotifier
              .updateIsRival(initialRivalAndSelfList[indexY][indexX]);
          gameSystemNotifier.updateSelectedPieceIndexXY(indexX, indexY);
          gameSystemNotifier.nextLocation(text, indexX, indexY, pieceTextList,
              initialRivalAndSelfList[indexY][indexX], initialRivalAndSelfList);
          selectedIndexX = indexX;
          selectedIndexY = indexY;
          gameSystemNotifier.nextStep();
        }
        if (step == 2) {
          nextLocation(pieceTextList, indexX, indexY, ref,
              initialRivalAndSelfList, isRival);
          gameSystemNotifier.resetInstallLocationList();
          gameSystemNotifier.resetIndex();
          gameSystemNotifier.updateIsHighLight();
          selectedIndexX = -1;
          selectedIndexY = -1;
          gameSystemNotifier.resetStep();
        }
        if (step == 3) {
          nextLocationOfPiecePlaced(isRivalPiecePlaced, pieceTextList,
              initialRivalAndSelfList, indexY, indexX);
          gameSystemNotifier.resetInstallLocationList();
          gameSystemNotifier.resetIndex();
          gameSystemNotifier.updateIsHighLight();
          gameSystemNotifier.resetStep();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(
              color: indexY == selectedIndexY && indexX == selectedIndexX
                  ? Colors.redAccent
                  : AppColor.black,
              width: indexY == selectedIndexY && indexX == selectedIndexX
                  ? 2
                  : 0.5),
          color: gameSystemNotifier.highLight(indexX, indexY, pieceTextList),
        ),
        child: Center(
          child: initialRivalAndSelfList[indexY][indexX]
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ),
    );
  }

  void nextLocationOfPiecePlaced(bool isRival, List<List<String>> pieceTextList,
      List<List<bool>> initialRivalAndSelfList, int indexY, int indexX) {
    final selfPawn =
        ref.watch(gameSystemProvider.select((value) => value.selfPawnList));
    final rivalPawn =
        ref.watch(gameSystemProvider.select((value) => value.rivalPawnList));
    final installNextLocationX = ref.watch(
        gameSystemProvider.select((value) => value.installLocationXList));
    final installNextLocationY = ref.watch(
        gameSystemProvider.select((value) => value.installLocationYList));
    final gameSystemNotifier = ref.read(gameSystemProvider.notifier);
    for (int i = 0; i < installNextLocationX.length; i++) {
      if (!isRival && selfPawn[selectedIndex] == "歩") {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][indexX] == "歩" &&
              !initialRivalAndSelfList[j][indexX]) {
            selfPawnColor = Colors.transparent;
            return;
          }
        }
      } else if (isRival && rivalPawn[selectedIndex] == "歩") {
        for (int j = 0; j < 9; j++) {
          if (pieceTextList[j][indexX] == "歩" &&
              initialRivalAndSelfList[j][indexX]) {
            rivalPawnColor = Colors.transparent;
            return;
          }
        }
      }
      if (!isRival &&
          indexX == installNextLocationX[i] &&
          indexY == installNextLocationY[i]) {
        pieceTextList[indexY][indexX] = selfPawn[selectedIndex];
        initialRivalAndSelfList[indexY][indexX] = isRival;
        gameSystemNotifier.deleteSelfOrRivalPawn(selectedIndex, isRival);
        gameSystemNotifier.changeTurn();
        selectedIndex = 0;
      } else if (isRival &&
          indexX == installNextLocationX[i] &&
          indexY == installNextLocationY[i]) {
        pieceTextList[indexY][indexX] = rivalPawn[selectedIndex];
        initialRivalAndSelfList[indexY][indexX] = isRival;
        gameSystemNotifier.deleteSelfOrRivalPawn(selectedIndex, isRival);
        gameSystemNotifier.changeTurn();
        selectedIndex = 0;
      } else if (!isRival) {
        selfPawnColor = Colors.transparent;
      } else if (isRival) {
        rivalPawnColor = Colors.transparent;
      }
    }
  }

  List<List<String>> nextLocation(
      List<List<String>> pieceTextList,
      int indexX,
      int indexY,
      WidgetRef ref,
      List<List<bool>> initialRivalAndSelfList,
      bool isRival) {
    final installNextLocationXList = ref.watch(
        gameSystemProvider.select((value) => value.installLocationXList));
    final installNextLocationYList = ref.watch(
        gameSystemProvider.select((value) => value.installLocationYList));
    final selectedPieceIndexX = ref
        .watch(gameSystemProvider.select((value) => value.selectedPieceIndexX));
    final selectedPieceIndexY = ref
        .watch(gameSystemProvider.select((value) => value.selectedPieceIndexY));
    final gameSystemNotifier = ref.read(gameSystemProvider.notifier);
    for (int i = 0; i < installNextLocationXList.length; i++) {
      if (indexX == installNextLocationXList[i] &&
          indexY == installNextLocationYList[i]) {
        if (!isRival &&
            pieceTextList[indexY][indexX] != " " &&
            initialRivalAndSelfList[indexY][indexX]) {
          setState(() {
            gameSystemNotifier.updateSelfPawn(pieceTextList[indexY][indexX]);
            pieceTextList[indexY][indexX] =
                pieceTextList[selectedPieceIndexY][selectedPieceIndexX];
            pieceTextList[selectedPieceIndexY][selectedPieceIndexX] = " ";
            initialRivalAndSelfList[indexY][indexX] =
                initialRivalAndSelfList[selectedPieceIndexY]
                    [selectedPieceIndexX];
            initialRivalAndSelfList[selectedPieceIndexY][selectedPieceIndexX] =
                false;
            gameSystemNotifier.changeTurn();
          });
        } else if (isRival &&
            pieceTextList[indexY][indexX] != " " &&
            !initialRivalAndSelfList[indexY][indexX]) {
          setState(() {
            gameSystemNotifier.updateRivalPawn(pieceTextList[indexY][indexX]);
            pieceTextList[indexY][indexX] =
                pieceTextList[selectedPieceIndexY][selectedPieceIndexX];
            pieceTextList[selectedPieceIndexY][selectedPieceIndexX] = " ";
            initialRivalAndSelfList[indexY][indexX] =
                initialRivalAndSelfList[selectedPieceIndexY]
                    [selectedPieceIndexX];
            initialRivalAndSelfList[selectedPieceIndexY][selectedPieceIndexX] =
                false;
            gameSystemNotifier.changeTurn();
          });
        } else {
          setState(() {
            pieceTextList[indexY][indexX] =
                pieceTextList[selectedPieceIndexY][selectedPieceIndexX];
            pieceTextList[selectedPieceIndexY][selectedPieceIndexX] = " ";
            initialRivalAndSelfList[indexY][indexX] =
                initialRivalAndSelfList[selectedPieceIndexY]
                    [selectedPieceIndexX];
            initialRivalAndSelfList[selectedPieceIndexY][selectedPieceIndexX] =
                false;
            gameSystemNotifier.changeTurn();
          });
        }
      }
    }
    return pieceTextList;
  }

  int nextIndex() {
    setState(() {
      index++;
    });
    return index;
  }
}
