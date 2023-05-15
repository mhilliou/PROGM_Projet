import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:progm_projet/adversaire.dart';
import 'package:progm_projet/solo/solo.dart';

import 'game1.dart';
import 'home.dart';

class EndGameMultiPage extends StatefulWidget {
  final int score;
  final int scoreAdversaire;
  final FlutterP2pConnection flutterP2pConnectionPlugin;
  final String? pseudo;
  final String? adversaire;
  final WifiP2PInfo? wifiP2PInfo;
  final AdversairePage? adversairePage;
  const EndGameMultiPage({Key? key, required this.score, required this.flutterP2pConnectionPlugin, this.pseudo, this.wifiP2PInfo, required this.scoreAdversaire, this.adversaire, this.adversairePage}) : super(key: key);

  State<EndGameMultiPage> createState() => _EndGameMultiPageState();
}

class _EndGameMultiPageState extends State<EndGameMultiPage> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01, right: screenWidth * 0.04),
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 136, 136)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            SizedBox(height: screenHeight * 0.25),
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
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'VOTRE SCORE : ${widget.score}',
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
                          'SCORE ADVERSAIRE : ${widget.scoreAdversaire}',
                          style: TextStyle(
                            fontSize: 0.05 * screenWidth,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 0.35 * screenWidth,
                  height: 0.12 * screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 95, 20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      
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
              ],
            ),
          ],
        ),
      ),
    );
  }
  

}
