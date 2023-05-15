import 'package:flutter/material.dart';
import 'endgame.dart';
import 'solo/solo.dart';


class Game2 extends StatefulWidget {
  @override
  _Game2State createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  double _pionPosition = 0.0;
  double _ligneArrivee = 300.0;
  Stopwatch _stopwatch = Stopwatch();
  Duration _tempsEcoule = Duration();


  void _avancerPion() {
  setState(() {
    _pionPosition += 10.0; // Vous pouvez ajuster la valeur d'incrémentation ici

    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }

    if (_pionPosition >= _ligneArrivee) {
      _pionPosition = _ligneArrivee;
      _stopwatch.stop();
      _tempsEcoule = _stopwatch.elapsed;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EndGamePage(score: 0)),
      );
      //_afficherMessageVictoire();
    }
  });
  }


  void _afficherMessageVictoire() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String tempsFormate =
          '${_tempsEcoule.inSeconds}.${(_tempsEcoule.inMilliseconds % 1000).toString().padLeft(3, '0')}';
      return AlertDialog(
        title: Text('Victoire !'),
        content: Text('Vous avez atteint la ligne d\'arrivée en $tempsFormate secondes.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }



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
                  'Score : ... pts',
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
            height: 0.25 * screenHeight,
            padding: EdgeInsets.only(
              top: 0.1 * screenHeight,
            ),
            child: Text(
              'Appuyez sur le bouton pour remplir la barre',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.06 * screenWidth,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
                children: [
                  Container(
                    height: 0.05 * screenHeight,
                    width: _ligneArrivee,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                  ),
                  Container(
                    height: 0.05 * screenHeight,
                    width: _pionPosition,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 136, 136),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                  )
                ],
              ),
          ),
          SizedBox(height: 0.05 * screenHeight),
          Container(
            height: 0.1 * screenHeight,
            padding: EdgeInsets.only(
              left: 0.35 * screenWidth,
              right: 0.35 * screenWidth,
              bottom: 0.05 * screenHeight,
            ),
            child: ElevatedButton(
              onPressed: () {
                _avancerPion();
              },
              child: Text(
                'Avancer',
                style: TextStyle(
                  fontSize: 0.04 * screenWidth,
                  color: Colors.black,
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
