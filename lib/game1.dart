import 'dart:math';
import 'package:flutter/material.dart';
import 'solo.dart';
import 'endgame.dart';

class Game1 extends StatefulWidget {
  const Game1({super.key});

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  Quiz quiz = Quiz();

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndGamePage(score: scoreDef),
          ),
        );
        quiz.reset();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          MaterialPageRoute(
                              builder: (context) => const SoloPage()));
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'Score : ${quiz.score} pts',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.only(top: 70, bottom: 30),
                child: Text(
                  quiz.getQuestion(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                height: 90,
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(quiz.getAnswer1());
                  },
                  child: Text(
                    quiz.getAnswer1(),
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: 90,
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(quiz.getAnswer2());
                  },
                  child: Text(
                    quiz.getAnswer2(),
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: 90,
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(quiz.getAnswer3());
                  },
                  child: Text(
                    quiz.getAnswer3(),
                    style: const TextStyle(fontSize: 17, color: Colors.black),
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
        ));
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
    return score;
  }

  void reset() {
    score = 0;
    questionNumber = 0;
    alreadyAsked = [];
    statutReponse = '';
  }
}
