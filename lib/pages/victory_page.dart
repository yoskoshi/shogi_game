import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/movie/movie_widget.dart';

class VictoryPage extends StatelessWidget {
  const VictoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black.withOpacity(0.7),
      body: Column(
        children: [
          Expanded(flex: 7, child: Container()),
          const MovieWidget(movieURL: "images/victory_trophy.mp4"),
          const SizedBox(height: 102),
          victoryPageText("吉田   さん", 45),
          const SizedBox(height: 69),
          victoryPageText(AppText.victory, 45),
          const SizedBox(height: 109),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 48,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {},
              child: victoryPageText(AppText.backToTop, 20),
            ),
          ),
          Expanded(flex: 10, child: Container()),
        ],
      ),
    );
  }

  Widget victoryPageText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColor.white,
      ),
    );
  }
}
