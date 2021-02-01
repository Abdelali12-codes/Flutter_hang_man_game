import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:hang_man_game/hang_man_game/hang_man_game.dart';
import 'package:hang_man_game/hang_man_game/hang_man_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HangManState hangManState;
  @override
  void initState() {
    hangManState = HangManState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<HangManState>(
        appState: hangManState, child: MaterialPage1());
  }
}

class MaterialPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HangManGame(),
    );
  }
}
