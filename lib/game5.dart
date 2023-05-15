import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';


class Game5 extends StatefulWidget {
  final bool aleatoire;
  final int nbJeu;
  final int scoreJeu;

  const Game5({super.key, required this.aleatoire, required this.nbJeu, required this.scoreJeu});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Game5> {
  double _rotationAngle = 0.0;
  double _initialAngle = 0.0;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  List<double> _magnetometerValues = [0.0, 0.0, 0.0];
  List<double> _gyroscopeValues = [0.0, 0.0, 0.0];
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];

  @override
  void initState() {
    super.initState();
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = [event.x, event.y, event.z];
        _updateRotationAngle();
      });
    });

    _magnetometerSubscription = magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerValues = [event.x, event.y, event.z];
        _updateRotationAngle();
      });
    });

    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _updateRotationAngle();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _gyroscopeSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    _accelerometerSubscription?.cancel();
  }

  void _updateRotationAngle() {
    double pitch = atan2(
      _accelerometerValues[1],
      sqrt(pow(_accelerometerValues[0], 2) + pow(_accelerometerValues[2], 2)),
    );

    if (pitch.abs() <= 0.1) { // Vérifie si le téléphone est à plat (ajustez la valeur selon votre besoin)
      double rotation = atan2(
        _magnetometerValues[2],
        _magnetometerValues[0],
      );

      double degrees = rotation * (180 / pi);
      degrees -= _initialAngle;
      degrees %= 360;

      degrees += pitch * (180 / pi);
      degrees %= 360;

      setState(() {
        _rotationAngle = degrees;
      });
    }
  }

  void _resetRotationAngle() {
    setState(() {
      _initialAngle = _rotationAngle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Boussole'),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: _resetRotationAngle,
              child: Center(
                child: Transform.rotate(
                  angle: -_rotationAngle * (pi / 180),
                  child: Image.asset(
                    'assets/images/compass.jpg',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            Text('Angle: $_rotationAngle'),
          ],
        ),
      ),
    );
  }
}
