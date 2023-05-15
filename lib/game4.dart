import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'endgame.dart';
import 'solo/solo.dart';

class Game4 extends StatefulWidget {
  @override
  _Game4State createState() => _Game4State();
}

class _Game4State extends State<Game4> {
  AccelerometerEvent? _accelerometerValues;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  int _countdown = 3;

  bool _isPhoneFlat = false;
  bool _isPhoneFlatImmediate = false;
  late DateTime _phoneFlatStartTime;
  Timer? _phoneFlatTimer;

  static const double SEUIL = 9.5;
  static const Duration PHONE_FLAT_DURATION = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = event;
        if (!_isPhoneFlat &&
            _accelerometerValues != null &&
            _accelerometerValues!.z <= SEUIL) {
          _phoneFlatStartTime = DateTime.now();
          _phoneFlatTimer?.cancel();
          _phoneFlatTimer = Timer(PHONE_FLAT_DURATION, () {
            _isPhoneFlat = true;
            _isPhoneFlatImmediate =
                true; // Réinitialiser immédiatement l'état du téléphone
            _navigateToEndGame();
          });
        } else if (_isPhoneFlat &&
            _accelerometerValues != null &&
            _accelerometerValues!.z > SEUIL) {
          _phoneFlatTimer?.cancel();
          _isPhoneFlat = false;
        }
        _isPhoneFlatImmediate = !(_isPhoneFlat ||
            (_accelerometerValues != null && _accelerometerValues!.z <= SEUIL));
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _phoneFlatTimer?.cancel();
    super.dispose();
  }

  void _navigateToEndGame() {
    var score = 0;
    if (_phoneFlatStartTime != null) {
      var elapsedTime = DateTime.now().difference(_phoneFlatStartTime);
      if (elapsedTime >= PHONE_FLAT_DURATION) {
        score = 3;
      } else if (elapsedTime >= Duration(seconds: 2)) {
        score = 2;
      } else {
        score = 1;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EndGamePage(score: score)),
    );
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        setState(() {
          _countdown = 0;
        });

        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              ],
            ),
            Center(
              child: _countdown > 0
                  ? Column(
                      children: [
                        SizedBox(height: 0.3 * screenHeight),
                        Text(
                          '$_countdown',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 0.15 * screenWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 0.2 * screenHeight),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.05 * screenWidth),
                          child: Text(
                            'Posez votre téléphone le plus vite possible sur une surface plane pendant 3 secondes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 0.05 * screenWidth,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.1 * screenHeight),
                        Icon(
                          _isPhoneFlatImmediate
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 0.17 * screenWidth,
                          color:
                              _isPhoneFlatImmediate ? Colors.green : Colors.black,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
