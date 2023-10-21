import 'package:flutter/material.dart';
import 'package:project01/view/game_screen.dart';

void main() {
  runApp(const FlutterGame());
}

class FlutterGame extends StatelessWidget {
  const FlutterGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: GameScreen.routeName,
      routes: {
        GameScreen.routeName: (context) => const GameScreen(),
      },
    );
  }
}
