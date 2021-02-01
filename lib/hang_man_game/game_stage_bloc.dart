import 'dart:async';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_tutorials/hang_man_game/game_stage.dart';
import 'package:rxdart/rxdart.dart';

import 'enum_collection.dart';
import 'guess_word_helper.dart';

class GameStageBloc {
  ValueNotifier<GameState> curGameState =
      ValueNotifier<GameState>(GameState.idle);
  ValueNotifier<String> curGuessWord = ValueNotifier<String>('');
  ValueNotifier<Map<String, String>> question =
      ValueNotifier<Map<String, String>>({"question": '', "answer": ''});
  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>([]);
  ValueNotifier<int> lostpartlength = ValueNotifier<int>(0);
  // StreamController<List<BodyPart>> streamController = StreamController(onListen: (){});

  var _guessedCharactersController = BehaviorSubject<List<String>>();
  Stream<List<String>> get guessedCharacters =>
      _guessedCharactersController.stream;

  void createNewGame() {
    curGameState.value = GameState.running;
    lostParts.value.clear();

    var guessWord = GuessWordHelper().generateRandomWord();
    curGuessWord.value = guessWord;

    var guessedquestion = GuessWordHelper().generateRandomQuestion();
    question.value = {
      'question': guessedquestion['question'].toLowerCase(),
      'answer': guessedquestion['answer'].toUpperCase()
    };

    _guessedCharactersController.sink.add([]);
  }

  void updateGuessedCharacter(List<String> updatedGuessedCharacters) {
    _guessedCharactersController.sink.add(updatedGuessedCharacters);
    _concludeGameOnWordGuessedCorrectly(updatedGuessedCharacters);
  }

  void _concludeGameOnWordGuessedCorrectly(List<String> guessedCharacters) {
    //check if user identified all correct words
    var allValuesIdentified = true;
    // var characters = curGuessWord.value.split('');

    var charcters = question.value['answer'].split('');
    charcters.forEach((letter) {
      // print("the guesed letters $letter");
      // print("up");
      if (!guessedCharacters.contains(letter)) {
        allValuesIdentified = false;
        return;
      }
      // print("down");
    });

    if (allValuesIdentified) {
      curGameState.value = GameState.succed;
    }
  }

  void updateLostBodyParts() {
    print("update parts of body");
    if (!lostParts.value.contains(BodyPart.head)) {
      lostParts.value.add(BodyPart.head);
      lostpartlength.value = lostParts.value.length;
      return;
    }

    if (!lostParts.value.contains(BodyPart.body)) {
      lostParts.value.add(BodyPart.body);
      lostpartlength.value = lostParts.value.length;
      return;
    }

    if (!lostParts.value.contains(BodyPart.leftLeg)) {
      lostParts.value.add(BodyPart.leftLeg);
      lostpartlength.value = lostParts.value.length;
      return;
    }

    if (!lostParts.value.contains(BodyPart.rightLeg)) {
      lostParts.value.add(BodyPart.rightLeg);
      lostpartlength.value = lostParts.value.length;
      return;
    }

    if (!lostParts.value.contains(BodyPart.leftHand)) {
      lostParts.value.add(BodyPart.leftHand);
      lostpartlength.value = lostParts.value.length;
      return;
    }

    if (!lostParts.value.contains(BodyPart.rightHand)) {
      lostParts.value.add(BodyPart.rightHand);
      lostpartlength.value = lostParts.value.length;

      // player has lost all body parts.
      curGameState.value = GameState.failed;
      return;
    }
  }
}
