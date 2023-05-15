import 'package:flutter/material.dart';
import 'package:progm_projet/endgame.dart';
import 'dart:math';

import 'solo/solo.dart';

class Game6 extends StatefulWidget {
  @override
  _Game6State createState() => _Game6State();
}

enum GestureStatus { none, right, up, left, down, doubleTap, tap, longPress }

class _Game6State extends State<Game6> {
  GestureStatus gestureStatus = GestureStatus.none;
  String currentCommand = '';
  String result = '';
  Random random = Random();
  int gesturesCount = 0;
  bool isGameFinished = false;
  bool isInverseCommand = false;
  List<String> previousCommands = [];
  int score = 0;


  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      gestureStatus = GestureStatus.none;
      currentCommand = getRandomCommand();
      result = '';
      gesturesCount = 0;
      isGameFinished = false;
    });
  }

  String getRandomCommand() {
  int randomNumber = random.nextInt(7);
  isInverseCommand = random.nextBool(); // Détermine aléatoirement si l'inverse d'une commande est demandée

  String command;
  do {
    switch (randomNumber) {
      case 0:
        command = (isInverseCommand) ? 'left' : 'right'; // Demande "faire l'inverse de glisser vers la droite"
        break;
      case 1:
        command = (isInverseCommand) ? 'down' : 'up'; // Demande "faire l'inverse de glisser vers le haut"
        break;
      case 2:
        command = (isInverseCommand) ? 'right' : 'left'; // Demande "faire l'inverse de glisser vers la gauche"
        break;
      case 3:
        command = (isInverseCommand) ? 'up' : 'down'; // Demande "faire l'inverse de glisser vers le bas"
        break;
      case 4:
        command = (isInverseCommand) ? 'tap' : 'doubleTap'; // Demande "faire l'inverse de double cliquer"
        break;
      case 5:
        command = (isInverseCommand) ? 'doubleTap' : 'tap'; // Demande "faire l'inverse de cliquer une fois"
        break;
      case 6:
        command = (isInverseCommand) ? 'longPress' : 'tap'; // Demande "faire l'inverse de presser longtemps l'écran"
        break;
      default:
        command = 'right';
    }
    randomNumber = random.nextInt(7);
  } while (previousCommands.contains(command)); // Vérifie si la commande a déjà été demandée

  return command;
}


  void checkGesture(String gesture) {
    if (isGameFinished) return;

    bool isCorrectGesture = false;

    if (isInverseCommand) {
      // Vérifie si l'utilisateur a effectué l'inverse de la commande demandée
      switch (currentCommand) {
        case 'right':
          isCorrectGesture = (gesture == 'left');
          break;
        case 'up':
          isCorrectGesture = (gesture == 'down');
          break;
        case 'left':
          isCorrectGesture = (gesture == 'right');
          break;
        case 'down':
          isCorrectGesture = (gesture == 'up');
          break;
        case 'tap':
          isCorrectGesture = (gesture == 'doubleTap');
          break;
        case 'doubleTap':
          isCorrectGesture = (gesture == 'tap');
          break;
        case 'longPress':
          isCorrectGesture = (gesture == 'tap');
          break;
      }
    } else {
      // Vérifie si l'utilisateur a effectué la commande demandée
      isCorrectGesture = (gesture == currentCommand);
    }

    setState(() {
      if (isCorrectGesture) {
        result = 'Geste correct';
        score++;
        gesturesCount++;
        if (gesturesCount == 5) {
          result = 'Jeu terminé';
          isGameFinished = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EndGamePage(score: score)),
          );
        } else {
          currentCommand = getRandomCommand();
        }
      }
      else {
        result = 'Geste incorrect';
        gesturesCount++;
        if (gesturesCount == 5) {
          result = 'Jeu terminé';
          isGameFinished = true;
        } else {
          currentCommand = getRandomCommand();
        }
      }
      previousCommands.add(currentCommand); // Ajoute la commande actuelle à la liste des commandes précédentes
    });
  }

@override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 71, 71),
    body: SafeArea(
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SoloPage()),
                  );
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.only(right: 0.03 * screenWidth),
                child: Text(
                  'Score : $score pts',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 0.04 * screenWidth,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 0.27 * screenHeight,
            padding: EdgeInsets.only(
              top: 0.1 * screenHeight,
              bottom: 0.05 * screenHeight,
            ),
            child: Text(
              (isInverseCommand)
                              ? 'Faire l\'inverse de : $currentCommand'
                              : 'Effectuez un geste : $currentCommand',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.06 * screenWidth,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 0.05 * screenHeight),
          GestureDetector(
          onHorizontalDragEnd: (details) {
            checkGesture((details.primaryVelocity! > 0) ? 'right' : 'left');
          },
          onVerticalDragEnd: (details) {
            checkGesture((details.primaryVelocity! < 0) ? 'up' : 'down');
          },
          onDoubleTap: () {
            checkGesture('doubleTap');
          },
          onTap: () {
            checkGesture('tap');
          },
          onLongPress: () {
            checkGesture('longPress');
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    color: const Color.fromARGB(255, 255, 136, 136),
                  ),
                  
                ),
                
              ],
            ),
          ),
        ),
        SizedBox(height: 0.05 * screenHeight),
        Container(
            height: 0.1 * screenHeight,
            alignment: Alignment.center,
            child: Text(
                result,
                style: TextStyle(
                  fontSize: 0.04 * screenWidth,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}

