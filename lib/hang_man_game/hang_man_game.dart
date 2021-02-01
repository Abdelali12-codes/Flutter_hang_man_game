import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hang_man_game/hang_man_game/game_stage.dart';

class HangManGame extends StatefulWidget {
  @override
  _HangManGameState createState() => _HangManGameState();
}

class _HangManGameState extends State<HangManGame> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameStage();
  }
}
