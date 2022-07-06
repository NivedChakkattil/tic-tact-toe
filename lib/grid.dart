import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttt/board.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Player player = Provider.of<Player>(
      context,
    );
    Image? image(Player p, int index) {
      if (p.tile_value[index] == "x") {
        return Image.asset("assets/x.png");
      } else if (p.tile_value[index] == "o") {
        return Image.asset("assets/o.png");
      } else {
        return Image.asset(
          "assets/grid.png",
          color: Colors.transparent,
        );
      }
    }

    var tile_data = List.generate(
      9,
      (index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              player.changePlayer(index);
              player.checkGameOver();
              
            },
            child: Container(
              //color: Colors.white,
              alignment: Alignment.center,
              child: image(player, index),
            ),
          ),
        );
      },
    );

    //PlayerChange play = Provider.of<PlayerChange>(context);

    return Container(
      padding: const EdgeInsets.all(42),
      decoration: const BoxDecoration(
        //color: Colors.brown,
        image: DecorationImage(
          image: AssetImage("assets/grid.png"),
        ),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 21),
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        children: tile_data,
      ),
    );
  }
}
