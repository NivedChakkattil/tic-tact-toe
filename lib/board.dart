import 'package:flutter/material.dart';

class Player extends ChangeNotifier {
  bool xTurn = true;
  bool gameOver = false;
  int turns = 0;
  User user1 = User(
    firstTurn: true,
    lastTurn: false,
  );
  User user2 = User(
    firstTurn: false,
    lastTurn: true,
  );
  String result = "";
  changePlayer(int index) {
    if (!gameOver) {
      if (tile_value[index] == index.toString()) {
        user1.lastTurn = !user1.lastTurn;
        user2.lastTurn = !user2.lastTurn;
        turns += 1;
        if (xTurn) {
          tile_value[index] = "x";
          xTurn = !xTurn;
          print(tile_value);
          notifyListeners();
        } else {
          tile_value[index] = "o";
          xTurn = !xTurn;
          print(tile_value);
          notifyListeners();
        }
      }
    }
  }

  checkGameOver() {
    if (
        //horizontal
        tile_value[0] == tile_value[1] && tile_value[1] == tile_value[2] ||
            tile_value[3] == tile_value[4] && tile_value[4] == tile_value[5] ||
            tile_value[6] == tile_value[7] && tile_value[7] == tile_value[8] ||
            //vertical
            tile_value[0] == tile_value[3] && tile_value[3] == tile_value[6] ||
            tile_value[1] == tile_value[4] && tile_value[4] == tile_value[7] ||
            tile_value[2] == tile_value[5] && tile_value[5] == tile_value[8] ||
            //diagonal
            tile_value[0] == tile_value[4] && tile_value[4] == tile_value[8] ||
            tile_value[2] == tile_value[4] && tile_value[4] == tile_value[6]) {
      final String winner = xTurn ? "O" : "X";

      result = winner + " WON";
      gameOver = true;
      if (user1.lastTurn) {
        user1.score += 1;
      }
      if (user2.lastTurn) {
        user2.score += 1;
      }
      user1.firstTurn = !user1.firstTurn;
      user2.firstTurn = !user2.firstTurn;

      notifyListeners();
      return;
    }
    if (turns == 9) {
      gameOver = true;
      result = "DRAW";
      notifyListeners();
    }
    if (gameOver) {
      
    }
  }

  var tile_value = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
  ];

  playAGain() {
    xTurn = true;
    gameOver = false;
    tile_value = List.generate(9, (index) => index.toString());
    turns = 0;
    notifyListeners();
  }
}

class User {
  bool firstTurn;
  bool lastTurn;
  int score;
  User({
    required this.firstTurn,
    required this.lastTurn,
    this.score = 0,
  });
}
