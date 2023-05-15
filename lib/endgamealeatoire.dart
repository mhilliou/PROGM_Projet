import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progm_projet/solo/solo.dart';

import 'game1.dart';
import 'game2.dart';
import 'game3.dart';
import 'game4.dart';
import 'game5.dart';
import 'game6.dart';
import 'game7.dart';

class EndGamePageAleatoire extends StatelessWidget {
  final int score;
  final int nbJeu;

  const EndGamePageAleatoire(
      {Key? key,
      required this.score,
      required this.nbJeu})
      : super(key: key);

  bool isFinished() {
    print(nbJeu);
    return nbJeu == 3;
  }

  Widget choixJeu() {
    bool aleatoire = true;
    List<Widget> jeux = [
      Game1(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      Game2(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      //Game3(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      Game4(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      //Game5(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      Game6(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
      //Game7(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score),
    ];
    int index = Random().nextInt(jeux.length);
    return jeux[index];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: !isFinished()
            ? ListView(
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
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
                  Align(
                    alignment: Alignment.center,
                    child: Container(
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
                              MaterialPageRoute(
                                  builder: (context) => choixJeu()/*Game1(aleatoire: true, nbJeu: nbJeu + 1, scoreJeu: score)*/));
                        },
                        child: Text(
                          'SUIVANT',
                          style: TextStyle(
                            fontSize: 0.04 * screenWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  SizedBox(height: 0.17 * screenHeight),
                  Text('BIEN JOUÉ !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 0.05 * screenWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  SizedBox(height: 0.02 * screenHeight),
                  Text(
                      'Le jeu est terminé, vous êtes parvenu à réaliser les 3 défis proposés !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 0.05 * screenWidth,
                        color: Colors.white,
                      )),
                  SizedBox(height: 0.1 * screenHeight),
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
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
                  SizedBox(height: 0.25 * screenHeight),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
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
                            MaterialPageRoute(builder: (context) => SoloPage()),
                          );
                        },
                        child: Text(
                          'TERMINER',
                          style: TextStyle(
                            fontSize: 0.04 * screenWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
