/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

class Game3 extends StatefulWidget {
  const Game3({super.key});

  @override
  State<Game3> createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  Record myRecording = Record();
  Timer? timer;

  double volume = 0.0;
  double minVolume = -45.0;

  startTimer() async {
    timer ??= Timer.periodic(
        const Duration(milliseconds: 50), (timer) => updateVolume());
  }

  updateVolume() async {
    Amplitude ampl = await myRecording.getAmplitude();
    if (ampl.current > minVolume) {
      setState(() {
        volume = (ampl.current - minVolume) / minVolume;
      });
    }
  }

  int volume0to(int maxVolumeToDisplay) {
    return (volume * maxVolumeToDisplay).round().abs();
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
            body: Center(
                child: snapshot.hasData
                    ? Text("VOLUME\n${volume0to(100)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 42, fontWeight: FontWeight.bold))
                    : const CircularProgressIndicator()),
          );
        });
  }
}*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class Game3 extends StatefulWidget {
  const Game3({Key? key}) : super(key: key);

  @override
  _Game3State createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  Record myRecording = Record();
  Timer? timer;
  double volume = 0.0;
  double minVolume = -45.0;

  startTimer() async {
    timer ??= Timer.periodic(
        const Duration(milliseconds: 50), (timer) => updateVolume());
  }

  updateVolume() async {
    Amplitude ampl = await myRecording.getAmplitude();
    if (ampl.current > minVolume) {
      setState(() {
        volume = (ampl.current - minVolume) / (0 - minVolume);
      });
    }
  }

  Widget _buildVolumeBar() {
    return LinearProgressIndicator(
      value: volume,
      backgroundColor: Colors.red[200],
      valueColor: AlwaysStoppedAnimation<Color>(
        volume > 0.5 ? Colors.red : Colors.green,
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
            body: Center(
              child: snapshot.hasData
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Volume: ${(volume * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24),
                        _buildVolumeBar(),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        });
  }
}*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'endgame.dart';
import 'solo/solo.dart';

class Game3 extends StatefulWidget {
  const Game3({Key? key}) : super(key: key);

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EndGamePage(score: (volume * 10).round())));
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
                                /*const SizedBox(height: 140),
                                SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          startTimer();
                                        },
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ))),
                                        child: const Text('START',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)))),*/
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

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:progm_projet/endgame.dart';
import 'package:record/record.dart';

import 'solo/solo.dart';

class Game3 extends StatefulWidget {
  const Game3({Key? key}) : super(key: key);

  @override
  _Game3State createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  Record myRecording = Record();
  Timer? timer;
  Timer? endTimer;
  bool isFinished = false;

  double volume = 0.0;
  double minVolume = -45.0; 

  @override
  void dispose() {
    myRecording.stop();
    timer?.cancel();
    endTimer?.cancel();
    super.dispose();
  }

  startTimer() async {
    timer ??= Timer.periodic(
        const Duration(milliseconds: 50), (timer) => updateVolume());
    endTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isFinished = true;
        timer?.cancel();
        endTimer?.cancel();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EndGamePage(score: (volume * 10).round())));
      });
    });
  }

  updateVolume() async {
    Amplitude ampl = await myRecording.getAmplitude();
    print("ampl $ampl");
    print("ampl.current ${ampl.current}");
    print("minVolume $minVolume");
    print("volume ${(ampl.current - minVolume) / (-minVolume)}");
    if (ampl.current > minVolume) {
      setState(() {
        volume = (ampl.current - minVolume) / (-minVolume); 
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
        0.8; // adjust the width of the volume indicator to suit your needs
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
                            .white, // adjust text color based on background color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                ],
              ),
              const SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildScore(context),
                  const SizedBox(height: 100),
                  Text("VOLUME\n${(volume*100).toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 30),
                  _buildLevelIndicator(context),
                  const SizedBox(height: 140),
                  SizedBox(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                          onPressed: () {
                            startTimer();
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
                          child: const Text('START',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)))),
                ],
              ),
            ],
          ),
        ));
  }
}
*/