import 'package:flutter/material.dart';
import 'package:hang_man_game/hang_man_game/game_stage_bloc.dart';

class Puzzle extends StatefulWidget {
  final String guessWord;
  final Map<String, String> question;
  final GameStageBloc gameStageBloc;

  Puzzle({this.guessWord, this.gameStageBloc, this.question});
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  // int _selectedBoxIndex = 0;

  // void _updateSelectedIndex(int i) {
  //   setState(() {
  //     _selectedBoxIndex = i;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.gameStageBloc.guessedCharacters,
        builder: (BuildContext ctxt,
            AsyncSnapshot<List<String>> guessedLettersSnap) {
          if (!guessedLettersSnap.hasData) return CircularProgressIndicator();
          // print("the data ${guessedLettersSnap.data}");
          return Container(
              child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children:
                      List.generate(widget.question['answer'].length, (i) {
                    // widget.guessWord.length
                    // var letter = widget.guessWord[i];
                    var letter = widget.question['answer'][i];
                    var letterGuessedCorrectly =
                        guessedLettersSnap.data.contains(letter);

                    return _buildSingleCharacterBox(
                        letter, letterGuessedCorrectly);
                  })));
        });
  }

  Widget _buildSingleCharacterBox(String letter, bool letterGuessedCorrectly) {
    return Container(
      height: 48.0,
      width: 48.0,
      decoration: BoxDecoration(
          color: letterGuessedCorrectly ? Colors.limeAccent : Colors.white,
          borderRadius: BorderRadius.circular(4.0)),
      child: letterGuessedCorrectly
          ? Center(
              child: Text(
                letter,
                style: _guessedCharacterStyle,
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }

  TextStyle _guessedCharacterStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}
