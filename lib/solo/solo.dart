import 'dart:math';
import 'package:flutter/material.dart';

import '../game1.dart';
import '../game2.dart';
import '../game3.dart';
import '../game4.dart';
import '../home.dart';
import '../miniJeux.dart';

class SoloPage extends StatefulWidget {
  const SoloPage({super.key});

  @override
  State<SoloPage> createState() => _SoloPageState();
}

class _SoloPageState extends State<SoloPage> {
  void choixJeu() {
    List<Widget> jeux = [Game1()];
    int index = Random().nextInt(jeux.length);
    Navigator.push(context, MaterialPageRoute(builder: (context) => jeux[index]));
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
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.01, right: screenWidth * 0.04),
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 136, 136)),
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
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    color: const Color.fromARGB(255, 255, 136, 136),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                        child: Text(
                          'MODE DE JEU',
                          style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.55,
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          color: const Color.fromARGB(255, 255, 95, 20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            choixJeu();
                          },
                          child: const Text('ALÉATOIRE', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: screenWidth * 0.55,
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          color: const Color.fromARGB(255, 255, 95, 20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MiniJeu()));
                          },
                          child: const Text('MINI-JEUX', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.25),
            TextButton(onPressed: () {
                
              }, child: const Text('REGLES DU JEU', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,color: Colors.black)), ),
          ],
        ),
      ),
    );
  }
}
