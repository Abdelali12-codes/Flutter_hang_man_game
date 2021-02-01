import 'package:flutter/material.dart';
import 'package:hang_man_game/hang_man_game/characted_picker.dart';
import 'package:hang_man_game/hang_man_game/enum_collection.dart';
import 'package:hang_man_game/hang_man_game/game_stage_bloc.dart';
import 'package:hang_man_game/hang_man_game/hang_man_state.dart';
import 'package:hang_man_game/hang_man_game/puzzle.dart';
import 'package:frideos/frideos.dart';

class GameStage extends StatefulWidget {
  @override
  _GameStageState createState() => _GameStageState();
}

enum Limb { left, right }

class _GameStageState extends State<GameStage> {
  GameStageBloc _gameStageBloc;
  @override
  void initState() {
    super.initState();
    _gameStageBloc = GameStageBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQd = MediaQuery.of(context).size;
    var hangManState = AppStateProvider.of<HangManState>(context);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red[100]])),
          padding: EdgeInsets.all(24.0),
          width: mediaQd.width,
          height: mediaQd.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ValueListenableBuilder(
                  valueListenable: _gameStageBloc.lostpartlength,
                  builder: (context, length, child) {
                    // print("lost body $length");
                    return Container(
                        width: 270,
                        height: mediaQd.height,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        child: CustomPaint(
                          painter:
                              HangManPainter(gameStageBloc: _gameStageBloc),
                          size: Size(
                            (270 - 24.0),
                            (mediaQd.height - 24.0),
                          ),
                        ));
                  }),
              Expanded(
                child: Container(
                    child: ValueListenableBuilder(
                  // valueListenable: _gameStageBloc.curGuessWord,
                  valueListenable: _gameStageBloc.question,
                  builder: (BuildContext ctxt, Map<String, String> question,
                      Widget child) {
                    if (question == null ||
                        question['question'] == '' ||
                        question['answer'] == '') {
                      return Center(
                          child: RaisedButton(
                        child: Text('Start New Game'),
                        onPressed: () {
                          _gameStageBloc.createNewGame();
                        },
                      ));
                    }

                    return ValueListenableBuilder(
                        valueListenable: _gameStageBloc.curGameState,
                        builder: (BuildContext ctxt, GameState gameState,
                            Widget child) {
                          print("listenable");
                          if (gameState == GameState.succed) {
                            return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Well done! You got the right answer.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                  RaisedButton(
                                    child: Text('Start New Game'),
                                    onPressed: () {
                                      _gameStageBloc.createNewGame();
                                    },
                                  )
                                ]);
                          }

                          if (gameState == GameState.failed) {
                            return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Oops you failed!',
                                      style: TextStyle(
                                          // color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'The correct word was: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16.0)),
                                      TextSpan(
                                          text:
                                              // _gameStageBloc.curGuessWord.value,
                                              question['answer'].toUpperCase(),
                                          style: TextStyle(
                                              // color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0))
                                    ]),
                                  ),
                                  RaisedButton(
                                    child: Text('Start New Game'),
                                    onPressed: () {
                                      _gameStageBloc.createNewGame();
                                    },
                                  )
                                ]);
                          }

                          return SingleChildScrollView(
                            child: ValueBuilder(
                              streamed: hangManState.counter,
                              builder: (context, snapshot) => Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        question['question'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),

                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.restore,
                                      //     color: Colors.white,
                                      //     size: 24.0,
                                      //   ),
                                      //   onPressed: () {
                                      //     _gameStageBloc.createNewGame();
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CharacterPicker(
                                    gameStageBloc: _gameStageBloc,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Puzzle(
                                    question: question,
                                    // guessWord: guessWord,
                                    gameStageBloc: _gameStageBloc,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RaisedButton(
                                      child: Text("${snapshot.data}"),
                                      onPressed: () {
                                        // if (snapshot.data >= 10) {
                                        //   hangManState.decrement();
                                        // }
                                        hangManState.decrement();
                                      }),
                                  // StreamBuilder(
                                  //     stream: hangManState
                                  //         .streamedKey.outTransformed,
                                  //     builder: (context, snapshot) {})
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )),
              )
            ],
          )),
    );
  }
}

class HangManPainter extends CustomPainter {
  final GameStageBloc gameStageBloc;
  double _headHeight = 32.0;
  HangManPainter({this.gameStageBloc});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    _drawFrame(canvas, size, paint);
    _drawNoose(canvas, size, paint);
    if (gameStageBloc.lostParts.value.contains(BodyPart.head)) {
      _drawHead(canvas, size, paint);
    }
    if (gameStageBloc.lostParts.value.contains(BodyPart.body)) {
      _drawBody(canvas, size, paint);
    }
    if (gameStageBloc.lostParts.value.contains(BodyPart.leftLeg)) {
      _drawLeg(canvas, size, paint, Limb.left);
    }
    if (gameStageBloc.lostParts.value.contains(BodyPart.rightLeg)) {
      _drawLeg(canvas, size, paint, Limb.right);
    }
    if (gameStageBloc.lostParts.value.contains(BodyPart.leftHand)) {
      _drawHand(canvas, size, paint, Limb.left);
    }
    if (gameStageBloc.lostParts.value.contains(BodyPart.rightHand)) {
      _drawHand(canvas, size, paint, Limb.right);
    }
  }

  _drawFrame(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(Rect.fromLTRB(0, size.height, 12, 0), paint);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width / 2, 12), paint);
  }

  _drawNoose(Canvas canvas, Size size, Paint paint) {
    var nooseStart = Offset(size.width / 2, 0);
    var nooseEnd = Offset(size.width / 2, size.height / 5);

    paint.strokeWidth = 8.0;
    canvas.drawLine(nooseStart, nooseEnd, paint);
  }

  _drawHead(Canvas canvas, Size size, Paint paint) {
    paint
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    var nooseEnd = Offset(size.width / 2, size.height / 5);
    canvas.drawCircle(nooseEnd, _headHeight, paint);
  }

  _drawBody(Canvas canvas, Size size, Paint paint) {
    paint..color = Colors.blueAccent;
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);
    var bodyEnd = Offset(size.width / 2, bodyStart.dy + (3 * _headHeight));

    paint..strokeWidth = 8.0;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, (bodyStart.dy + bodyEnd.dy) / 2),
            height: _headHeight * 3,
            width: _headHeight * 2),
        paint);
  }

  _drawLeg(Canvas canvas, Size size, Paint paint, Limb limb) {
    paint.color = Colors.yellowAccent;
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);

    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var legStart = Offset(dxStart, bodyStart.dy + (3 * _headHeight));

    var dxEnd = limb == Limb.left ? size.width / 2 - 32 : size.width / 2 + 32;
    var legEnd = Offset(dxEnd, legStart.dy + (3 * _headHeight));
    paint.strokeWidth = 8.0;
    canvas.drawLine(legStart, legEnd, paint);
  }

  _drawHand(Canvas canvas, Size size, Paint paint, Limb limb) {
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);
    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var handStart = Offset(dxStart, bodyStart.dy);
    var dx = limb == Limb.left ? size.width / 2 - 64 : size.width / 2 + 64;

    var handEnd = Offset(dx, handStart.dy + (2.5 * _headHeight));

    paint..strokeWidth = 8.0;
    canvas.drawLine(handStart, handEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
