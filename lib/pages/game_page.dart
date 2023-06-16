import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';
import 'package:shogi_game/providers/game_system_notifier.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

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
                      const Text(
                        AppText.yourTurn,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    if (!isPlayersTurn)
                      const Text(
                        AppText.cpuTurn,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    const Expanded(
                      child: Text(
                        AppText.cpu,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
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
                          RotationTransition(
                            turns: const AlwaysStoppedAnimation(180 / 360),
                            child: Text(
                              rivalPawn[i],
                              style: const TextStyle(
                                fontSize: 25,
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
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
                          Text(
                            selfPawn[i],
                            style: const TextStyle(
                              fontSize: 25,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
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
                  const Text(
                    "吉田",
                    style: TextStyle(
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

  Widget _board(String text, WidgetRef ref, int indexX, int indexY) {
    final gameSystemNotifier = ref.read(gameSystemProvider.notifier);
    final step = ref.watch(gameSystemProvider.select((value) => value.step));
    final isRival =
        ref.watch(gameSystemProvider.select((value) => value.isRival));
    return GestureDetector(
      onTap: () {
        if (step == 1) {
          gameSystemNotifier
              .updateIsRival(initialRivalAndSelfList[indexY][indexX]);
          gameSystemNotifier.updateSelectedPieceIndexXY(indexX, indexY);
          gameSystemNotifier.nextLocation(text, indexX, indexY, pieceTextList,
              initialRivalAndSelfList[indexY][indexX], initialRivalAndSelfList);
          gameSystemNotifier.nextStep();
        }
        if (step == 2) {
          nextLocation(pieceTextList, indexX, indexY, ref,
              initialRivalAndSelfList, isRival);
          gameSystemNotifier.resetInstallLocationList();
          gameSystemNotifier.changeTurn();
          gameSystemNotifier.resetIndex();
          gameSystemNotifier.updateIsHighLight();
          gameSystemNotifier.resetStep();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.black, width: 0.5),
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
