import 'package:flutter/material.dart';
import 'package:hang_man_game/hang_man_game/game_stage_bloc.dart';

class CharacterPicker extends StatefulWidget {
  final GameStageBloc gameStageBloc;
  CharacterPicker({this.gameStageBloc});
  @override
  _CharacterPickerState createState() => _CharacterPickerState();
}

class _CharacterPickerState extends State<CharacterPicker> {
  var _alphabets = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var alphabetArr = _alphabets.split(",");

    return StreamBuilder(
        stream: widget.gameStageBloc.guessedCharacters,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]),
            );
          return Container(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(alphabetArr.length, (index) {
                var letter = alphabetArr[index];
                return _buildSingleCharacter(snapshot.data, letter);
              }),
            ),
          );
        });
  }

  Widget _buildSingleCharacter(List<String> guessedLetters, String letter) {
    return GestureDetector(
      onTap: () {
        if (!guessedLetters.contains(letter)) {
          guessedLetters.add(letter);
          widget.gameStageBloc.updateGuessedCharacter(guessedLetters);

          // if (widget.gameStageBloc.curGuessWord.value.indexOf(letter) < 0) {
          //   widget.gameStageBloc.updateLostBodyParts();
          // }

          if (widget.gameStageBloc.question.value['answer'].indexOf(letter) <
              0) {
            widget.gameStageBloc.updateLostBodyParts();
          }
        }
      },
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
            color: guessedLetters.contains(letter) ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(4.0)),
        child: Center(child: Text(letter)),
      ),
    );
  }
}
