import 'package:flutter/material.dart';

class GameController {
  // Callback function to trigger a state update
  final VoidCallback updateState;

  GameController(this.updateState);

  // Function to start the game
  void startGame() {
    updateState();
  }
}
