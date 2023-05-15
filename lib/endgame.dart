import 'package:flutter/material.dart';
import 'package:progm_projet/solo/solo.dart';

import 'game1.dart';

class EndGamePage extends StatelessWidget {
  final int score;

  const EndGamePage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 0.3 * screenHeight),
            Column(
              children: [
                Container(
                  width: 0.8 * screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 136, 136),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'VOTRE SCORE',
                          style: TextStyle(
                            fontSize: 0.05 * screenWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '$score',
                          style: TextStyle(
                            fontSize: 0.08 * screenWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.35 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 0.35 * screenWidth,
                  height: 0.12 * screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 95, 20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Game1(aleatoire: false, nbJeu: 0, scoreJeu: 0)),
                      );
                    },
                    child: Text(
                      'REJOUER',
                      style: TextStyle(
                        fontSize: 0.04 * screenWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.35 * screenWidth,
                  height: 0.12 * screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 95, 20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SoloPage()),
                      );
                    },
                    child: Text(
                      'QUITTER',
                      style: TextStyle(
                        fontSize: 0.04 * screenWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
