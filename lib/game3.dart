import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'endgame.dart';
import 'endgamealeatoire.dart';
import 'solo/solo.dart';

class Game3 extends StatefulWidget {
  final bool aleatoire;
  final int nbJeu;
  final int scoreJeu;

  const Game3(
      {Key? key,
      required this.aleatoire,
      required this.nbJeu,
      required this.scoreJeu})
      : super(key: key);

  @override
  _Game3State createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  Record myRecording = Record();
  Timer? timer;
  Timer? endTimer;
  bool isFinished = false;

  double volume = 0.0;
  double minVolume =
      -45.0; // ajuster la valeur minimale de volume en dB selon vos besoins

  startTimer() async {
    timer ??= Timer.periodic(
        const Duration(milliseconds: 50), (timer) => updateVolume());
    endTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isFinished = true;
        timer?.cancel();
        endTimer?.cancel();
        !widget.aleatoire
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EndGamePage(score: (volume * 10).round())))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EndGamePageAleatoire(
                        score: widget.scoreJeu + (volume * 10).round(),
                        nbJeu: widget.nbJeu)));
      });
    });
  }

  updateVolume() async {
    Amplitude ampl = await myRecording.getAmplitude();
    if (ampl.current > minVolume) {
      setState(() {
        volume = (ampl.current - minVolume) /
            (-minVolume); // normalisation du volume entre 0 et 1
      });
    }
  }

  Color _getColor(double volume) {
    if (volume < 0.25) {
      return Colors.green;
    } else if (volume < 0.5) {
      return Colors.yellow;
    } else if (volume < 0.75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget _buildLevelIndicator(BuildContext context) {
    final double width = MediaQuery.of(context).size.width *
        0.8; // ajuster la largeur de l'indicateur de volume selon vos besoins
    final double height = 20;
    final double borderRadius = height / 2;
    final double indicatorWidth = volume * width;
    final Color color = _getColor(volume);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: indicatorWidth,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${(volume * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors
                            .white, // ajuster la couleur du texte selon la couleur de fond
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> startRecording() async {
    if (await myRecording.hasPermission()) {
      if (!await myRecording.isRecording()) {
        await myRecording.start();
      }
      startTimer();
      return true;
    } else {
      return false;
    }
  }

  Widget _buildScore(BuildContext context) {
    final score = (volume * 100).toStringAsFixed(0);
    final message = isFinished
        ? 'Votre score final est de $score% !'
        : 'Criez le plus fort possible !';

    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Future<bool> recordFutureBuilder =
        Future<bool>.delayed(const Duration(seconds: 3), (() async {
      return startRecording();
    }));

    return FutureBuilder(
        future: recordFutureBuilder,
        builder: (context, AsyncSnapshot<bool> snapshot) {
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
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Score : ${widget.scoreJeu} pts',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: snapshot.hasData
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildScore(context),
                                const SizedBox(height: 100),
                                Text(
                                    "VOLUME\n${(volume * 100).toStringAsFixed(0)}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                const SizedBox(height: 30),
                                _buildLevelIndicator(context),
                              ],
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white),
                    ),
                  ],
                ),
              ));
        });
  }
}
