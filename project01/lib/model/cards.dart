import 'dart:math';

class Cards {
  num gamebalance = 15;
  int winningPosition = Random().nextInt(3);
  String msgw = "";
  num a = 0;
  num b = 0;
  num c = 0;

  void generateWinningPosition() {
    winningPosition = Random().nextInt(3);
  }

  void winningmessage(num a, num b) {
    msgw = "You won:$a x 3=$b coin(s). Press <New> to start a new game.";
  }
}
