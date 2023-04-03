import 'package:flutter/material.dart';
import 'package:progm_projet/solo.dart';

import 'game1.dart';

class EndGamePage extends StatelessWidget {
  final int score;

  const EndGamePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 240),
            Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 136, 136)),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text('VOTRE SCORE',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text("$score",
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 95, 20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Game1()));
                      },
                      child: const Text('REJOUER',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
                Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 95, 20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SoloPage()));
                      },
                      child: const Text('QUITTER',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
