import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ttt/board.dart';
import 'package:ttt/grid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    )..repeat(
        reverse: true,
      );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Player player = Provider.of<Player>(
      context,
    );

    return Scaffold(
      backgroundColor: const Color(0xff18275e),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                // color: Colors.lightBlue,
                child: Text(
                  "Tic - Tac - Toe",
                  style: GoogleFonts.kanit().copyWith(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(4),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //user 1
                        Stack(
                          children: [
                            Image.asset(
                              "assets/uicon.png",
                              color: Colors.pink,
                            ),
                            Positioned(
                              top: 1.5,
                              left: 17.5,
                              child: Text(
                                player.user1.firstTurn ? "X" : "O",
                                style: GoogleFonts.kanit().copyWith(
                                  color: Color.fromARGB(255, 255, 204, 0),
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        scoreWidget(
                          score: player.user1.score,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: player.gameOver,
                      child: Text(
                        player.result,
                        style: GoogleFonts.acme().copyWith(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                    //user 2
                    Row(
                      children: [
                        scoreWidget(
                          score: player.user2.score,
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              "assets/uicon.png",
                              color: Color.fromARGB(255, 255, 204, 0),
                            ),
                            Positioned(
                              top: player.user2.firstTurn ? 6.5 : 6.5,
                              left: player.user2.firstTurn ? 19 : 17.5,
                              child: Text(
                                player.user2.firstTurn ? "X" : "O",
                                style: GoogleFonts.ubuntu().copyWith(
                                  color: Colors.pink,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 29,
              child: Container(
                width: 500,
                child: Grid(),
              ),
            ),
            Expanded(
              flex: 9,
              child: FadeTransition(
                opacity: _animation,
                child: GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      player.playAGain();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      // color: Colors.green,
                      child: Visibility(
                        child: Text(
                          "TAP TO PLAY AGAIN",
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7,
                          ),
                        ),
                        visible: player.gameOver,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class scoreWidget extends StatelessWidget {
  int score;
  scoreWidget({
    this.score = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        score.toString(),
        style: GoogleFonts.averiaSansLibre().copyWith(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
