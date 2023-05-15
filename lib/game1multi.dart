import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:progm_projet/solo/solo.dart';
import 'adversaire.dart';
import 'endgame.dart';
import 'endgamealeatoire.dart';

int scoreF = 0;

class Game1Multi extends StatefulWidget {
  final bool aleatoire;
  final int nbJeu;
  final int scoreJeu;
  final FlutterP2pConnection flutterP2pConnectionPlugin;
  final String? pseudo;
  final WifiP2PInfo? wifiP2PInfo;
  final AdversairePage adversairePage;
  const Game1Multi({super.key, required this.aleatoire, required this.nbJeu, required this.scoreJeu, required this.flutterP2pConnectionPlugin, this.pseudo, this.wifiP2PInfo, required this.adversairePage});
  
  // récupérer la fonction getScore créé dans quiz
  int getScore() {
    print(scoreF);
    return scoreF;
  }

  @override
  State<Game1Multi> createState() => _Game1MultiState();
}

class _Game1MultiState extends State<Game1Multi> {
  Quiz quiz = Quiz();
  //AdversairePage? adversairePage;

  int score() {
    return quiz.score;
  }

  Future<void> isFinished() {
    print("finished");
    print(widget.adversairePage.flutterP2pConnectionPlugin.groupInfo().toString());
    return widget.adversairePage.callsendMessage('score:${quiz.score}');
  }

  void checkAnswer(String answer) {
    if (answer == quiz.getCorrectAnswer()) {
      quiz.score++;
      quiz.displayBonneReponse();
    } else {
      quiz.displayMauvaiseReponse();
    }
    setState(() {});
    Future.delayed(const Duration(seconds: 1), () {
      quiz.resetStatutReponse();
      quiz.nextQuestion();
      if (quiz.isFinished()) {
        int scoreDef = quiz.getScore();
        isFinished();
        /*!widget.aleatoire ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndGamePage(score: scoreDef),
          ),
        ) : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndGamePageAleatoire(score: widget.scoreJeu + scoreDef, nbJeu: widget.nbJeu)),
        );*/
        quiz.reset();
      }
      setState(() {});
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
                  'Score : ${quiz.score+widget.scoreJeu} pts',
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
              quiz.getQuestion(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.06 * screenWidth,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 0.1 * screenHeight,
            padding: EdgeInsets.only(
              left: 0.1 * screenWidth,
              right: 0.1 * screenWidth,
              bottom: 0.05 * screenHeight,
            ),
            child: ElevatedButton(
              onPressed: () {
                checkAnswer(quiz.getAnswer1());
              },
              child: Text(
                quiz.getAnswer1(),
                style: TextStyle(
                  fontSize: 0.04 * screenWidth,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: 0.1 * screenHeight,
            padding: EdgeInsets.only(
              left: 0.1 * screenWidth,
              right: 0.1 * screenWidth,
              bottom: 0.05 * screenHeight,
            ),
            child: ElevatedButton(
              onPressed: () {
                checkAnswer(quiz.getAnswer2());
              },
              child: Text(
                quiz.getAnswer2(),
                style: TextStyle(
                  fontSize: 0.04 * screenWidth,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: 0.1 * screenHeight,
            padding: EdgeInsets.only(
              left: 0.1 * screenWidth,
              right: 0.1 * screenWidth,
              bottom: 0.05 * screenHeight,
            ),
            child: ElevatedButton(
              onPressed: () {
                checkAnswer(quiz.getAnswer3());
              },
              child: Text(
                quiz.getAnswer3(),
                style: TextStyle(
                  fontSize: 0.04 * screenWidth,
                  color: Colors.black,
                ),
              ),
            ),
          ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  quiz.getStatutReponse(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ), // Pour afficher le message de bonne ou mauvaise réponse
            ],
          ),
      ),
  );
}

}

class Question {
  String question;
  String answer1;
  String answer2;
  String answer3;
  String correctAnswer;

  Question(this.question, this.answer1, this.answer2, this.answer3,
      this.correctAnswer);
}

class Quiz {
  List<Question> questions = [
    Question(
        'Quel est le 6e Président de la Ve République française ?',
        'Jacques Chirac',
        'Nicolas Sarkozy',
        'Emmanuel Macron',
        'Nicolas Sarkozy'),
    Question('Choisissez la bonne orthographe', 'Cyrose', 'Cirrhose', 'Cirrose',
        'Cirrhose'),
    Question(
        'Quel film détient aujourd’hui le plus gros succès mondial au box office ?',
        'Avatar',
        'Titanic',
        'Avengers: Endgame',
        'Avatar'),
    Question('Quelle est la capitale économique de la Suisse ?', 'Genève',
        'Zurich', 'Berne', 'Zurich'),
    Question('Quel est le plus grand océan du monde ?', 'Océan Pacifique',
        'Océan Atlantique', 'Océan Indien', 'Océan Pacifique'),
    Question(
        'Quel chanteur ou chanteuse est l’interprète de "Shape Of You", sorti en 2017 ?',
        'Adèle',
        'Drake',
        'Ed Sheeran',
        'Ed Sheeran'),
    Question(
        'Laquelle de ces fables de La Fontaine n’existe pas ?',
        'Le Berger et la Mer',
        'Le Berger et le Chien',
        'Le Berger et le Roi',
        'Le Berger et le Chien'),
    Question('Quel est le nom du premier homme à avoir marché sur la Lune ?',
        'Neil Armstrong', 'Buzz Aldrin', 'Michael Collins', 'Neil Armstrong'),
    Question(
        'En combien de temps auraient été construites les pyramides égyptiennes ?',
        'Entre 20 et 25 ans',
        'Entre 10 et 15 ans',
        'Entre 25 et 35 ans',
        'Entre 20 et 25 ans'),
    Question(
        'Quelle cérémonie récompense le monde de la musique aux USA ?',
        'Les Baftas',
        'Les Golden Globes',
        'Les Grammy Awards',
        'Les Grammy Awards'),
    Question('Au football, qui est le meilleur buteur de tous les temps ?',
        'Josef Bican', 'Cristiano Ronaldo', 'Pelé', 'Josef Bican'),
    Question('Quel animal est l’emblème du Royaume-Uni ?', 'Le dauphin',
        'Le lion', 'Le phoque', 'Le lion'),
    Question('Quelle est la capitale de la Jordanie ?', 'Zarka', 'Jérusalem',
        'Amman', 'Amman'),
    Question('Qui a gagné la coupe du monde de rugby à 15 en 2007 ?',
        'Afrique du Sud', 'Nouvelle-Zélande', 'France', 'L’Afrique du Sud'),
    Question(
        'Dans quel film Disney, la princesse s’appelle-t-elle Mérida ?',
        'La Belle et la Bête',
        'Rebelle',
        'La Belle au bois dormant',
        'Rebelle'),
    Question('Quelle était la fonction du Louvre avant de devenir un musée ?',
        'Une prison', 'Un palais', 'Une gare', 'Un palais'),
    Question('Combien de litres constituent 1 mètre cube d\'eau ?',
        '100 litres', '1 000 litres', '10 000 litres', '1 000 litres'),
    Question('Comment appelle-t-on les habitants de la ville de Saint-Malo ?',
        'Les Saint-Malinais', 'Les Saint-Lo', 'Les Malouins', 'Les Malouins'),
    Question(
        'En quelle année la télévision est passée du noir et blanc à la couleur ?',
        '1951',
        '1967',
        '1979',
        '1967'),
    Question('Quelle est la monnaie en Algérie ?', 'Le dinar', 'Le dirham',
        'Le franc algérien', 'Le dinar'),
  ];
  int score = 0;
  int questionNumber = 0;
  List<int> alreadyAsked = [];
  String statutReponse = '';

  Quiz() {
    questionNumber = Random().nextInt(questions.length);
    alreadyAsked.add(questionNumber);
  }

  String getAnswer1() {
    return questions[questionNumber].answer1;
  }

  String getAnswer2() {
    return questions[questionNumber].answer2;
  }

  String getAnswer3() {
    return questions[questionNumber].answer3;
  }

  String getQuestion() {
    return questions[questionNumber].question;
  }

  String getCorrectAnswer() {
    return questions[questionNumber].correctAnswer;
  }

  String getStatutReponse() {
    return statutReponse;
  }

  void resetStatutReponse() {
    statutReponse = '';
  }

  bool isFinished() {
    return alreadyAsked.length == 10;
  }

  void nextQuestion() {
    if (alreadyAsked.length < 10) {
      questionNumber = Random().nextInt(questions.length);
      while (alreadyAsked.contains(questionNumber)) {
        questionNumber = Random().nextInt(questions.length);
      }
      alreadyAsked.add(questionNumber);
    }
  }

  void displayBonneReponse() {
    statutReponse = 'Bonne réponse !';
  }

  void displayMauvaiseReponse() {
    statutReponse = 'Mauvaise réponse !';
  }

  int getScore() {
    scoreF = score;
    return score;
  }

  void reset() {
    score = 0;
    questionNumber = 0;
    alreadyAsked = [];
    statutReponse = '';
  }
}
