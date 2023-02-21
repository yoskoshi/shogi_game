import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';

class GamePage extends ConsumerWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              width: MediaQuery.of(context).size.width,
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
                  children: const [
                    Text(
                      AppText.yourTurn,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                    Expanded(
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
                    SizedBox(width: 22),
                  ],
                ),
              ),
              Expanded(child: Container()),
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
          Column(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++) ...{
                      const Divider(
                        thickness: 1,
                        height: 0,
                        color: AppColor.black,
                      ),
                      if (i != 9) const SizedBox(height: 40),
                    }
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    for (int i = 0; i < 10; i++) ...{
                      Container(
                        height: 360,
                        width: 1,
                        decoration: const BoxDecoration(
                          color: AppColor.black,
                        ),
                      ),
                      if (i != 9)
                        SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 40) / 9),
                    }
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          )
        ],
      )),
    );
  }
}
