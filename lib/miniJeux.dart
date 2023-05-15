import 'package:flutter/material.dart';

import 'game1.dart';
import 'game2.dart';
import 'game3.dart';
import 'game4.dart';
import 'game5.dart';
import 'game6.dart';
import 'game7.dart';
import 'solo/solo.dart';

class Card {
  final ImageProvider image;
  final String title;

  Card({required this.image, required this.title});
}

class MiniJeu extends StatelessWidget {
  final cards = [
    Card(image: AssetImage('assets/images/image1.png'), title: 'Quiz V'),
    Card(image: AssetImage('assets/images/image2.png'), title: 'Course V'),
    Card(image: AssetImage('assets/images/image3.png'), title: 'Voix X'),
    Card(image: AssetImage('assets/images/image4.png'), title: 'Plat V'),
    Card(image: AssetImage('assets/images/image5.png'), title: 'Angle X'),
    Card(image: AssetImage('assets/images/image6.png'), title: 'Gestes V'),
    Card(image: AssetImage('assets/images/image7.png'), title: 'Schéma X'),
    // ...
  ];

  void handleCardTap(String title, BuildContext context) {
    switch (title) {
      case 'Quiz V':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Game1()));
        break;
      case 'Course V':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game2()));
        break;
      case 'Voix X':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Game3()));
        break;
      case 'Plat V':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game4()));
        break;
      case 'Angle X':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game5()));
        break;
      case 'Gestes V':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game6()));
        break;
      case 'Schéma X':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game7()));
        break;
    }
  }

  Widget buildCard(Card card, BuildContext context) {
    return InkWell(
      onTap: () => handleCardTap(card.title, context),
      child: Column(
        children: [
          Image(image: card.image, width: 0.2 * MediaQuery.of(context).size.width, height: 0.2 * MediaQuery.of(context).size.width),
          Text(card.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SoloPage()));
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Nombre de carrés par ligne
                crossAxisSpacing: 0.02 * screenWidth, // Espacement horizontal entre les carrés
                mainAxisSpacing: 0.02 * screenWidth, // Espacement vertical entre les carrés
                children: cards.map((card) => buildCard(card, context)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
