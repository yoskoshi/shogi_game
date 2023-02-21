import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';
import 'package:shogi_game/pages/many_players_tournament_table_page.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/providers/many_players_game_setting_notifier.dart';
import 'package:shogi_game/ui_component/button.dart';
import 'package:shogi_game/ui_component/input_name.dart';

class ManyPlayersNameSettingPage extends ConsumerWidget {
  ManyPlayersNameSettingPage({Key? key}) : super(key: key);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();
  final TextEditingController controller7 = TextEditingController();
  final TextEditingController controller8 = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int numberOfPeople = convertNumberOfPeopleInt(ref);
    final List<TextEditingController> controllerList = [
      controller1,
      controller2,
      controller3,
      controller4,
      controller5,
      controller6,
      controller7,
      controller8
    ];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    AppColor.luminosityColor, BlendMode.luminosity),
                image: AssetImage(ImagePath.backgroundImagePath),
                fit: BoxFit.cover,
              )),
            ),
            Column(
              children: [
                Expanded(flex: 13, child: Container()),
                const Text(
                  AppText.nameEnglishVer,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                    fontFamily: AppText.moul,
                  ),
                ),
                Expanded(flex: 7, child: Container()),
                Container(
                  height: 340,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColor.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 17, right: 23, bottom: 29),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 500),
                        child: Column(
                          children: [
                            for (int i = 0; i < numberOfPeople; i++) ...{
                              InputName(
                                controller: controllerList[i],
                                battleNumber: BattleNumber.manyPlayers,
                                index: i,
                              ),
                              if (i != numberOfPeople - 1)
                                const SizedBox(height: 10),
                            }
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 7, child: Container()),
                Button(
                    buttonText: AppText.createTournamentTable,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const ManyPlayersTournamentTablePage()));
                    }),
                const SizedBox(height: 109),
              ],
            )
          ],
        ));
  }

  int convertNumberOfPeopleInt(WidgetRef ref) {
    final manyPlayersGameSetting = ref.watch(manyPlayersGameSettingProvider);
    if (manyPlayersGameSetting.numberOfPeople == AppText.threePeople) {
      return 3;
    } else if (manyPlayersGameSetting.numberOfPeople == AppText.fourPeople) {
      return 4;
    } else if (manyPlayersGameSetting.numberOfPeople == AppText.fivePeople) {
      return 5;
    } else if (manyPlayersGameSetting.numberOfPeople == AppText.sixPeople) {
      return 6;
    } else if (manyPlayersGameSetting.numberOfPeople == AppText.sevenPeople) {
      return 7;
    } else {
      return 8;
    }
  }
}
