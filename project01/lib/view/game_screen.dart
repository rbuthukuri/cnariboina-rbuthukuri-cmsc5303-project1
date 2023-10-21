import 'package:flutter/material.dart';
import 'package:project01/controller/game_controller.dart';
import 'package:project01/main.dart';
import 'package:project01/model/cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static const routeName = '/game_screen';

  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}

class GameState extends State<GameScreen> {
  late GameController con;
  late FlutterGame model;
  bool isGameStarted = false;
  bool isCheatEnabled = false; // Track the state of the cheat switch
  final Cards cards = Cards();
  bool showTextBelowPlayButton = false;
  bool playbuttonenabler = true;
  bool newbuttonenbler = false;
  String img1 = "images/game.png";
  String img2 = "images/game.png";
  String img3 = "images/game.png";

  @override
  void initState() {
    super.initState();
    model = const FlutterGame();
    con = GameController(() {
      setState(() {
        isGameStarted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where is the Flutter?'),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 91, 244),
      body: isGameStarted
          ? Stack(
              children: [
                Container(
                  color: cards.gamebalance == 0 && playbuttonenabler == false
                      ? Colors.yellow
                      : Colors.white,
                  child: Column(
                    children: [
                      if (cards.gamebalance == 0 && playbuttonenabler == false)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'You are broke',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      if (cards.gamebalance == 0 && playbuttonenabler == false)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              cards.generateWinningPosition();
                              isGameStarted = false;
                            });
                          },
                          child: const Text('Restart'),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Cheat Key:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Switch(
                            value: isCheatEnabled,
                            onChanged: (value) {
                              setState(() {
                                isCheatEnabled = value;
                              });
                            },
                          ),
                        ],
                      ),
                      if (isCheatEnabled) // Only show the SECRET text when cheat is enabled
                        Text(
                          'SECRET: Flutter is at-${cards.winningPosition}', // Add your Firestore data here
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      Text(
                        'Balance: ${cards.gamebalance}', // Add your balance data here
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CardHolder(
                              cardValue: cards.a,
                              onIncrement: () {
                                setState(() {
                                  if (cards.gamebalance != 0) {
                                    cards.a += 1;
                                    cards.gamebalance--;
                                  }
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  if (cards.a > 0) {
                                    cards.a -= 1;
                                    cards.gamebalance++;
                                  }
                                });
                              },
                              imagepath: img1,
                            ),
                          ),
                          const SizedBox(
                            width:
                                16.0, // Adjust the width to the desired spacing
                          ),
                          Expanded(
                            child: CardHolder(
                              cardValue: cards.b,
                              onIncrement: () {
                                setState(() {
                                  if (cards.gamebalance != 0) {
                                    cards.b += 1;
                                    cards.gamebalance--;
                                  }
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  if (cards.b > 0) {
                                    cards.b -= 1;
                                    cards.gamebalance++;
                                  }
                                });
                              },
                              imagepath: img2,
                            ),
                          ),
                          const SizedBox(
                            width:
                                16.0, // Adjust the width to the desired spacing
                          ), // Adjust the width to the desired spacing
                          Expanded(
                            child: CardHolder(
                              cardValue: cards.c,
                              onIncrement: () {
                                setState(() {
                                  if (cards.gamebalance != 0) {
                                    cards.c += 1;
                                    cards.gamebalance--;
                                  }
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  if (cards.c > 0) {
                                    cards.c -= 1;
                                    cards.gamebalance++;
                                  }
                                });
                              },
                              imagepath: img3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 200.0),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed:
                            cards.a + cards.b + cards.c > 0 && playbuttonenabler
                                ? () {
                                    setState(() {
                                      showTextBelowPlayButton = true;
                                      newbuttonenbler = true;
                                      cards.winningPosition == 0
                                          ? img1 = 'images/flutter.png'
                                          : img1 = 'images/empty.png';
                                      cards.winningPosition == 1
                                          ? img2 = 'images/flutter.png'
                                          : img2 = 'images/empty.png';
                                      cards.winningPosition == 2
                                          ? img3 = 'images/flutter.png'
                                          : img3 = 'images/empty.png';
                                      num winningamount = 0;
                                      num winningcoins = 0;
                                      if (cards.winningPosition == 0) {
                                        winningamount = (3 * cards.a);
                                        winningcoins = cards.a;
                                      } else if (cards.winningPosition == 1) {
                                        winningamount = 3 * cards.b;
                                        winningcoins = cards.b;
                                      } else if (cards.winningPosition == 2) {
                                        winningamount = 3 * cards.c;
                                        winningcoins = cards.c;
                                      }
                                      cards.gamebalance += winningamount;
                                      cards.winningmessage(
                                          winningcoins, winningamount);
                                      if (cards.gamebalance != 0) {
                                        newbuttonenbler = true;
                                      }
                                      playbuttonenabler = false;
                                    });
                                  }
                                : null,
                        child: const Text('Play'),
                      ),
                      const SizedBox(height: 24.0),
                      if (showTextBelowPlayButton)
                        Container(
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cards.msgw,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16.0, // Adjust the position as needed
                  right: 16.0, // Adjust the position as needed
                  child: FloatingActionButton(
                    onPressed: newbuttonenbler == true && cards.gamebalance != 0
                        ? () {
                            setState(() {
                              showTextBelowPlayButton = false;
                              cards.generateWinningPosition();
                              playbuttonenabler = true;
                              newbuttonenbler = false;
                              img1 = 'images/game.png';
                              img2 = 'images/game.png';
                              img3 = 'images/game.png';
                              cards.a = 0;
                              cards.b = 0;
                              cards.c = 0;
                            });
                          }
                        : null,
                    shape: const CircleBorder(),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'New', // game new
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Where is the Flutter!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'Press "New" to play',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: isGameStarted
          ? null
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: FloatingActionButton(
                onPressed: () {
                  con.startGame(); // Call startGame from GameController
                },
                shape: const CircleBorder(),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'New',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CardHolder extends StatelessWidget {
  final num cardValue;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String imagepath;

  const CardHolder({
    Key? key,
    required this.cardValue,
    required this.onIncrement,
    required this.onDecrement,
    required this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagepath),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
              ),
              Text(
                '$cardValue',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  onIncrement();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
