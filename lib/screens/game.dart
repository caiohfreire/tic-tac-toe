import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/constants/colors.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool xTurn = true;
  bool showPlayAgain = false;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  String result = '🏆 Score Board 🏆';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                result,
                style: TextStyle(
                    fontSize: 32,
                    color: MainColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 4,
                            color: Colors.lightGreenAccent,
                          ),
                          color: MainColor.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 64.0,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Visibility(
            visible: showPlayAgain,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MainColor.primaryColor,
                        minimumSize: const Size(200, 50)),
                    onPressed: () {
                      _restart();
                    },
                    child: Text(
                      'Play again',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  void _tapped(int index) {
    if (showPlayAgain) {
      return;
    }

    setState(() {
      if (xTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
      } else if (!xTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
      } else {
        return;
      }

      xTurn = !xTurn;
      _checkWinner();

      if (showPlayAgain && displayXO[index] == '') {
        return;
      }
    });
  }

  void _checkWinner() {
    // Definindo as combinações de vitória em forma de índices
    List<List<int>> winConditions = [
      [0, 1, 2], // 1ª linha
      [3, 4, 5], // 2ª linha
      [6, 7, 8], // 3ª linha
      [0, 3, 6], // 1ª coluna
      [1, 4, 7], // 2ª coluna
      [2, 5, 8], // 3ª coluna
      [0, 4, 8], // Diagonal principal
      [2, 4, 6], // Diagonal secundária
    ];

    for (var condition in winConditions) {
      if (displayXO[condition[0]] == displayXO[condition[1]] &&
          displayXO[condition[0]] == displayXO[condition[2]] &&
          displayXO[condition[0]] != '') {
        setState(() {
          result = '🎉 Player ${displayXO[condition[0]]} Wins 🎉';
          showPlayAgain = true;
        });
        return;
      }
    }
  }

  void _restart() {
    setState(() {
      displayXO = ['', '', '', '', '', '', '', '', ''];
      xTurn = true;
      showPlayAgain = false;
      result = '🏆 Score Board 🏆';
    });
  }
}
